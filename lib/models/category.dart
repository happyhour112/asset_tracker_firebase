import 'package:flutter/material.dart';

enum Categories {
  layer1,
  layer2,
  stablecoins,
  privacy,
  meme,
  dex,
  gaming,
  ai,
  oracle,
  nft,
  defi,
  dao,
}

class Category {
  const Category(this.title, this.color);

  final String title;
  final Color color;
}
