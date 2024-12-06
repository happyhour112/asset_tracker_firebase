import 'package:asset_tracker/screens/new_asset_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var f = NumberFormat("#,###.###", "en_US");

  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewAssetScreen(),
      ),
    );
  }

  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Asset Tracker'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              //GoogleSignIn().disconnect();
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('assets')
            .orderBy('created_date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No items added'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.separated(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(index),
                onDismissed: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    await FirebaseFirestore.instance
                        .collection('assets')
                        .doc(snapshot.data!.docs[index].id)
                        .delete();
                  }
                },
                child: ListTile(
                  title: Text(snapshot.data!.docs[index].data()['name']),
                  subtitle: Text(
                      snapshot.data!.docs[index].data()['quantity'].toString()),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color:
                        hexToColor(snapshot.data!.docs[index].data()['color']),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Buy Price'),
                      Text(
                        '\$ ${f.format(snapshot.data!.docs[index].data()['buyPrice'])}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          );
        },
      ),
    );
  }
}
