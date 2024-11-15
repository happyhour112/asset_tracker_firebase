import 'package:flutter/material.dart';
import 'package:asset_tracker/models/category.dart';

const categories = {
  Categories.ai: Category(
    'Artificial Intelligence',
    Color.fromARGB(255, 26, 188, 156),
  ),
  Categories.dao: Category(
    'Decentralized Autonomous Organization',
    Color.fromARGB(255, 44, 62, 80),
  ),
  Categories.defi: Category(
    'Decentralized Finance',
    Color.fromARGB(255, 22, 160, 133),
  ),
  Categories.dex: Category(
    'Decentralized Exchange',
    Color.fromARGB(255, 142, 68, 173),
  ),
  Categories.gaming: Category(
    'Gaming and Metaverse',
    Color.fromARGB(255, 231, 76, 60),
  ),
  Categories.layer1: Category(
    'Layer-1 Blockchains',
    Color.fromARGB(255, 255, 87, 51),
  ),
  Categories.layer2: Category(
    'Layer-2 Solutions',
    Color.fromARGB(255, 41, 128, 185),
  ),
  Categories.meme: Category(
    'Meme Coins',
    Color.fromARGB(255, 243, 156, 18),
  ),
  Categories.nft: Category(
    'Non-Fungible Tokens',
    Color.fromARGB(255, 155, 89, 182),
  ),
  Categories.oracle: Category(
    'Oracle and Data Services',
    Color.fromARGB(255, 241, 196, 15),
  ),
  Categories.privacy: Category(
    'Privacy Coins',
    Color.fromARGB(255, 52, 73, 94),
  ),
  Categories.stablecoins: Category(
    'Stablecoins',
    Color.fromARGB(255, 46, 204, 113),
  ),
};
