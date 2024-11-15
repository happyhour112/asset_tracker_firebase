import 'package:asset_tracker/models/category.dart';

class MyAsset {
  MyAsset({
    required this.id,
    required this.name,
    required this.quantity,
    required this.buyPrice,
    required this.category,
  });

  final String id;
  final String name;
  double quantity;
  final double buyPrice;
  final Category category;

  double averagePrice = 0.0;
  List<double> listBuyPrice = [];
  List<double> listBuySize = [];

  get getAveragePrice {
    if (listBuyPrice.isEmpty || listBuySize.isEmpty) return averagePrice;

    double totalCost = 0.0;
    for (var i = 0; i < listBuyPrice.length; i++) {
      totalCost += listBuyPrice[i] * listBuySize[i];
    }

    return totalCost / getTotalSize;
  }

  get getTotalSize {
    if (listBuySize.isEmpty) return quantity;

    double totalSize = 0.0;
    for (var i = 0; i < listBuySize.length; i++) {
      totalSize += listBuySize[i];
    }
    return totalSize;
  }

  set addPrice(double price) {
    listBuyPrice.add(price);
  }

  set addSize(double size) {
    listBuySize.add(size);
  }
}
