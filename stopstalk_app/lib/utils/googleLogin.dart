import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stopstalkapp/screens/profile.dart';
import 'package:stopstalkapp/utils/api.dart';
import 'package:stopstalkapp/utils/auth.dart';
import 'package:stopstalkapp/utils/storage.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
Future loginWithGoogle(BuildContext context) async {
  _googleSignIn.signIn().then((result) {
    result.authentication.then((googleKey) async {
      _onLoading(context);
      //print(googleKey.accessToken);
      //print(googleKey.idToken);
      //print(_googleSignIn.currentUser.displayName);
      var jwt = await attemptGoogleLogIn(googleKey.idToken);
      //print(jwt);
      //setState(() => _loader = false);
      if (jwt != null) {
        await writeDataSecureStore("jwt", jwt);
        var user = await getCurrentUser();
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: ProfileScreen(
                handle: user.stopstalkHandle,
                isUserItself: true,
              )),
        );
      } else {
        Navigator.pop(context);
        displayDialog(context, "An Error Occurred",
            "No account was found matching that username and password");
        //setState(() => _loader = false);
      }
    }).catchError((err) {
      print('inner error ' + err.message);
    });
  }).catchError((err) {
    print('error occured' + err.message);
  });
}

void displayDialog(context, title, text) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning),
              SizedBox(width: 7),
              Text(title),
            ],
          ),
          content: Text(text)),
    );

void _onLoading(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}
