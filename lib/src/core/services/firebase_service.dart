import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_dd/src/core/adapters/people_adapter.dart';

class FirebaseService {
  final FirebaseFirestore _firestore;
  static const String surveyCollection = 'SURVEY';
  late CollectionReference _collectionReference;

  FirebaseService(this._firestore) {
    _collectionReference = _firestore.collection(surveyCollection);
  }
  Future<void> addPeople(People people) async {
    var peopleMap = <String, dynamic>{};

    try {
      peopleMap['name'] = people.name;
      peopleMap['gender'] = people.gender;
      peopleMap['dateTime'] = people.dateTime;
      peopleMap['uuid'] = people.uuid;
      peopleMap['location'] = people.location;
      peopleMap['social'] = people.social;
      peopleMap['modernization'] = people.modernization;
      peopleMap['health'] = people.health;
      peopleMap['governmentSchemes'] = people.governmentSchemes;
      peopleMap['general'] = people.general;
      peopleMap['education'] = people.education;
      peopleMap['economy'] = people.economy;

      // check if this element already exists
      var response = await _collectionReference
          .where("uuid", isEqualTo: people.uuid)
          .get();

      if (response.docs.isEmpty) {
        _collectionReference.add(peopleMap);
      } else {
        var doc = response.docs.first;
        var docRef = _collectionReference.doc(doc.id);
        docRef.update(peopleMap);
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } on SocketException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Unknown error please try  ${e.toString()}");
    }
  }

  Future<void> deletePerson(People people) async {
    try {
      var response = await _collectionReference
          .where("uuid", isEqualTo: people.uuid)
          .get();

      var doc = response.docs.first;
      await _collectionReference.doc(doc.id).delete();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } on SocketException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Unknown error please try  ${e.toString()}");
    }
  }

  Future<List<QueryDocumentSnapshot>> getAllData() async {
    var response = await _collectionReference.get();
    return response.docs;
  }
}
