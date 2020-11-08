import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(String email, String password, String firstname,
      String lastname, bool isLogin, BuildContext ctx) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = "";
  var _userPassword = "";
  var _userFirstName = "";
  var _userLastName = "";

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
          _userEmail, _userPassword, _userFirstName, _userLastName, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                              key: ValueKey("email"),
                              validator: (value) {
                                if (value.isEmpty ||
                                    !value.contains("@") ||
                                    value.contains(" ")) {
                                  return "Please Enter a valid Email";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  InputDecoration(labelText: "Email Address"),
                              onSaved: (value) {
                                _userEmail = value;
                              }),
                          TextFormField(
                              key: ValueKey("password"),
                              validator: (value) {
                                if (value.isEmpty || value.length < 8 || value.contains(" ")) {
                                  return "Password must at least be 8 characters long";
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(labelText: "Password"),
                              obscureText: true,
                              onSaved: (value) {
                                _userPassword = value;
                              }),
                          if (!_isLogin)
                            TextFormField(
                                key: ValueKey("firstname"),
                                validator: (value) {
                                  if (value.isEmpty || value.contains(" ")) {
                                    return "Please enter first name with no white spaces";
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(labelText: "First Name"),
                                onSaved: (value) {
                                  _userFirstName = value;
                                }),
                          if (!_isLogin)
                            TextFormField(
                                key: ValueKey("last name"),
                                validator: (value) {
                                  if (value.isEmpty || value.contains(" ")) {
                                    return "Please enter last name with no white spaces";
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(labelText: "Last Name"),
                                onSaved: (value) {
                                  _userLastName = value;
                                }),
                          SizedBox(height: 12),
                          if (widget.isLoading)
                            CircularProgressIndicator(),
                          if (!widget.isLoading)
                          RaisedButton(
                              child: Text(_isLogin ? 'Login' : 'Signup'),
                              textColor: Colors.white,
                              onPressed: _trySubmit),
                          FlatButton(
                            child: Text(_isLogin
                                ? "create new account"
                                : "I already have an account"),
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                          )
                        ],
                      ),
                    )))));
  }
}
