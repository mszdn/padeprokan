import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';

class BottomSendNavigation extends StatefulWidget {
  const BottomSendNavigation({super.key});

  @override
  State<BottomSendNavigation> createState() => _BottomSendNavigationState();
}

class _BottomSendNavigationState extends State<BottomSendNavigation>
    with SingleTickerProviderStateMixin {
  TextEditingController _SendMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        color: Colors.black12,
        child: TextFormField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12)),
              hintText: 'type your message',
              // iconColor: ColorStyle().purpleColor,
              suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send_rounded,
                    color: ColorStyle().purpleColor,
                  ))),
        ),
      ),
    );
    // return Container(
    //   height: 60,
    //   // width: double.infinity,
    //   child: Row(
    //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Container(
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 20, right: 20),
    //           child: Row(
    //             children: [
    //               Container(
    //                 width: MediaQuery.of(context).size.width / 1.5,
    //                 height: 40,
    //                 decoration: BoxDecoration(
    //                   color: Colors.grey.shade200,
    //                   // borderRadius: BorderRadius.only(
    //                   //   topLeft: Radius.circular(20),
    //                   //   bottomLeft: Radius.circular(20),
    //                   // ),
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(left: 12),
    //                   child: TextField(
    //                     cursorColor: Colors.black,
    //                     controller: _SendMessageController,
    //                     decoration: InputDecoration(
    //                       border: InputBorder.none,
    //                       hintText: "Type your message  here",
    //                       // icon: Icon(
    //                       //   FontAwesomeIcons.faceSmileWink,
    //                       //   color: Colors.grey,
    //                       //   size: 20,
    //                       // ),
    //                       // suffixIcon: Icon(
    //                       //   FontAwesomeIcons.paperclip,
    //                       //   color: Colors.grey,
    //                       //   size: 20,
    //                       // ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 // padding: EdgeInsets.only(right: 0),
    //                 height: 40,
    //                 decoration: BoxDecoration(
    //                   color: Colors.grey.shade200,
    //                   // borderRadius: BorderRadius.only(
    //                   //   bottomRight: Radius.circular(20),
    //                   //   topRight: Radius.circular(20),
    //                   // ),
    //                 ),
    //                 child: IconButton(
    //                   onPressed: () {},
    //                   icon: Icon(
    //                     Icons.camera_alt_outlined,
    //                     color: Colors.grey,
    //                     size: 25,
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 padding: EdgeInsets.only(right: 0),
    //                 height: 40,
    //                 decoration: BoxDecoration(
    //                   color: Colors.grey.shade200,
    //                   // borderRadius: BorderRadius.only(
    //                   //   bottomRight: Radius.circular(20),
    //                   //   topRight: Radius.circular(20),
    //                   // ),
    //                 ),
    //                 child: IconButton(
    //                   onPressed: () {},
    //                   icon: Icon(
    //                     Icons.send_rounded,
    //                     color: Colors.grey,
    //                     size: 25,
    //                   ),
    //                 ),
    //               ),
    //               // SizedBox(width: 7),
    //               // Container(
    //               //   padding: EdgeInsets.only(right: 5),
    //               //   height: 40,
    //               //   width: 40,
    //               //   decoration: BoxDecoration(
    //               //     shape: BoxShape.circle,
    //               //     color: Colors.purple,
    //               //   ),
    //               //   child: Icon(
    //               //     // FontAwesomeIcons.solidPaperPlane,
    //               //     Icons.send_rounded,
    //               //     color: Colors.white,
    //               //     size: 20,
    //               //   ),
    //               // ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
