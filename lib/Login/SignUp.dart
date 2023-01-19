import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thehorizonapps/Main/PageJelajahi/home.dart';
import 'package:thehorizonapps/Main/bottomnav.dart';
import 'package:thehorizonapps/firebase/authController.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();


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
                      Image.asset(
                        "assets/horizon-login1.png",
                        height: 90,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30),
                  ),
                  Container(
                    height: 4,
                    width: 58,
                    color: Color(0xff5FD068),
                    margin: EdgeInsets.only(top: 10),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: username,
                            validator: (val) => val!.isEmpty
                                ? 'Mohon Masukkan Username Anda!'
                                : null,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: "Enter Your Username",
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13),
                                prefixIcon: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: email,
                            validator: (val) => val!.isEmpty
                                ? 'Mohon Masukkan Email Anda!'
                                : null,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: "Enter Your Email",
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: password,
                            validator: (val) => val!.isEmpty
                                ? 'Mohon Masukkan Password Anda!'
                                : null,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    AuthenticationHelper()
                                        .signUp(
                                            email: email.text,
                                            password: password.text)
                                        .then((result) {
                                      if (result == null) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainNav()));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            result,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ));
                                      }
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: Text(
                                  "Create new account",
                                  style: TextStyle(
                                      color: Color(0xff042330),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  height: 1,
                                ),
                              ),
                              Text(
                                "     or     ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                AuthenticationHelper()
                                    .signInWithGoogle()
                                    .then((result) {
                                  if (result != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainNav()));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "Login Gagal",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ));
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              icon: Image.asset(
                                "assets/flat-color-icons_google.png",
                                width: 24,
                                height: 24,
                              ),
                              label: Text(
                                "Sign Up with Google",
                                style: TextStyle(
                                    color: Color(0xff042330),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Login(),
                                        ));
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
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
