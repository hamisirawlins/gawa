import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/get_screen_size.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.22,
        ),
        child: Row(
          children: [
            Text('Home View'),
            TextButton(
                onPressed: signOut,
                child: Text(
                  'Sign Out',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
