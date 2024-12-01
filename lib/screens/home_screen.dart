import 'package:asset_tracker/models/my_asset.dart';
import 'package:asset_tracker/data/dummy_assets.dart';
import 'package:asset_tracker/screens/new_asset_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<MyAsset> _assetList = [];
  var f = NumberFormat("#,###.###", "en_US");

  void _addItem() async {
    final MyAsset newAsset = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewAssetScreen(),
      ),
    );

    final assetIndex =
        _assetList.indexWhere((element) => element.name == newAsset.name);

    if (assetIndex >= 0) {
      _assetList[assetIndex].addPrice = newAsset.buyPrice;
      _assetList[assetIndex].addSize = newAsset.quantity;
      setState(() {
        _assetList[assetIndex].quantity = _assetList[assetIndex].getTotalSize;
        _assetList[assetIndex].averagePrice =
            _assetList[assetIndex].getAveragePrice;
      });
    } else {
      setState(() {
        _assetList.add(newAsset);
        _assetList[_assetList.length - 1].addPrice = newAsset.buyPrice;
        _assetList[_assetList.length - 1].addSize = newAsset.quantity;
        _assetList[_assetList.length - 1].averagePrice = newAsset.buyPrice;
      });
    }
  }

  void _removeItem(MyAsset asset) {
    final assetIndex = _assetList.indexOf(asset);
    setState(() {
      _assetList.remove(asset);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Asset deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _assetList.insert(assetIndex, asset);
            });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    if (_assetList.isEmpty) {
      _assetList.addAll(myDummyAssets);

      for (int i = 0; i < _assetList.length; i++) {
        _assetList[i].addPrice = _assetList[i].buyPrice;
        _assetList[i].addSize = _assetList[i].quantity;
        _assetList[i].averagePrice = _assetList[i].buyPrice;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added'));

    if (_assetList.isNotEmpty) {
      content = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView.separated(
          itemCount: _assetList.length,
          itemBuilder: (ctx, index) => Dismissible(
            onDismissed: (direction) {
              _removeItem(_assetList[index]);
            },
            key: ValueKey(_assetList[index].id),
            child: ListTile(
              title: Text(_assetList[index].name),
              subtitle: Text(_assetList[index].getTotalSize.toString()),
              leading: Container(
                width: 24,
                height: 24,
                color: _assetList[index].category.color,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Average Price'),
                  Text(
                    '\$ ${f.format(_assetList[index].averagePrice)}',
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
    }

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
              GoogleSignIn().disconnect();
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: content,
    );
  }
}
