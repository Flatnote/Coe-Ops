import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coeops/design_course/design_course_app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarHeader extends StatefulWidget {
  AvatarHeader({Key key}) : super(key: key);

  @override
  _AvatarHeaderState createState() => _AvatarHeaderState();
}

class _AvatarHeaderState extends State<AvatarHeader> {
  SharedPreferences prefs;

  String id = '';
  String nickname = '';
  String aboutMe = '';
  String photoUrl = '';

  bool isLoading = false;
  File avatarImageFile;

  @override
  void initState() {
    super.initState();
    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    aboutMe = prefs.getString('aboutMe') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    // photoUrl = '';

    // Force refresh input
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: photoUrl != ''
          ? Material(
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        DesignCourseAppTheme.nearlyBlue),
                  ),
                  width: 60.0,
                  height: 60.0,
                  padding: EdgeInsets.all(20.0),
                ),
                imageUrl: photoUrl,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(45.0)),
              clipBehavior: Clip.hardEdge,
            )
          : Icon(
              Icons.account_circle,
              size: 60.0,
            ),
    );
  }
}
