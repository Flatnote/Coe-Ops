import 'package:coeops/design_course/design_course_app_theme.dart';
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
          title: Text('New course'),
          backgroundColor: DesignCourseAppTheme.nearlyBlue,
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
                    labelText: 'Code of course',
                  )),
                ),
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
                    labelText: 'Unit',
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                      decoration: InputDecoration(
                    labelText: 'Hour',
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
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Room',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Builder(
                    builder: (context) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                print("Tap tap");
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: DesignCourseAppTheme.nearlyBlue,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: DesignCourseAppTheme.nearlyBlue
                                            .withOpacity(0.5),
                                        offset: const Offset(1.1, 1.1),
                                        blurRadius: 10.0),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Create',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                      color: DesignCourseAppTheme.nearlyWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
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
