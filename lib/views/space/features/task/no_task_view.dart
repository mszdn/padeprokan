import 'package:flutter/material.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';

class NoTaskIndexView extends StatefulWidget {
  const NoTaskIndexView({super.key});

  @override
  State<NoTaskIndexView> createState() => _NoTaskIndexViewState();
}

class _NoTaskIndexViewState extends State<NoTaskIndexView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                // // color: Colors.red,
                // width: 200,
                // height: 230,
                // child: SvgPicture.asset(
                //   "assets/images/notask.svg",
                //   width: 250,
                // ),
                ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "There' are no Task on this space",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.7,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyle().yellowButton,
                    ),
                    child: const Text(
                      "Let's Create Your First Task!",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Column(
                            children: [
                              const Text(
                                "Create Board",
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "Board Name",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "*",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    fillColor:
                                        const Color.fromRGBO(173, 120, 211, 1),
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    hintText: "Board Name",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(173, 120, 211, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "Select Teams",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "*",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    fillColor:
                                        const Color.fromRGBO(173, 120, 211, 1),
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    hintText: "No Team",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(173, 120, 211, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                ),
                                child: SizedBox(
                                  height: 40,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 18),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Add',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
