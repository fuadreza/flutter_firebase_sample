import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {

  MyLoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();

}

class _MyLoginPageState extends State<MyLoginPage> {

  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 200.0,
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
                            padding: EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
                            child: TextFormField(
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
                            padding: EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Enter Password",
                                fillColor: Colors.white,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      _passwordVisible
                                      ? Icons.visibility
                                          : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                )
                              ),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}



