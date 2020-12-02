import 'package:ready_set_cook/services/auth.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/screens/profile/edit_password.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/profile/profile.dart';
import 'package:ready_set_cook/screens/home/home.dart';

import 'package:flutter_email_sender/flutter_email_sender.dart';

class ReportError extends StatefulWidget {
  final Function toggleView;
  ReportError({this.toggleView});

  @override
  _ReportErrorState createState() => _ReportErrorState();
}

class _ReportErrorState extends State<ReportError> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String problem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[120],
        elevation: 0.0,
        title: Text('Report Bugs'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Text(
                    "What problems did you encounter while using our app?",
                    style: new TextStyle(
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Title'),
                    onChanged: (val) {
                      setState(() => title = val);
                    },
                  ),
                  SizedBox(height: 40.0),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Problem'),
                    onChanged: (val) {
                      setState(() => problem = val);
                    },
                  ),
                  SizedBox(height: 40.0),
                  RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        'Send',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        final Email email = Email(
                          body: problem,
                          subject: title,
                          recipients: ['k2hu@ucsd.edu'],
                          isHTML: false,
                        );
                        await FlutterEmailSender.send(email);
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text('We got your message!'),
                                  content: Text(
                                      'Please allow a few days for response'),
                                ));
                      }),

                  SizedBox(height: 12.0),
                  //BigLogo()
                ],
              ),
            )),
      ),
    );
  }
}
