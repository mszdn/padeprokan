import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/blocs/login_bloc.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';
import 'package:padeprokan/graphql/auth/login.dart';
import 'package:padeprokan/views/auth/forgot_password_view.dart';
import 'package:padeprokan/views/auth/register_view.dart';
import 'package:padeprokan/views/spaces/spaces_index_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _fromkey = GlobalKey<FormState>();

  bool _isObscure = true;

  bool _isLoading = false;

  bool _emailErr = false;
  bool _passwordErr = false;

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  String _emailErrMsg = "";
  String _passwordErrMsg = "";

  //   @override
  // void dispose() {
  //   TextEditingController().dispose();
  //   super.dispose();
  // }

  bool validateForm(String email, String password) {
    if (email == "" || email.isEmpty) {
      setState(() {
        _emailErr = false;
        _emailErrMsg = "Email tidak boleh kosong";
      });
      return false;
    }
    if (password == "" || password.isEmpty) {
      setState(() {
        _passwordErr = true;
        _passwordErrMsg = "Password tidak boleh kosong";
      });
      return false;
    }
    return true;
  }

  void resetValidasi() {
    setState(() {
      _emailErr = false;
      _passwordErr = false;
      _emailErrMsg = "";
      _passwordErrMsg = "";
    });
  }

  Future Procced() async {
    setState(() {
      _isLoading = true;
    });
    resetValidasi();
    bool isNext = validateForm(_emailController.text, _passwordController.text);
    if (isNext == false) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    // LoginUser newlogin = LoginUser(
    //   email: _emailController.text,
    //   password: _passwordController,
    // );
  }

  // String? validatePassword(String value) {
  //   if (value.isEmpty) {
  //     return "* Required";
  //   } else if (value.length < 6) {
  //     return "Password should be atleast 6 characters";
  //   } else if (value.length > 16) {
  //     return "Password should not be greater than 16 characters";
  //   } else
  //     return null;
  // }
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SingleChildScrollView(
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
                            'Login',
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
                            'Login and start manage your learning \nprocess!',
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
                      // onSubmitted: (val){
                      // },
                      autofocus: false,
                      cursorColor: Colors.black,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        hintText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.none,
                      // validator: (val) {
                      //   if (val!.isEmpty || val.contains('@')) {
                      //     return 'Please enter a valid email address';
                      //   }
                      //   ;
                      //   return null;
                      // },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@') ||
                            !value.contains('.')) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      onFieldSubmitted: (val) {
                        resetValidasi();
                        FocusScope.of(context).requestFocus(_emailNode);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      focusNode: _emailNode,
                      autofocus: false,
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
                      keyboardType: TextInputType.visiblePassword,
                      enableSuggestions: false,
                      validator: (val) {
                        if (val!.isEmpty || val.length < 6) {
                          return 'Password must be at least 6 chracters';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        // resetValidasi();
                        // FocusScope.of(context).unfocus();
                      },
                      // validator: validatePassword.,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordView()),
                          );
                        },
                        child: const Text(
                          "Forgot your password?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                            fontSize: 13,
                          ),
                        )),
                  ),
                  Mutation(
                    options: MutationOptions(
                      document: gql(loginMutation),
                      onCompleted: (dynamic resultData) async {
                        final prefs = await SharedPreferences.getInstance();
                        if (resultData != null) {
                          await prefs.setString(
                            'token',
                            resultData["login"]["token"],
                          );
                          await prefs.setString(
                              "user", jsonEncode(resultData["login"]["user"]));
                          final body = prefs.getString("user");
                          print(json.decode(body!));

                          loginBloc.generateToken(resultData["login"]["token"]);
                          Timer(
                              const Duration(milliseconds: 500),
                              () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SpacesIndexView()),
                                    (Route<dynamic> route) => false,
                                  ));
                        } else {
                          if (resultData == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Password atau Email salah')),
                            );
                          }
                        }
                        // print(p.token);
                        // final prefs = await SharedPreferences.getInstance();
                        // await prefs.setString(
                        //   'token',
                        //   resultData["login"]["token"],
                        // );
                        // print(resultData["login"]["token"]);
                        // widget.bapak.tokenGraphql =
                        //     resultData["login"]["token"];

                        // loginBloc.generateToken(resultData["login"]["token"]);

                        // setState(() {
                        //   p.tokenGraphql = prefs.getString("token") ?? "";
                        // });
                      },
                    ),
                    builder: (
                      runMutation,
                      result,
                    ) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 15,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorStyle().yellowButton,
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                // Proccesed();
                                // if (_fromkey.currentState!.validate()) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //         content: Text('Processing Data')),
                                //   );
                                // }
                                // runMutation({
                                //   "email": "testing@test.test",
                                //   "password": "2wsx1qaz"
                                // });
                                runMutation({
                                  "email": _emailController.text,
                                  "password": _passwordController.text
                                });
                                if (_fromkey.currentState!.validate()) {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(
                                  //       content: Text('Processing Data')),
                                  // );
                                  // } else {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(
                                  //         content: Text('Data not valid')),
                                  //   );
                                }
                                ;
                              }),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account yet?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterView()),
                            );
                          },
                          child: const Text(
                            "Register here",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ))
                    ],
                  ),
                  // Spacer(),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 20),
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     height: 50,
                  //     child: ButtonLogin(),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
