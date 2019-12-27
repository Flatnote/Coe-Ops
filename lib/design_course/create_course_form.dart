import 'package:flutter/material.dart';

class CreateCourseForm extends StatefulWidget {
  @override
  _CreateCourseFormState createState() => _CreateCourseFormState();
}

class _CreateCourseFormState extends State<CreateCourseForm>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('test'),
          ),
        ),
      ),
    );
  }
}
