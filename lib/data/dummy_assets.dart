import 'package:asset_tracker/models/category.dart';
import 'package:asset_tracker/models/my_asset.dart';
import 'package:asset_tracker/data/categories.dart';

final myDummyAssets = [
  MyAsset(
    id: 'a',
    name: 'BTC',
    quantity: 0.5,
    buyPrice: 30000,
    category: categories[Categories.layer1]!,
  ),
  MyAsset(
    id: 'b',
    name: 'USDT',
    quantity: 200,
    buyPrice: 200,
    category: categories[Categories.stablecoins]!,
  ),
  MyAsset(
    id: 'c',
    name: 'DOGE',
    quantity: 0.5,
    buyPrice: 0.2,
    category: categories[Categories.meme]!,
  ),
];
