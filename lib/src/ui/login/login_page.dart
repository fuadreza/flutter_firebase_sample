import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_sample/src/api/auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.auth, this.onSignIn}) : super(key: key);

  final String title;
  final BaseAuth auth;
  final VoidCallback onSignIn;

  /*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyLoginPage(),
    );
  }*/

  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType { login, register, forgot }

class _LoginPageState extends State<LoginPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool _passwordVisible = false;
  bool _success;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Firebase',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: submitWidgets());
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        String userId = _formType == FormType.login
            ? await widget.auth.signIn(_email, _password)
            : await widget.auth.createUser(_email, _password);
        widget.onSignIn();
      } catch (e) {}
    } else {}
  }

  Widget submitWidgets() {
    switch (_formType) {
      case FormType.login:
        return loginForm();
      case FormType.register:
        return Form();
      case FormType.forgot:
        return Form();
    }
    return null;
  }

  void moveToLogin() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Image.asset(
              "assets/images/multitasking.png",
              alignment: Alignment.bottomCenter,
            )),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Container(
                      margin: EdgeInsets.all(72),
                      child: Image.asset(
                        "assets/images/logo.png",
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, 0.3),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            )
                          ]),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  top: 16.0, left: 24.0, right: 24.0),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: "Enter Email",
                                  fillColor: Colors.white,
                                ),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Email cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (val) => _email = val,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 16.0,
                                  left: 24.0,
                                  right: 24.0,
                                  bottom: 30.0),
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                    labelText: "Enter Password",
                                    fillColor: Colors.white,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    )),
                                validator: (val) => val.isEmpty
                                    ? "Password cannot be empty"
                                    : null,
                                onSaved: (val) => _password = val,
                                keyboardType: TextInputType.text,
                                obscureText: !_passwordVisible,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                      child: RaisedButton(
                          key: Key('login'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          onPressed: () async {
                            validateAndSubmit();
                          },
                          color: Colors.orangeAccent,
                          textColor: Colors.white,
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            alignment: Alignment.center,
                            child: Text(
                              "Login".toUpperCase(),
                              style: TextStyle(fontSize: 24),
                              maxLines: 1,
                            ),
                          )),
                    ),
                  ),
                  /*Container(
                    alignment: Alignment.center,
                    child: Text(
                      _success == null
                          ? ''
                          : (_success
                          ? 'Successfully signed in ' + _userEmail
                          : 'Sign in failed'),
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key, this.title, this.auth, this.onSignIn})
      : super(key: key);

  final String title;
  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool _passwordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success;
  String _userEmail;

  @override
  void initState() {
    _passwordVisible = false;
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Image.asset(
              "assets/images/multitasking.png",
              alignment: Alignment.bottomCenter,
            )),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Container(
                      margin: EdgeInsets.all(72),
                      child: Image.asset(
                        "assets/images/logo.png",
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, 0.3),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            )
                          ]),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  top: 16.0, left: 24.0, right: 24.0),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: "Enter Email",
                                  fillColor: Colors.white,
                                ),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Email cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 16.0,
                                  left: 24.0,
                                  right: 24.0,
                                  bottom: 30.0),
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                    labelText: "Enter Password",
                                    fillColor: Colors.white,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    )),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Password cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.text,
                                obscureText: !_passwordVisible,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _signInWithEmailAndPassword();
                            }
                          },
                          color: Colors.orangeAccent,
                          textColor: Colors.white,
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            alignment: Alignment.center,
                            child: Text(
                              "Login".toUpperCase(),
                              style: TextStyle(fontSize: 24),
                              maxLines: 1,
                            ),
                          )),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      _success == null
                          ? ''
                          : (_success
                              ? 'Successfully signed in ' + _userEmail
                              : 'Sign in failed'),
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    /*final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = false;
      });
    }*/

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      print('User :' + userCredential.user.email);
      setState(() {
        _userEmail = userCredential.user.email;
        _success = true;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
        setState(() {
          _success = false;
        });
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for this user.');
        setState(() {
          _success = false;
        });
      }
    }
  }
}
