import 'package:flutter/material.dart';
import 'package:clapme_client/services/auth_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:clapme_client/utils/alert_style.dart';
import 'package:clapme_client/theme/color_theme.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  Widget _buildTypography() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 70.0, 0.0, 0.0),
            child: Text('MYRO',
                style: TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSigninGuide() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'first time myro?',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        SizedBox(width: 5.0),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/signup');
          },
          child: Text(
            'signin',
            style: TextStyle(
                color: MYRO_violet,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }

  Widget _formEmailField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'EMAIL',
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: MYRO_violet))),
      validator: (value) => value.isEmpty ? 'please enter email' : null,
      onSaved: (value) => _email = value,
    );
  }

  Widget _formPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'PASSWORD',
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: MYRO_violet))),
      validator: (value) => value.isEmpty ? 'please enter password' : null,
      onSaved: (value) => _password = value,
      obscureText: true,
    );
  }

  Widget _formSubmitButton() {
    return Container(
      height: 50.0,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: MYRO_violet,
        elevation: 1.0,
        child: MaterialButton(
          onPressed: validateAndSave,
          child: Center(
            child: Text(
              'LOGIN',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ),
      ),
    );
  }

  void validateAndSave() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      bool isLoginSuccess = await fetchLogin(_email, _password);
      if (isLoginSuccess) {
        Navigator.of(context).pushNamed('/today');
      } else {
        Alert(
                context: context,
                type: AlertType.none,
                style: alertFailedStyle,
                title: "fail to log in",
                desc: "please try again")
            .show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildTypography(),
            Container(
                padding: EdgeInsets.only(left: 36.0, right: 36.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        _formEmailField(),
                        SizedBox(height: 20.0),
                        _formPasswordField(),
                        SizedBox(height: 40.0),
                        _formSubmitButton(),
                        SizedBox(height: 10.0),
                      ],
                    ))),
            SizedBox(height: 15.0),
            _buildSigninGuide()
          ],
        ));
  }
}
