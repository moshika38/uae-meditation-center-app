import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Your main and MyApp widgets remain the same

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Create a function to handle the Google Sign-In process
  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        // Get the Google Sign-In authentication details
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in with the credential and Firebase
        await FirebaseAuth.instance.signInWithCredential(credential);

        // User is signed in, you can now show a confirmation message
        print("Google sign-in successful!");
      }
    } catch (error) {
      print("Google sign-in failed: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome Back 👋",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleGoogleSignIn, // Call the sign-in function here
              child: const Text("Sign in with Google"),
            ),
          ],
        ),
      ),
    );
  }
}