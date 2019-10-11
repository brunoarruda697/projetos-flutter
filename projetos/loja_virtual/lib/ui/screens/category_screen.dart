import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/ui/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    // default tab controller é pra gerenciar as tabs
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data["title"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection("products")
                .document(snapshot.documentID)
                .collection("items")
                .getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  // faz com que não possa rolar para a pag do lado
                  children: <Widget>[
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 0.65),
                      itemBuilder: (context, index) {
                        ProductData data = ProductData.fromDocument(
                            snapshot.data.documents[index]);
                        data.category = this.snapshot.documentID;
                        return ProductTile("grid", data);
                      },
                      itemCount: snapshot.data.documents.length,
                    ),
                    ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemBuilder: (context, index) {
                        ProductData data = ProductData.fromDocument(
                            snapshot.data.documents[index]);
                        data.category = this.snapshot.documentID;
                        return ProductTile("list", data);
                      },
                      itemCount: snapshot.data.documents.length,
                    )
                  ],
                );
              }
            },
          )),
    );
  }
}
