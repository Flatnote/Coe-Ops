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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add a new Course'),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 32.0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                      decoration: InputDecoration(
                    labelText: 'Name of course',
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                      decoration: InputDecoration(
                    labelText: "Description",
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Date',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Builder(
                    builder: (context) {
                      return RaisedButton(
                        onPressed: () => print('PRESSED'),
                        child: Text('Submit Pup'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
