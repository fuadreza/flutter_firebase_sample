
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class BaseAuth {

  Future<String> currentUser();
  Future<String> signIn(String email, String password);
  Future<String> createUser(String email, String password);
  Future<void> signOut();
  Future<void> initializeApp();

}

class Auth implements BaseAuth{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Function> initializeApp() {
    Firebase.initializeApp();
  }

  @override
  Future<String> signIn(String email, String password) async{
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user.user.uid;
  }

  @override
  Future<String> createUser(String email, String password) {

  }

  @override
  Future<String> currentUser() async{
    User user = await _firebaseAuth.currentUser;
    return user != null ? user.uid : null;
  }

  @override
  Future<Function> signOut() {

  }
}