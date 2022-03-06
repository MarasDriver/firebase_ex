import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../data/models/cars_model.dart';

class CarModal extends StatefulWidget {
  CarModal({Key? key, this.car, this.docID}) : super(key: key);

  final Cars? car;
  final String? docID;

  @override
  State<CarModal> createState() => _CarModalState();
}

class _CarModalState extends State<CarModal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _brandController = TextEditingController();
  TextEditingController? _modelController = TextEditingController();
  Cars? _car;
  @override
  void initState() {
    _car = widget.car!;
    _brandController = TextEditingController(text: _car!.brand);
    _modelController = TextEditingController(text: _car!.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (v) {
                  setState(() {
                    _car!.brand = v;
                  });
                },
                controller: _brandController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a brand";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (v) {
                  setState(() {
                    _car!.model = v;
                  });
                },
                controller: _modelController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a model";
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.docID == "") {
                          FirebaseFirestore.instance
                              .collection("cars")
                              .add(_car!.toJson())
                              .whenComplete(() => Navigator.of(context).pop());
                        } else {
                          FirebaseFirestore.instance
                              .collection("cars")
                              .doc(widget.docID)
                              .update(_car!.toJson())
                              .whenComplete(() => Navigator.of(context).pop());
                        }
                      }
                    },
                    child: Text("Save")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
