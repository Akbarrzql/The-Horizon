import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thehorizonapps/Login/login.dart';
import 'package:thehorizonapps/Porfile/editProfile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    _signOut()  async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              showCupertinoDialog(context: context, builder: (context) => CupertinoAlertDialog(
                title: Text('Sign Out'),
                content: Text('Are you sure want to sign out?'),
                actions: [
                  CupertinoDialogAction(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text('Sign Out'),
                    onPressed: () {
                      _signOut();
                    },
                  ),
                ],
              ));
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
        backgroundColor: Color(0xff042330),
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
                children: [
                  Expanded(child: Container(
                    width: double.infinity,
                    color: Color(0xff042330),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundImage: AssetImage('assets/profile-anonim.jpg'),
                              ),
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                                },
                                child: Container(
                                  child:
                                  Icon(Icons.edit, color: Colors.white, size: 20,),
                                  padding: EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: Color(0xff5FD068),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                )
                              ))
                            ],
                          )
                        ),
                        Spacer(),
                        Text("Akbar Rizqullah", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),),
                        Text("akbarrizqullah@gmail.com", style: TextStyle(color: Color(0xff959595), fontSize: 12, fontWeight: FontWeight.w500),),
                        SizedBox(height: 50,),
                        Spacer(),
                      ],
                    ),
                  )),
                  Expanded(child: Container(
                    padding: EdgeInsets.only(top: 30),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10,),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 108,
                                  height: 148,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network("https://cdn.idntimes.com/content-images/community/2022/09/img-20220908-152834-779c2639fac019accf02dae4b183db6b-72d15e59fb35e6051fea276f1d3b155b_600x400.jpg", fit: BoxFit.cover,),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  width: MediaQuery.of(context).size.width / 1.8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Judul Artikel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                      Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec aliquet ipsum id mi porta volutpat. Donec convallis velit id maximus ornare. Mauris et velit fringilla porta volutpat. Donec convallis velit id maximus ornare. Mauris et velit fringilla,'),
                                    ],
                                  ),
                                )
                              ]
                            ),
                          );
                    }),
                  ))
                ]
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xff5FD068),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: Text('Artikel Saya', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white ),),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
