import 'package:flutter/material.dart';
import '../page/Page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../model/Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenuAdmin extends StatelessWidget {
  FirebaseMessaging _firebaseMessaging;
  String token;
  SideMenuAdmin(this._firebaseMessaging, this.token);
  var _userController = new UserController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Icon(
                          Icons.person,
                          size: 60.0,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'นายแอดมิน',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'Kanit'),
                      ),
                    )
                  ],
                )),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
          ),
          ListTile(
            onTap: () {
              // go to history page
              //Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => History(this.token),
                ),
              );
            },
            leading: Icon(
              Icons.history,
              size: 40.0,
            ),
            title: Text(
              "ประวัติการขอเปิดตู้",
              style: TextStyle(fontSize: 18.0, fontFamily: 'Kanit'),
            ),
          ),
          ListTile(
            onTap: () async {
              autoLogin();
              _firebaseMessaging.deleteInstanceID();
              _userController.updateFcmToken(token, '');
              //await timerController.cancel();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
              //Logout naja
            },
            leading: Icon(
              Icons.exit_to_app,
              size: 40.0,
            ),
            title: Text(
              "ออกจากระบบ",
              style: TextStyle(fontSize: 18.0, fontFamily: 'Kanit'),
            ),
          ),
        ],
      ),
    );
  }

  void autoLogin() {
    logout().then((bool committed) {
      print(committed);
    });
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('stateAutoLogin', false);
    return prefs.commit();
  }
}
