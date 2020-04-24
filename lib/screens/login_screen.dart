import 'package:flutter/material.dart';
import 'package:clapme_client/services/auth_service.dart';

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
            child: Text('CLAP',
                style: TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 145.0, 0.0, 0.0),
            child: Text('ME',
                style: TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(150.0, 125.0, 0.0, 0.0),
            child: Text('.',
                style: TextStyle(
                    fontSize: 90.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff7ACBAA))),
          )
        ],
      ),
    );
  }

  Widget _buildSigninGuide() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'clapme가 처음이신가요?',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        SizedBox(width: 5.0),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/signup');
          },
          child: Text(
            '회원가입',
            style: TextStyle(
                color: Color(0xff7ACBAA),
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
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff7ACBAA)))),
      validator: (value) => value.isEmpty ? '이메일을 입력해주세요' : null,
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
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff7ACBAA)))),
      validator: (value) => value.isEmpty ? '패스워드를 입력해주세요' : null,
      onSaved: (value) => _password = value,
      obscureText: true,
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
        Navigator.of(context).pushNamed('/onboarding');
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
                padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
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
