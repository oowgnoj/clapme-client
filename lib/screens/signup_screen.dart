import 'package:clapme_client/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:clapme_client/utils/alert_style.dart';

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
            child: Text('WELCOME',
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(270.0, 25.0, 0.0, 0.0),
            child: Text('.',
                style: TextStyle(
                    fontSize: 100.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff7ACBAA))),
          )
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
            color: Color(0xff7ACBAA),
          ))),
      validator: (value) => value.isEmpty ? '이메일을 입력해주세요' : null,
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
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff7ACBAA)))),
      obscureText: true,
      validator: (value) => value.isEmpty ? '패스워드를 입력해주세요' : null,
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
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff7ACBAA)))),
      validator: (value) => value.isEmpty ? '이름을 입력해주세요' : null,
      onSaved: (value) => _username = value,
    );
  }

  Widget _formSubmitButton() {
    return Container(
        height: 50.0,
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0xff7ACBAA),
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
            Navigator.of(context).pop();
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
          title: "회원가입 완료 👏",
          buttons: [
            DialogButton(
                child: Text(
                  "로그인 하러가기   >",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.of(context).pushNamed('/login'),
                width: 170,
                color: Color(0xff7ACBAA))
          ],
        ).show();
      } else {
        Alert(
                context: context,
                type: AlertType.none,
                style: alertFailedStyle,
                title: "회원가입 실패 🤔",
                desc: "다시 시도해주세요")
            .show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
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
                        SizedBox(height: 10.0),
                        _formPasswordField(),
                        SizedBox(height: 10.0),
                        _formNameField(),
                        SizedBox(height: 50.0),
                        _formSubmitButton(),
                        SizedBox(height: 20.0),
                      ],
                    )),
              ),
              _goBackButton()
            ]));
  }
}
