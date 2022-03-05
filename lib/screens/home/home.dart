import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/data/providers/auth_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
            child: Text("Log Out"),
            onPressed: () {
              Provider.of<AuthState>(context, listen: false).signOut();
            }),
      ),
    );
  }
}
