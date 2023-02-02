import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/utils.dart';
import '../widgets/rounded_button.dart';
import 'login_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SignUp"),
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
                  title: 'Sign up',
                  loading: loading,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      signUp();
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// login
  void signUp() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
    )
        .then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toMessaage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }
}
