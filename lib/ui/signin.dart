import 'package:coeops/utils/input_validator.dart';
import 'package:coeops/view_model/base.dart';
import 'package:coeops/view_model/google_button.dart';
import 'package:coeops/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => new _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _loginFormKey = GlobalKey<FormState>();
  Map<String, String> _formData = {};

  void _handleLogin(context) async {
    if (_loginFormKey.currentState.validate()) {
      final response = await Provider.of<UserViewModel>(context, listen: false)
          .signInWithEmailAndPassword(_formData);
      if (response) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
    }
  }

  void _handleGoogleLogin(context) async {
    final response =
        await Provider.of<GoogleButtonViewModel>(context, listen: false)
            .signInWithGoogle();
    if (response) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
                    child: Text('COE',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 180.0, 0.0, 0.0),
                    child: Text('Devops',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(310.0, 180.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: InputValidator.email,
                          onSaved: (value) => _formData['email'] = value,
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          validator: InputValidator.password,
                          onSaved: (value) => _formData['password'] = value,
                          decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          obscureText: true,
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/forgotPassword');
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: Provider.of<UserViewModel>(context)
                                        .viewStatus ==
                                    ViewStatus.Loading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      _handleLogin(context);
                                    },
                                    child: Center(
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        InkWell(
                          onTap: () {
                            _handleGoogleLogin(context);
                          },
                          child: Container(
                            height: 40.0,
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Provider.of<GoogleButtonViewModel>(context)
                                          .viewStatus ==
                                      ViewStatus.Loading
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image(
                                            image: AssetImage(
                                                "assets/images/google_logo.png"),
                                            height: 20.0),
                                        SizedBox(width: 10.0),
                                        Center(
                                          child: Text('Log in with google',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                        )
                                      ],
                                    ),
                            ),
                          ),
                        )
                      ],
                    ))),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to Coe-Devops ?',
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
