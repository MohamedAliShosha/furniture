import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/errors/custom_exception.dart';

class FirebaseAuthService {
  // instance4 of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Delete user
  Future deleteUser() async {
    await _firebaseAuth.currentUser!.delete();
  }

  // Get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'user-not-found') {
        throw CustomException(message: 'The email or password is incorrect.');
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: 'The email or password is incorrect.');
      } else if (e.code == 'invalid-credential') {
        throw CustomException(message: 'The email or password is incorrect.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Please check your internet connection.');
      } else {
        throw CustomException(
            message: 'Something went wrong. Please try again.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}");

      throw CustomException(message: 'Something went wrong. Please try again.');
    }
  }

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user!;

      return user;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'You are already registered. Please log in.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Please check your internet connection.');
      } else {
        throw CustomException(
            message: 'Something went wrong. Please try again.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}");

      throw CustomException(message: 'Something went wrong. Please try again.');
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Google SignIn
  Future<User?> signInWithGoogle() async {
    // begin interactive sign in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // user cancels google sign in pop-up screen
    if (googleUser == null) {
      return null;
    }

    // obtain auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // finally sign in
    return (await _firebaseAuth.signInWithCredential(credential)).user;
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.sendPasswordResetEmail: ${e.toString()} and code is ${e.code}");
      if (e.code == 'user-not-found') {
        throw CustomException(message: 'No account found with this email.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Please check your internet connection.');
      } else {
        throw CustomException(
            message: 'Something went wrong. Please try again.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.sendPasswordResetEmail: ${e.toString()}");
      throw CustomException(message: 'Something went wrong. Please try again.');
    }
  }

  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }
}
