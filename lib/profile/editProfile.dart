import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _imageFile;
  final _picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        });
       }
      }
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff042330),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile'),
        backgroundColor: Color(0xff042330),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0x5A000000),
                                  ),
                                ),
                                radius: 100,
                                backgroundImage:
                                _imageFile == null ? AssetImage('assets/profile-anonim.jpg') as ImageProvider : FileImage(_imageFile!),
                              ),
                              InkWell(
                                onTap: () {
                                  getImage();
                                },
                                child: Container(
                                  child:
                                  Icon(Icons.add_a_photo, color: Colors.white, size: 50,),
                                ),
                              )
                            ],
                          )
                      ),
                      SizedBox(height: 30),
                      Text("Akbar Rizqullah", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),),
                      Text("akbarrizqullah@gmail.com", style: TextStyle(color: Color(0xff959595), fontSize: 12, fontWeight: FontWeight.w500),),
                    ]),
              ],
            ),
            Spacer(),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Color(0x8BFFFFFF), fontWeight: FontWeight.w700),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Color(0x8BFFFFFF), fontWeight: FontWeight.w700),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: _isHidden,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
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
                labelText: 'Password',
                labelStyle: TextStyle(color: Color(0x8BFFFFFF), fontWeight: FontWeight.w700),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Spacer(),
            SizedBox(
              width: 211,
              height: 51,
              child: ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("Save Profile", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),)),
            ),
            Spacer()
          ],
        ),
      )
    );
  }
}
