import 'package:flutter/material.dart';
import 'package:myprofit_employee/src/ui/login/login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('images/layer.png', width: 200)
              ),

              Container(
                padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Forgot Password', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Fill your detail', style: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 16, fontWeight: FontWeight.w600)),
                    ),

                    SizedBox(height: 35),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                    ButtonTheme(
                      minWidth: 200,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        color: Color.fromRGBO(102, 87, 244, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          // thankYouDialog();
                        },
                        child: Text("SUBMIT", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),

                    SizedBox(height: 25),
                    InkWell(
                      child: Text('Go back to login?', style: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),

    );
  }
}
