import 'package:coeops/home.dart';
import 'package:coeops/models/user.dart';
import 'package:coeops/ui/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return SigninPage();
    }
    return MyHomePage();
  }
}
