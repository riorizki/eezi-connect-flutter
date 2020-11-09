import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eezi_connect/models/UserFirebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseFirestoreService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<String> uploadFile(String id, String filePath) async {
    try {
      File file = File(filePath);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      final result = await FirebaseStorage.instance
          .ref('images/$id-$fileName')
          .putFile(file);

      final url = await result.ref.getDownloadURL();

      return '$url';
    } on FirebaseException catch (e) {
      printError(info: '$e');

      return null;
    }
  }

  Future<String> addUser(UserFirebase user) async {
    try {
      final data = await usersCollection.add({
        'id': user.id,
        'username': user.username,
        'fullName': user.fullName,
        'phoneNumber': user.phoneNumber,
        'email': user.email,
        'address': user.address,
        'token': user.token,
        'avatar': user.avatar,
        'loginProvider': user.loginProvider,
      });

      printInfo(info: 'user add success ${data.id}');
      return data.id;
    } catch (e) {
      printError(info: '$e');
      return null;
    }
  }

  Future<UserFirebase> getUser(String id) async {
    DocumentSnapshot snapshot = await usersCollection.doc(id).get();

    final user = UserFirebase(
      id: snapshot['id'],
      username: snapshot['username'],
      phoneNumber: snapshot['phoneNumber'],
      address: snapshot['address'],
      avatar: snapshot['avatar'],
      email: snapshot['email'],
      fullName: snapshot['fullName'],
      token: snapshot['token'],
      loginProvider: snapshot['loginProvider'],
    );

    return user;
  }

  Future<List<UserFirebase>> getAllUser() async {
    try {
      final List<UserFirebase> users = List<UserFirebase>();
      final data = await usersCollection.get();

      data.docs.forEach((snapshot) {
        final user = UserFirebase(
          id: snapshot['id'],
          username: snapshot['username'],
          phoneNumber: snapshot['phoneNumber'],
          address: snapshot['address'],
          avatar: snapshot['avatar'],
          email: snapshot['email'],
          fullName: snapshot['fullName'],
          token: snapshot['token'],
          loginProvider: snapshot['loginProvider'],
        );

        users.add(user);
      });

      return users;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateUser(String id, UserFirebase user) async {
    try {
      final data = await usersCollection.doc(id).update({
        'id': user.id,
        'username': user.username,
        'fullName': user.fullName,
        'phoneNumber': user.phoneNumber,
        'email': user.email,
        'address': user.address,
        'token': user.token,
        'avatar': user.avatar,
        'loginProvider': user.loginProvider,
      });

      printInfo(info: 'update success');
    } catch (e) {
      printError(info: '$e');
      return null;
    }
  }

  Future<void> updateDynamicUser(String id, dynamic payload) async {
    try {
      final data = await usersCollection.doc(id).update(payload);
      printInfo(info: 'update success');
    } catch (e) {
      printError(info: '$e');
      return null;
    }
  }
}

class SignInSignUpResult {
  final UserFirebase user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
