import 'package:demo_ecom/core/provider/auth.dart';
import 'package:demo_ecom/core/screen/profile/login.dart';
import 'package:demo_ecom/utils/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    return authData.userToken != ''
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                "Profile",
                style: CustomTextStyle().homeTitleStyle,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      authData.userLogut();
                    },
                    icon: Icon(Icons.logout))
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Image.network(
                      authData.userImage,
                      fit: BoxFit.cover,
                    ),
                    radius: 45,
                    backgroundColor: Colors.transparent,
                  ),
                  Text(authData.userName),
                  Text(authData.userEmail),
                  Text(authData.userGender),
                ],
              ),
            ),
          )
        : LoginScreen();
  }
}
