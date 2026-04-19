import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(); // ✅ This will work in 6.x

  // Email/Password Login
  Future<User?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('❌ Login error: $e');
      return null;
    }
  }

  // Email/Password Signup
  Future<User?> signup(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('❌ Signup error: $e');
      return null;
    }
  }

  // ✅ Google Sign In
  Future<User?> signInWithGoogle() async {
    try {
      print("🔵 Starting Google Sign In...");
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        print("❌ User cancelled");
        return null;
      }

      print("✅ Google account: ${googleUser.email}");

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result = await _auth.signInWithCredential(credential);
      
      print("✅ Firebase sign in successful: ${result.user?.email}");
      
      return result.user;
    } catch (e) {
      print("❌ Google Sign In error: $e");
      return null;
    }
  }

  // ✅ Apple Sign In
  Future<User?> signInWithApple() async {
    try {
      print("🍎 Starting Apple Sign In...");
      
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      print("✅ Apple credential received");

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential result = await _auth.signInWithCredential(oauthCredential);
      
      print("✅ Firebase sign in successful: ${result.user?.email}");
      
      return result.user;
    } catch (e) {
      print("❌ Apple Sign In error: $e");
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      print("✅ User signed out");
    } catch (e) {
      print("❌ Sign out error: $e");
    }
  }

  User? get currentuser => _auth.currentUser;
}