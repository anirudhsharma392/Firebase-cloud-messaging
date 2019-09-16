
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:human_resource/mobx/central_state.dart';

class CrudMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(collection, data) async {
    if (isLoggedIn()) {
      Firestore.instance.collection("$collection").add(data).catchError((e) {
        print(e);
      });
    } else {
      print("User is not logged in");
    }
  }

  getData(collection) async {
    return await Firestore.instance
        .collection("$collection")
        .where("uid", isEqualTo: "${centralstate.uid}")
        .getDocuments()
        .catchError((e) {
      print(e);
    });
  }

  updateData(collection, docID, newValue) {
    Firestore.instance
        .collection("$collection")
        .document(docID)
        .updateData(newValue)
        .catchError((e) {
      print(e);
    });
  }

//  void newUser() {
//    Firestore.instance
//        .collection("info")
//        .where("uid", isEqualTo: "${centralstate.uid}")
//        .getDocuments()
//        .then((docs) {
//      if (docs.documents.length == 0) {
//        print("No User exists.\ncreating one .....");
//        addData("info", {"uid": "${centralstate.uid}"});
//      } else {
//        crudObject.getData("info").then((results) {
//          centralstate.lastRoute = results.documents[0].data["lastRoute"];
//          print("Last Route: " + centralstate.lastRoute);
//        });
//        print("User exists");
//      }
//    });
//
//    Firestore.instance
//        .collection("data")
//        .where("uid", isEqualTo: "${centralstate.uid}")
//        .getDocuments()
//        .then((docs) {
//      if (docs.documents.length == 0) {
//        print("No big data exists.\ncreating one .....");
//        addData("data", {"uid": "${centralstate.uid}"});
//      } else {
//        print("big data exists");
//      }
//    }).catchError((e) {
//      print(e);
//    });
//  }
}

CrudMethods crudObject = new CrudMethods();
