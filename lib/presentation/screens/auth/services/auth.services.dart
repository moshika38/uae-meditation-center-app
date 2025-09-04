import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  // password authentication
  static Future<String> signInWithEmail(
      String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (credential.user != null) {
        return "Successfully";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'errCode1';
      } else if (e.code == 'wrong-password') {
        return 'errCode2';
      }
    }
    return 'Something went wrong';
  }

  // create password account
  static Future<String> createAccountWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (credential.user != null) {
        sendEmailVerification(emailAddress);
        return 'Successfully';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'errCode1';
      } else if (e.code == 'email-already-in-use') {
        return 'errCode2';
      }
    } catch (e) {
      return e.toString();
    }
    return 'Unknown error occurred.';
  }

  // send email verification
  static Future<String> sendEmailVerification(String emailAddress) async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return 'Successfully';
    } catch (e) {
      return e.toString();
    }
  }

  // password reset
  static Future<String> resetPassword(String emailAddress) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
      return 'Successfully';
    } catch (e) {
      return e.toString();
    }
  }

  // check if email is verified
  static Future<bool> isEmailVerified() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.reload();
        final refreshedUser = FirebaseAuth.instance.currentUser;
        return refreshedUser?.emailVerified ?? false;
      }
      return false;
    } catch (e) {
      print('Verification check error: $e');
      return false;
    }
  }
  // google authentication

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }

    //TODO : if user concel the account

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // sing out
  static Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  // check if  email is valid
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return emailRegex.hasMatch(email);
  }
}
