import 'package:mongo_dart/mongo_dart.dart';
import 'package:dotenv/dotenv.dart';
import 'dart:convert';
import 'dart:io';

void main() async {
  final env = DotEnv()..load();
  final mongoURI = env['MONGO_URI'];

  if (mongoURI == null || mongoURI.isEmpty) {
    throw Exception("MongoDB connection string not found in .env");
  }

  final db = Db(mongoURI);
  await db.open();
  final collection = db.collection("products");
  final file = File('dummy-products.json');

  if (!file.existsSync()) {
    throw Exception("File 'products.json' not found.");
  }

  final jsonData = jsonDecode(file.readAsStringSync()) as List<dynamic>;
  final products = jsonData.map((e) => Map<String, dynamic>.from(e)).toList();

  await collection.insertAll(products);
  await db.close();
}
