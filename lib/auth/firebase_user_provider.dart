import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class PupTimeFirebaseUser {
  PupTimeFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

PupTimeFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<PupTimeFirebaseUser> pupTimeFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<PupTimeFirebaseUser>(
        (user) => currentUser = PupTimeFirebaseUser(user));
