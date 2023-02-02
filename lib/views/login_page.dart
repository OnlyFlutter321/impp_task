import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:impp_task/views/pages.dart';
import 'package:impp_task/views/signup_page.dart';

import '../Utils/utils.dart';
import '../widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });

    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      Utils().toMessaage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => Pages()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toMessaage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,

                        obscureText: true,
                        controller: passwordController,
                        // ignore: prefer_const_constructors
                        decoration: const InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock_open),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                RoundButton(
                  title: 'Login',
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ForgotPasswordScreen()));
                    },
                    child: Text(
                      "Forgot Password? ",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Login with phone number',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
