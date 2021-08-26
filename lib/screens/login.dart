import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(203,145,228,1),
                  Color.fromRGBO(174,97,209,1),
                  Color.fromRGBO(159,60,205,1),
                  Color.fromRGBO(153,28,209,1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.4, 0.75, 1]
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 40
                ),
                child: Column(
                  children: <Widget>[
                    // Logo
                    Column(
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
                    ),
                    // Form
                    SizedBox(height: 50,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(174,97,209,1),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 15),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.email, 
                                color: Colors.white,
                              ),
                              hintText: 'Digite seu email',
                              hintStyle: TextStyle(
                                color: Colors.white54,
                              )
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text(
                          'Senha',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(174,97,209,1),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 15),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock, 
                                color: Colors.white,
                              ),
                              hintText: 'Digite sua senha',
                              hintStyle: TextStyle(
                                color: Colors.white54,
                              )
                            ),
                          ),
                        ),
                        SizedBox(height:90),
                        Container(
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
                        )
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
}
