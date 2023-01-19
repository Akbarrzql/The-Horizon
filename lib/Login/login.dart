import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thehorizonapps/Login/SignUp.dart';
import 'package:thehorizonapps/Main/PageJelajahi/home.dart';
import 'package:thehorizonapps/Main/bottomnav.dart';
import 'package:thehorizonapps/firebase/authController.dart';

import '../firebase/authController.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff042330),
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Image.asset("assets/horizon-login1.png", height: 90,),
                      ],),
                      SizedBox(height: 20,),
                      Text("Log in", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),),
                      Container(
                        height: 4,
                        width: 58,
                        color: Color(0xff5FD068),
                        margin: EdgeInsets.only(top: 10),
                      ),
                    SizedBox(height: 40,),
                    Form(
                        key: _formKey,
                        child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          validator: (val) =>
                          val!.isEmpty ? 'Mohon Masukkan Email Anda!' : null,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            hintText: "Enter Your Email",
                              hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700, fontSize: 13),
                            prefixIcon: Icon(Icons.email_outlined, color: Colors.white,)
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: password,
                          validator: (val) =>
                          val!.isEmpty ? 'Mohon Masukkan Password Anda!':null,
                          style: TextStyle(color: Colors.white),
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              hintText: "Enter Your Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _isHidden ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: (){
                                  setState(() {
                                    _isHidden = !_isHidden;
                                  });
                                },
                              ),
                              hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700, fontSize: 13),
                              prefixIcon: Icon(Icons.lock_outline, color: Colors.white,)
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){}, child: Text("Forget your password?", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13),))
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              AuthenticationHelper()
                                  .signIn(email: email.text, password: password.text)
                                  .then((ok) {
                                if (ok == null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainNav()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                      ok,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ));
                                }
                              });
                            }
                          },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                              child: Text("Log in", style: TextStyle(color: Color(0xff042330),fontWeight: FontWeight.bold, fontSize: 15),)),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child:
                            Container(
                              color: Colors.white,
                              height: 1,
                            ),
                            ),
                            Text(
                              "     or     ",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            Expanded(child:
                            Container(
                              color: Colors.white,
                              height: 1,
                            ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton.icon(onPressed: (){
                            AuthenticationHelper().signInWithGoogle().then((value) {
                              if (value != null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainNav()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    'Login Gagal',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ));
                              }
                            });
                          },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                              icon: SvgPicture.asset("assets/google.svg", height: 20,),
                              label: Text("Log in with Google", style: TextStyle(color: Color(0xff042330),fontWeight: FontWeight.bold, fontSize: 15),)),
                        ),
                        SizedBox(height: 50,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Dont have an account? ", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUp(),
                                        ));
                                  },
                                  child: Text(
                                    "Create new one",
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                  ))
                            ],
                        ),
                      ],
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}
