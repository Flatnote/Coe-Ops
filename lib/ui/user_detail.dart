import 'package:coeops/design_course/design_course_app_theme.dart';
import 'package:coeops/view_model/base.dart';
import 'package:coeops/view_model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetail extends StatefulWidget {
  UserDetail({Key key}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User detail'),
        backgroundColor: DesignCourseAppTheme.nearlyBlue,
      ),
      body: Container(
        child: Center(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(80),
              child: Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.greenAccent,
                  color: DesignCourseAppTheme.nearlyBlue,
                  elevation: 7.0,
                  child: Provider.of<UserViewModel>(context).viewStatus ==
                          ViewStatus.Loading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                      : GestureDetector(
                          onTap: () async {
                            final response = await Provider.of<UserViewModel>(
                                    context,
                                    listen: false)
                                .signOut();
                            if (response == true) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/signin', (Route<dynamic> route) => false);
                            }
                          },
                          child: Center(
                            child: Text(
                              'LOG OUT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
