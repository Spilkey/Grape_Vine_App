import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  static Future<FirebaseFirestore> _database;

  Future<FirebaseFirestore> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore;
  }
}

// final products = Firestore.instance.collection('products');
// return StreamBuilder<QuerySnapshot>(
//   stream: products.snapshots(),
//   builder: (context, snapshot) {
//     if (!snapshot.hasData)
//       return LinearProgressIndicator();

//     return ListView(
//   	   children: snapshot.data.documents.map((document) {
// 			final product = Product.fromMap(document.data);
//          return Text(product.name);
//       }).toList(),
//     );
//   },
// );
