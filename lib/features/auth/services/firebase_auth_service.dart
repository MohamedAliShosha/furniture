import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/errors/custom_exception.dart';
import '../../../core/utils/app_texts.dart';

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
        throw CustomException(message: AppTexts.emailOrPasswordIncorrect);
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: AppTexts.emailOrPasswordIncorrect);
      } else if (e.code == 'invalid-credential') {
        throw CustomException(message: AppTexts.emailOrPasswordIncorrect);
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: AppTexts.checkYourInternetConnection);
      } else {
        throw CustomException(
            message: AppTexts.somethingWentWrongPleaseTryAgain);
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}");

      throw CustomException(message: AppTexts.somethingWentWrongPleaseTryAgain);
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
        throw CustomException(message: AppTexts.passwordTooWeak);
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: AppTexts.alreadyRegisteredPleaseLogIn);
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: AppTexts.checkYourInternetConnection);
      } else {
        throw CustomException(
            message: AppTexts.somethingWentWrongPleaseTryAgain);
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}");

      throw CustomException(message: AppTexts.somethingWentWrongPleaseTryAgain);
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
        throw CustomException(message: AppTexts.noAccountFoundWithThisEmail);
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: AppTexts.checkYourInternetConnection);
      } else {
        throw CustomException(
            message: AppTexts.somethingWentWrongPleaseTryAgain);
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.sendPasswordResetEmail: ${e.toString()}");
      throw CustomException(message: AppTexts.somethingWentWrongPleaseTryAgain);
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw CustomException(message: AppTexts.noAuthenticatedUserFound);
      }

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.updatePassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'wrong-password') {
        throw CustomException(message: AppTexts.currentPasswordIsIncorrect);
      } else if (e.code == 'weak-password') {
        throw CustomException(message: AppTexts.newPasswordIsTooWeak);
      } else if (e.code == 'requires-recent-login') {
        throw CustomException(
            message: AppTexts.signOutAndSignInAgainToChangePassword);
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: AppTexts.checkYourInternetConnection);
      } else {
        throw CustomException(
            message: AppTexts.somethingWentWrongPleaseTryAgain);
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.updatePassword: ${e.toString()}");
      throw CustomException(message: AppTexts.somethingWentWrongPleaseTryAgain);
    }
  }

  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }
}
