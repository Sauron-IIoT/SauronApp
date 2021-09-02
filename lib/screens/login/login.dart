import 'package:flutter/material.dart';
import 'package:sauron/components/background/login.dart';
import 'package:sauron/components/input/text.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          LoginBackground(),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 40
                ),
                child: Column(
                  children: <Widget>[
                    _buildSauronLogo(),
                    // Form
                    SizedBox(height: 50,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextInput(
                          label: 'Email',
                          hint: 'Digite seu email',
                          icon: Icons.email,
                        ),
                        SizedBox(height: 15,),
                        TextInput(
                          label: 'Senha',
                          hint: 'Digite sua senha',
                          icon: Icons.lock,
                          isSecret: true,
                        ),
                        SizedBox(height:90),
                        _buildLoginButton()
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }

  Container _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(EdgeInsets.all(15)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          )
        ),
        child: Text(
          'ENTRAR', 
          style: TextStyle(
            color: Color.fromRGBO(153,28,209,1),
            letterSpacing: 1.5
          ),
        ),
      ),
    );
  }

  Column _buildSauronLogo() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 50),
          child: Text(
            'S A U R O N',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
        Container(
          height: 160,
          padding: EdgeInsets.symmetric(vertical:10),
          child: Image.asset('assets/images/sauron.png'),
        ),
      ],
    );
  }
}
