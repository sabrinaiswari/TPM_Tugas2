import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String username;
  final bool isLogin;

  const HomePage({Key? key, required this.username,required this.isLogin}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 24),
          child: Center(
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Text(
                    "Halo ${widget.username}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),


                ],
              )
          ),
        ),
      ),
    );
  }

}

