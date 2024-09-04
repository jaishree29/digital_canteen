import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_canteen/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
  Future<UserModel?> signUpWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebase(userCredential.user);
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // Sign up with Google
  Future<UserModel?> signUpWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null; 
      }
      final googleAuth = await googleUser.authentication;
      final cred = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await _auth.signInWithCredential(cred);
      final user = userCredential.user;

      if (user != null) {
        final userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          return null;
        } else {
          await _firestore.collection('users').doc(user.uid).set({
            'email': user.email,
            'uid': user.uid,
          });
          return UserModel.fromFirebase(user);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  //Sign out from google
  Future<void> signOutFromGoogle() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  //Sign In with email and pass
  Future<UserModel?> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.getRedirectResult();
      return UserModel.fromFirebase(userCredential.user);
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // Sign in with Google
  Future<UserModel?> signInWithGoogle() async {

    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null; // The user canceled the sign-in
      }
      final googleAuth = await googleUser.authentication;
      final cred = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await _auth.signInWithCredential(cred);
      final user = userCredential.user;

      if (user != null) {
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          return UserModel.fromFirebase(user);
        } else {
          return null; 
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
