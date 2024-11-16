import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MongoDB {
  static Db? _instance;
  MongoDB._internal();

  static Future<Db> getInstance() async {
    _instance ??= await MongoDB.connect();
    return _instance!;
  }

  static Future<Db> connect() async {
    try {
      await dotenv.load();
      final mongoURI = dotenv.env["MONGO_URI"];
      if (mongoURI == null || mongoURI.isEmpty) {
        throw Exception("MongoDB connection string not found in .env");
      }

      final db = Db(mongoURI);
      await db.open();

      if (kDebugMode) {
        print("Connected to MongoDB");
      }

      return db;
    } catch (e) {
      if (kDebugMode) {
        print("Error connecting to MongoDB: $e");
      }
      rethrow;
    }
  }

  static Future<void> add(
    String collectionName,
    Map<String, dynamic> document,
  ) async {
    try {
      final db = await getInstance();
      final collection = db.collection(collectionName);
      await collection.insertOne(document);
    } catch (e) {
      if (kDebugMode) {
        print("Error adding document: $e");
      }
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> findById(
    String collectionName,
    String id,
  ) async {
    try {
      final objectId = ObjectId.tryParse(id);

      if (objectId == null) {
        if (kDebugMode) {
          print("Invalid ObjectId format: $id");
        }
        return null;
      }

      final db = await getInstance();
      final collection = db.collection(collectionName);
      final document = await collection.findOne(where.id(objectId));

      if (document == null) {
        if (kDebugMode) {
          print("Document not found");
        }
      }

      return document;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching document by ID: $e");
      }
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> find(
    String collectionName,
  ) async {
    final db = await getInstance();
    final collection = db.collection(collectionName);
    return await collection.find().toList();
  }

  static Future<void> update(
    String collectionName,
    String id,
    Map<String, dynamic> updatedFields,
  ) async {
    try {
      final objectId = ObjectId.tryParse(id);
      if (objectId == null) {
        if (kDebugMode) {
          print("Invalid ObjectId format: $id");
        }
        return;
      }

      final modifier = ModifierBuilder();

      updatedFields.forEach((key, value) {
        modifier.set(key, value);
      });

      final db = await getInstance();
      final collection = db.collection(collectionName);
      await collection.updateOne(
        where.id(objectId),
        modifier,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error updating document: $e");
      }
      rethrow;
    }
  }

  static Future<void> deleteById(
    String collectionName,
    String id,
  ) async {
    try {
      final db = await getInstance();
      final collection = db.collection(collectionName);
      await collection.deleteOne(where.id(ObjectId.parse(id)));
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting document: $e");
      }
      rethrow;
    }
  }

  static Future<void> close() async {
    await _instance?.close();

    if (kDebugMode) {
      print("Connection closed");
    }
  }
}
