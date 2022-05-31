import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'login_page.dart';
import 'package:tugas2/model/akun_model.dart';
import 'package:tugas2/tools/common_submit_button.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Box<UserAccountModel> localDB = Hive.box<UserAccountModel>("user");

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String username = "";
  String password = "";

  void _submit() {
    // validate all the form fields
    if (_formKey.currentState!.validate()) {
      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage(status: false,)),
            (_) => false,
      );
      localDB.add(UserAccountModel(username: _usernameController.text, password: _passwordController.text));
      _usernameController.clear();
      _passwordController.clear();
      setState(() {

      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
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
      //       Text('Register')
      //     ],),
      // ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign up',
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
                  _buildFieldUsername(),
                  _buildFieldPassword(),
                  _buildButtonRegister(),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldUsername(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  20, vertical: 10),
      child: TextFormField(
        controller: _usernameController,
        decoration:  const InputDecoration(
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

  Widget _buildFieldPassword(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  20, vertical: 10),
      child: TextFormField(
        obscureText: true,
        controller: _passwordController,
        decoration:  const InputDecoration(
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
          }
          if (text.length<8) {
            return 'Your Password is Weak (<8)';
          }
          else {
            return null;
          }
        },
        onChanged: (text) => setState(() => password = text),
      ),
    );
  }

  Widget _buildButtonRegister(){
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
      child: CommonSubmitButton(
          labelButton: "Sing up",
          submitCallback: (value){
            _submit();
          }),
    );
  }
}
