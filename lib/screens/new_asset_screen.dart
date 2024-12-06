import 'package:asset_tracker/data/categories.dart';
import 'package:asset_tracker/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewAssetScreen extends StatefulWidget {
  const NewAssetScreen({super.key});

  @override
  State<NewAssetScreen> createState() => _NewAssetScreenState();
}

class _NewAssetScreenState extends State<NewAssetScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 0.1;
  var _enteredBuyPrice = 1.0;
  var _selectedCategory = categories[Categories.layer1]!;

  String colorToHex(Color color) {
    return '#${color.alpha.toRadixString(16).padLeft(2, '0')}'
        '${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

  Future<void> submitToDb() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        FirebaseFirestore.instance.collection('assets').add({
          'name': _enteredName,
          'quantity': _enteredQuantity,
          'buyPrice': _enteredBuyPrice,
          'catTitle': _selectedCategory.title,
          'color': colorToHex(_selectedCategory.color),
          'created_date': DateTime.now(),
        });
      } catch (e) {
        //print(e);
      }
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new asset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Asset Name'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _enteredName = newValue!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredQuantity.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null ||
                            double.tryParse(value)! <= 0) {
                          return 'Must be a valid, positive number';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredQuantity = double.tryParse(newValue!)!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      value: _selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    category.value.title,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Buy Price'),
                  prefixText: '\$ ',
                ),
                keyboardType: TextInputType.number,
                initialValue: _enteredBuyPrice.toString(),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null ||
                      double.tryParse(value)! <= 0) {
                    return 'Must be a valid, positive number';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _enteredBuyPrice = double.tryParse(newValue!)!;
                },
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: submitToDb,
                    child: const Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
