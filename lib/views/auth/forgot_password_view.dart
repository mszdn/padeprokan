import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:padeprokan/components/atoms/button/button_regist.dart';
import 'package:padeprokan/components/atoms/button/button_welcome.dart';
import 'package:padeprokan/views/auth/login_view.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<ForgotPasswordView> {
  TextEditingController email = TextEditingController();
  final _fromkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  Image.asset(
                    'assets/images/logo_splashscreen.png',
                    width: MediaQuery.of(context).size.width / 4.5,
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
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Forgot password',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Please Enter The Email You used \nWhen You Registred',
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
                      controller: email,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        hintText: 'email',
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: Validators.compose([
                        Validators.required('Please input your email'),
                        Validators.email('please insert valid email!')
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (_fromkey.currentState!.validate()) {
                              print('succes');
                            } // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => LoginPage()),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorStyle().yellowButton,
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Back To"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                            );
                          },
                          child: const Text(
                            "Sign In Here",
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
