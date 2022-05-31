import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tugas2/tools/common_submit_button.dart';
import 'package:hive/hive.dart';
import 'package:tugas2/view/home_page.dart';
import 'package:tugas2/model/akun_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'register_page.dart';


class LoginPage extends StatefulWidget {
  final bool status;
  const LoginPage({Key? key, required this.status}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late Box<UserAccountModel> localDB = Hive.box<UserAccountModel>("user");
  final Future<SharedPreferences> _myPref = SharedPreferences.getInstance();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String username = "";
  String password = "";

  late bool isLogin = widget.status;

  void _submit() {
    // validate all the form fields
    if (_formKey.currentState!.validate()) {
      String currentUsername = _usernameController.value.text;
      String currentPassword = _passwordController.value.text;

      _prosesLogin(currentUsername, currentPassword);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       SizedBox(width: 10),
      //       Text('Sing in',
      //         style: TextStyle(
      //           fontWeight: FontWeight.bold,
      //           fontSize: 40,
      //         ),)
      //
      //     ],),
      //
      // ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign in',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // _CreateLogo(),
                  _buildFieldUsername(),
                  _buildFieldPassword(),
                  _buildButtonLogin(),
                  _buildButtonRegister(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _CreateLogo(){
  //   return Container(
  //       alignment: Alignment.center,
  //       padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
  //       child: Image.asset(
  //         'logo.png',
  //         width: 200,
  //       ));
  // }

  Widget _buildFieldUsername() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        controller: _usernameController,
        decoration: const InputDecoration(
          hintText: "Username",
            prefixIcon: const Icon(Icons.person),
            contentPadding: const EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            )
        ),
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'Username Can\'t be empty';
          } else {
            return null;
          }
        },
        onChanged: (text) => setState(() => username = text),
      ),
    );
  }

  Widget _buildFieldPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  20, vertical: 10),
      child: TextFormField(
        obscureText: true,
        controller: _passwordController,
        decoration: const InputDecoration(
          hintText: "Password",
            prefixIcon: const Icon(Icons.lock),
            contentPadding: const EdgeInsets.all(8.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            )
        ),
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'Password Can\'t be empty';
          } else {
            return null;
          }
        },
        onChanged: (text) => setState(() => password = text),
      ),
    );
  }

  Widget _buildButtonLogin() {
    return Container(
      padding: const EdgeInsets.fromLTRB(60, 15, 60, 0),
      child: CommonSubmitButton(
          labelButton: "Sing in",
          submitCallback: (value) {
            _submit();
          }),
    );
  }

  Widget _buildButtonRegister() {
    return Container(
      padding: const EdgeInsets.fromLTRB(60, 0, 60, 15),
      child: CommonSubmitButton(
          labelButton: "Sing up",
          submitCallback: (value) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RegisterPage()),
            );
          }),
    );
  }

  void _prosesLogin(String username, String password) async {
    for (int index = 0; index < localDB.length; index++){
      if (username == localDB.getAt(index)!.username && password == localDB.getAt(index)!.password) {
        isLogin = true;
        SharedPreferences getPref = await _myPref;
        await getPref.setBool("LoginStatus", isLogin);
        await getPref.setString("Username", username);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
          return HomePage(username: username, isLogin: isLogin,);
        }),
                (_)=> false);
        // SharedPreferences getPref = await _myPref;
        // await getPref.setBool("LoginStatus", true);

      }
    }    if (isLogin == false) {
      _showToast("Akun Tidak Ada", duration: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  void _showToast(String msg, {Toast? duration, ToastGravity? gravity}){
    Fluttertoast.showToast(msg: msg, toastLength: duration, gravity: gravity);
  }
}
