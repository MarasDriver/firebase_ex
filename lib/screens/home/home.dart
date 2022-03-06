import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_exmle/screens/home/widgets/car_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/data/providers/auth_state.dart';
import 'data/models/cars_model.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  List<String> documentsID = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () =>
                Provider.of<AuthState>(context, listen: false).signOut(),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("cars").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<Cars> _listOfCars =
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Cars.fromJson(data);
                  }).toList();

                  documentsID =
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return document.id;
                  }).toList();

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _listOfCars.length,
                      itemBuilder: (context, index) {
                        Cars _car = _listOfCars[index];
                        return listItem(_car, documentsID[index], context);
                      });
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Cars data = Cars(
            brand: "mastodont",
            model: "V3",
          );
          FirebaseFirestore.instance.collection("cars").add(data.toJson());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget listItem(Cars car, docID, context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd ||
            direction == DismissDirection.endToStart)
          FirebaseFirestore.instance.collection("cars").doc(docID).delete();
      },
      child: ListTile(
        title: Text(car.brand!),
        subtitle: Text(car.model!),
        trailing: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => Dialog(
                      child: CarModal(
                        car: car,
                        docID: docID,
                      ),
                    ));
          },
          icon: Icon(Icons.edit),
        ),
      ),
    );
  }
}
