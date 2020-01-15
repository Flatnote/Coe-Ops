import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coeops/design_course/design_course_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateCourseForm extends StatefulWidget {
  @override
  _CreateCourseFormState createState() => _CreateCourseFormState();
}

class _FormData {
  String codeCourse = '';
  String nameOfCourse = '';
  String courseDescription = '';
  double unit = 0;
  double hour = 0;
  DateTime date = DateTime.now();
  String room = '';
}

class _CreateCourseFormState extends State<CreateCourseForm>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final format = DateFormat("dd-MM-yyyy");

  final databaseReference = Firestore.instance;

  final _createCourseFormKey = GlobalKey<FormState>();
  _FormData _data = new _FormData();

  String commonValidate(String value) {
    if (value.length == 0) {
      return 'required.';
    }

    return null;
  }

  void _handleCreateCourse() async {
    if (_createCourseFormKey.currentState.validate()) {
      _createCourseFormKey.currentState.save();
    }
  }

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
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 32.0,
              ),
              child: Form(
                key: _createCourseFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                          validator: this.commonValidate,
                          onSaved: (value) => this._data.codeCourse = value,
                          decoration: InputDecoration(
                            labelText: 'Code of course',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                          validator: this.commonValidate,
                          onSaved: (value) => this._data.nameOfCourse = value,
                          decoration: InputDecoration(
                            labelText: 'Name of course',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                          validator: this.commonValidate,
                          onSaved: (value) =>
                              this._data.courseDescription = value,
                          decoration: InputDecoration(
                            labelText: "Description",
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                          validator: this.commonValidate,
                          onSaved: (value) =>
                              this._data.unit = double.parse(value),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Unit',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                          validator: this.commonValidate,
                          onSaved: (value) =>
                              this._data.hour = double.parse(value),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Hour',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: DateTimeField(
                        onSaved: (value) => this._data.date = value,
                        decoration: InputDecoration(
                          labelText: 'Date',
                        ),
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        validator: this.commonValidate,
                        onSaved: (value) => this._data.room = value,
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
                                    _handleCreateCourse();
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
                                            color: DesignCourseAppTheme
                                                .nearlyBlue
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
                                          color:
                                              DesignCourseAppTheme.nearlyWhite,
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
        ),
      ),
    );
  }
}
