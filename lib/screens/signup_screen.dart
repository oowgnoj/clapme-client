import 'package:clapme_client/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:clapme_client/utils/alert_style.dart';
import 'package:clapme_client/theme/color_theme.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _username;

  Widget _buildTypography() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 70.0, 0.0, 0.0),
            child: Text('Enter your info',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
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
          // hintText: 'EMAIL',
          // hintStyle: ,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: MYRO_violet,
          ))),
      validator: (value) => value.isEmpty ? 'please enter your email' : null,
      onSaved: (value) => _email = value,
    );
  }

  Widget _formPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'PASSWORD ',
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: MYRO_violet))),
      obscureText: true,
      validator: (value) => value.isEmpty ? 'please enter password' : null,
      onSaved: (value) => _password = value,
    );
  }

  Widget _formNameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'NAME ',
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: MYRO_violet))),
      validator: (value) => value.isEmpty ? 'please enter name' : null,
      onSaved: (value) => _username = value,
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
                'SIGNUP',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
          ),
        ));
  }

  Widget _goBackButton() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      height: 50.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, style: BorderStyle.solid, width: 1.0),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/login');
          },
          child: Center(
            child: Text('Go Back',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
          ),
        ),
      ),
    );
  }

  void validateAndSave() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      bool isSignupSuccess = await fetchSignup(_email, _password, _username);
      if (isSignupSuccess) {
        Alert(
          context: context,
          type: AlertType.none,
          style: alertSuccessStyle,
          title: "succefully signup",
          buttons: [
            DialogButton(
                child: Text(
                  "go to login   >",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.of(context).pushNamed('/login'),
                width: 170,
                color: MYRO_violet)
          ],
        ).show();
      } else {
        Alert(
                context: context,
                type: AlertType.none,
                style: alertFailedStyle,
                title: "fail to signup",
                desc: "please try again")
            .show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40, 30, 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTypography(),
                Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          _formEmailField(),
                          SizedBox(height: 21.0),
                          _formPasswordField(),
                          SizedBox(height: 21.0),
                          _formNameField(),
                          SizedBox(height: 42.0),
                          _formSubmitButton(),
                          SizedBox(height: 21.0),
                        ],
                      )),
                ),
                _goBackButton()
              ]),
        ));
  }
}
