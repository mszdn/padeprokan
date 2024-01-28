import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/components/utils/model/myuser/user_sharedpref.dart';
import 'package:padeprokan/components/utils/model/spaces/spaces.dart';
import 'package:padeprokan/graphql/auth/register.dart';
import 'package:padeprokan/views/auth/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

import '../../blocs/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confrim_passwordController =
      TextEditingController();
  final _fromkey = GlobalKey<FormState>();
  bool _isObscure = true;

  bool _fullNameErr = false;
  bool _emailErr = false;
  bool _passwordErr = false;
  bool _confirmPasswordErr = false;

  String fullNameErr = "";
  String emailErr = "";
  String passwordErr = "Password must be at least 6 characters";
  String repeatPasswordErr = "";

  @override
  Widget build(BuildContext context) {
    // RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context, listen: true);
    // try {
    //   RunMutation({});
    // } catch (signUpError) {
    //   if (signUpError is PlatformException) {
    //     if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
    //       /// `foo@bar.com` has alread been registered.
    //     }
    //   }
    // }
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
          child: Container(
            child: Form(
              key: _fromkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/images/padeprokan.png',
                    width: MediaQuery.of(context).size.width / 3.5,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: const [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Registration and start manage your \nlearning process!',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      controller: _fullnameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        hintText: 'Full Name',
                      ),
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter your name';
                        }
                        if (value.length < 2) {
                          return 'Must be more than 2 chracters';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      // validator: Validators.compose([
                      //   Validators.required('Your full name is required'),
                      //   Validators.email('Your name is too short')
                      // ]),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        hintText: 'Email',
                      ),
                      autofocus: false,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@') ||
                            !value.contains('.')) {
                          return 'Please insert a valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      // validator: Validators.compose([
                      //   Validators.required('Your email is required'),
                      //   Validators.email('Please insert a valid email!')
                      // ]),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      obscureText: _isObscure,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                      ),
                      validator: (val) {
                        if (val!.isEmpty || val.length < 6) {
                          return 'Password must be at least 6 chracters';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      // validator: Validators.compose([
                      //   Validators.required(' Your password is required'),
                      //   Validators.email('Please insert at least 6 character')
                      // ]),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      autofocus: false,
                      cursorColor: Colors.black,
                      obscureText: _isObscure,
                      controller: _confrim_passwordController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        hintText: 'Confirm Password',
                        suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Insert a password';
                        }
                        if (value != _passwordController.text) {
                          return 'Password not match';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      // validator: Validators.compose([
                      //   Validators.required('Your password is required'),
                      //   Validators.email(
                      //       'two password that you enter is inconsisten!!')
                      // ]),
                    ),
                  ),
                  Mutation(
                      options: MutationOptions(
                          document: gql(RegisterMutation),
                          onCompleted: (dynamic resultData) async {
                            final prefs = await SharedPreferences.getInstance();
                            if (resultData != null) {
                              await prefs.setString(
                                'token',
                                resultData["register"]["token"],
                              );

                              RegisterBloc()
                                  .AddToken(resultData["register"]["token"]);
                              Timer(
                                  const Duration(milliseconds: 200),
                                  () => showAlertDialog(
                                      builder: (context, child) {
                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginView()));
                                        });
                                        return const AlertDialog(
                                          title: Text(
                                            'Register Berhasil , Silahkan Login !',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        );
                                      },
                                      context: context,
                                      message: ''));
                              print(resultData);
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const LoginView())));
                            } else {
                              if (resultData == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Email is already exist')),
                                );
                                print(resultData);
                              }
                            }
                          }),
                      builder: (runMutation, result) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 15,
                            child: ElevatedButton(
                                child: const Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  // if (_fromkey.currentState!.validate()) {
                                  //   print('succes');
                                  // } // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => LoginPage()),
                                  // );
                                  runMutation(
                                    {
                                      "firstName": _fullnameController.text,
                                      "email": _emailController.text,
                                      "password": _passwordController.text,
                                    },
                                  );
                                  if (_fromkey.currentState!.validate()) {
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //     const SnackBar(
                                    //         content: Text('Processing Data')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Data not valid')),
                                    );
                                  }
                                  // catch (registError) {
                                  //   if (registError is PlatformException) {
                                  //     if (registError.code == "INTERNAL_SERVER_ERROR"){
                                  //       print('email already in use');
                                  //     }
                                  //   }
                                  // }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorStyle().yellowButton,
                                )),
                          ),
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account yet?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                            );
                          },
                          child: const Text(
                            "Login here",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
