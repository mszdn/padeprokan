// import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:social_media_flutter/social_media_flutter.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/utils/model/myuser/user_sharedpref.dart';
import 'package:padeprokan/views/profile/noprofil.dart';
import 'package:padeprokan/views/profile/querypro.dart';

String userProfile = """
query Profile(\$createdById:String) {
  profiles(where:{
    createdById:\$createdById
  }) {
    id
    title
    facebook
    twitter
    linkedIn
    github
    __typename
  }
}
""";

class profilview extends StatefulWidget {
  const profilview({super.key});

  @override
  State<profilview> createState() => _profilviewState();
}

class _profilviewState extends State<profilview> {
  // final Uri _urlfb = Uri.parse("https://id-id.facebook.com/");
  // void _launchfacebook({required String url}) async {
  //   if (await launchUrl(
  //     Uri.parse(url),
  //     //  mode: LaunchMode.externalApplication
  //   ))
  //     ;
  //   else {
  //     throw 'gagal';
  //   }
  // }

  // final Uri _urltw = Uri.parse('https://twitter.com/?lang=id');
  // void _launchtwitter({required String url}) async {
  //   if (await launchUrl(
  //     Uri.parse(url),
  //     //  mode: LaunchMode.externalApplication
  //   ))
  //     ;
  //   else {
  //     throw 'gagal';
  //   }
  // }

  // final Uri _urllinkedin = Uri.parse('https://id.linkedin.com/');
  // void _launchlinkedin({required String url}) async {
  //   if (await launchUrl(
  //     Uri.parse(url),
  //     //  mode: LaunchMode.externalApplication
  //   ))
  //     ;
  //   else {
  //     throw 'gagal';
  //   }
  // }

  // final Uri _urlgithub = Uri.parse('https://github.com/');
  // void _launchgihub({required String url}) async {
  //   if (await launchUrl(
  //     Uri.parse(url),
  //     //  mode: LaunchMode.externalApplication
  //   ))
  //     ;
  //   else {
  //     throw 'gagal';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // String facebook = profiles[facebook];
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBarWidget(context, 'profil'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<GetUserData>(
              future: getUserDataFromJson(),
              builder: (context, snapshot) {
                GetUserData? user = snapshot.data;
                return Query(
                    options: QueryOptions(
                        document: gql(userProfile),
                        variables: {"createdById": user?.id}),
                    builder: (result, {fetchMore, refetch}) {
                      if (result.isLoading) {
                        return Center(
                          child: LoadingAnimationWidget.halfTriangleDot(
                              color: Colors.black, size: 50),
                        );
                      }
                      if (result.hasException) {
                        return Center(
                          child: LoadingAnimationWidget.halfTriangleDot(
                              color: Colors.black, size: 50),
                        );
                      }
                      // print(result.data?["profiles"][0]["facebook"]);
                      if (result.data != null) {
                        dynamic profile = result.data?["profiles"][0];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  'Detail Profile',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.purple,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      // IconButton(
                                      //     onPressed: () {
                                      //       // showDialog(context: context, builder:(context) =>
                                      //       showDialog(
                                      //           context: context,
                                      //           builder: (context) =>
                                      //               SingleChildScrollView(
                                      //                 child: AlertDialog(
                                      //                   title: Column(
                                      //                     crossAxisAlignment:
                                      //                         CrossAxisAlignment
                                      //                             .start,
                                      //                     children: [
                                      //                       Row(
                                      //                         children: [
                                      //                           Text(
                                      //                             'Edit Profile',
                                      //                             style: TextStyle(
                                      //                                 fontSize:
                                      //                                     18),
                                      //                           ),
                                      //                           Spacer(),
                                      //                           IconButton(
                                      //                               onPressed:
                                      //                                   () {
                                      //                                 Navigator.of(
                                      //                                         context)
                                      //                                     .pop();
                                      //                               },
                                      //                               icon: Icon(
                                      //                                 Icons
                                      //                                     .close,
                                      //                                 size: 15,
                                      //                               ))
                                      //                         ],
                                      //                       ),
                                      //                     ],
                                      //                   ),
                                      //                   actions: [
                                      //                     Column(
                                      //                       crossAxisAlignment:
                                      //                           CrossAxisAlignment
                                      //                               .start,
                                      //                       children: [
                                      //                         Text('Fullname'),
                                      //                         TextFormField(
                                      //                           decoration: InputDecoration(
                                      //                               hintText: user!
                                      //                                   .firstName,
                                      //                               border:
                                      //                                   OutlineInputBorder()),
                                      //                         ),
                                      //                         SizedBox(
                                      //                           height: 10,
                                      //                         ),
                                      //                         Text('Email'),
                                      //                         TextFormField(
                                      //                           decoration: InputDecoration(
                                      //                               hintText:
                                      //                                   'Your Email',
                                      //                               border:
                                      //                                   OutlineInputBorder()),
                                      //                         ),
                                      //                         SizedBox(
                                      //                           height: 10,
                                      //                         ),
                                      //                         Text('Title'),
                                      //                         TextFormField(
                                      //                           decoration: InputDecoration(
                                      //                               hintText:
                                      //                                   'eg.Fullstack Developer',
                                      //                               border:
                                      //                                   OutlineInputBorder()),
                                      //                         ),
                                      //                         SizedBox(
                                      //                           height: 10,
                                      //                         ),
                                      //                         Text('Avatar'),
                                      //                         TextFormField(
                                      //                           decoration: InputDecoration(
                                      //                               hintText:
                                      //                                   'Upload',
                                      //                               border:
                                      //                                   OutlineInputBorder()),
                                      //                         ),
                                      //                         SizedBox(
                                      //                           height: 10,
                                      //                         ),
                                      //                         Text(
                                      //                             'Phone Number'),
                                      //                         TextFormField(
                                      //                           decoration: InputDecoration(
                                      //                               hintText:
                                      //                                   'eg.08577423..',
                                      //                               border:
                                      //                                   OutlineInputBorder()),
                                      //                         ),
                                      //                         SizedBox(
                                      //                           height: 10,
                                      //                         ),
                                      //                         Text('Address'),
                                      //                         TextFormField(
                                      //                           decoration: InputDecoration(
                                      //                               hintText:
                                      //                                   'eg.Permata Bintaro Residance,..',
                                      //                               border:
                                      //                                   OutlineInputBorder()),
                                      //                         ),
                                      //                         SizedBox(
                                      //                           height: 10,
                                      //                         ),
                                      //                         Text('Facebook'),
                                      //                         TextFormField(
                                      //                           decoration: InputDecoration(
                                      //                               hintText:
                                      //                                   profile['facebook'] ??
                                      //                                       "",
                                      //                               border:
                                      //                                   OutlineInputBorder()),
                                      //                         ),
                                      //                         SizedBox(
                                      //                           height: 10,
                                      //                         ),
                                      //                         Text('Twitter'),
                                      //                         TextFormField(
                                      //                           decoration: InputDecoration(
                                      //                               hintText:
                                      //                                   profile['twitter'] ??
                                      //                                       "",
                                      //                               border:
                                      //                                   OutlineInputBorder()),
                                      //                         ),
                                      //                         SizedBox(
                                      //                           height: 10,
                                      //                         ),
                                      //                         Text('Linkedin'),
                                      //                         TextFormField(
                                      //                           decoration: InputDecoration(
                                      //                               hintText:
                                      //                                   profile['linkedIn'] ??
                                      //                                       "",
                                      //                               border:
                                      //                                   OutlineInputBorder()),
                                      //                         ),
                                      //                         SizedBox(
                                      //                           height: 10,
                                      //                         ),
                                      //                         Text('Github'),
                                      //                         TextFormField(
                                      //                           decoration: InputDecoration(
                                      //                               hintText:
                                      //                                   profile['github'] ??
                                      //                                       "",
                                      //                               border:
                                      //                                   OutlineInputBorder()),
                                      //                         ),
                                      //                       ],
                                      //                     ),
                                      //                     SizedBox(
                                      //                       height: 20,
                                      //                     ),
                                      //                     Row(
                                      //                       mainAxisAlignment:
                                      //                           MainAxisAlignment
                                      //                               .end,
                                      //                       children: [
                                      //                         ElevatedButton(
                                      //                             style: ButtonStyle(
                                      //                                 backgroundColor:
                                      //                                     MaterialStatePropertyAll(Colors
                                      //                                         .white)),
                                      //                             onPressed:
                                      //                                 () {
                                      //                               Navigator.of(
                                      //                                       context)
                                      //                                   .pop();
                                      //                             },
                                      //                             child: Text(
                                      //                                 'Cancel')),
                                      //                         SizedBox(
                                      //                           width: 10,
                                      //                         ),
                                      //                         ElevatedButton(
                                      //                           style: ButtonStyle(
                                      //                               backgroundColor:
                                      //                                   MaterialStatePropertyAll(
                                      //                                       Colors.purple)),
                                      //                           onPressed:
                                      //                               () {},
                                      //                           child: Text(
                                      //                             'Submit',
                                      //                             style: TextStyle(
                                      //                                 color: Color.fromRGBO(
                                      //                                     255,
                                      //                                     255,
                                      //                                     255,
                                      //                                     1)),
                                      //                           ),
                                      //                         ),
                                      //                       ],
                                      //                     )
                                      //                   ],
                                      //                 ),
                                      //               ));
                                      //     },
                                      //     icon: Icon(
                                      //       Icons.edit,
                                      //       color: Colors.white,
                                      //     ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      user?.avatar ??
                                          'https://via.placeholder.com/150',
                                    ),
                                    // backgroundColor: Colors.red,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    user?.firstName ?? "",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  Text(
                                    profile["title"] ?? "",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(profile['facebook'] ?? ""),
                                    Text(profile['twitter'] ?? ""),
                                    Text(profile['linkedIn'] ?? ""),
                                    Text(profile['github'] ?? ""),
                                  ],
                                ),
                                // Card(
                                //   elevation: 0,
                                //   color: Colors.green,
                                //   margin: EdgeInsets.all(10),
                                //   child: Row(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       FlutterSocialButton(
                                //         onTap: () {
                                //           _launchfacebook(url: '$_urlfb');
                                //         },
                                //         buttonType: ButtonType.facebook,
                                //         mini: true,
                                //       ),
                                //       FlutterSocialButton(
                                //         onTap: () {
                                //           _launchtwitter(url: '$_urltw');
                                //         },
                                //         buttonType: ButtonType.twitter,
                                //         mini: true,
                                //       ),
                                //       FlutterSocialButton(
                                //         onTap: () {
                                //           _launchlinkedin(url: '$_urllinkedin');
                                //         },
                                //         buttonType: ButtonType.linkedin,
                                //         mini: true,
                                //       ),
                                //       FlutterSocialButton(
                                //         onTap: () {
                                //           _launchgihub(url: '$_urlgithub');
                                //         },
                                //         buttonType: ButtonType.github,
                                //         mini: true,
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FutureBuilder<GetUserData>(
                                future: getUserDataFromJson(),
                                builder: (context, snapshot) {
                                  GetUserData? user = snapshot.data;
                                  return Query(
                                      options: QueryOptions(
                                          document: gql(educations),
                                          variables: {"createdById": user?.id}),
                                      builder: (result, {fetchMore, refetch}) {
                                        if (result.isLoading) {
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .halfTriangleDot(
                                                    color: Colors.black,
                                                    size: 50),
                                          );
                                        }
                                        if (result.hasException) {
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .halfTriangleDot(
                                                    color: Colors.black,
                                                    size: 50),
                                          );
                                        }
                                        if (result.data!['educations'].length ==
                                            0) {
                                          return const noeducational();
                                        }
                                        // print(result.data?["profiles"][0]["facebook"]);
                                        // if (result.data == null) {
                                        //   return Container(
                                        //     height: 30,
                                        //     width: 30,
                                        //     color: Colors.blue,
                                        //   );
                                        // }
                                        if (result.data != null) {
                                          dynamic education =
                                              result.data?["educations"][0];
                                          return Container(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Text(
                                                        'Educational Background',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Text(
                                                          'This information can be edited from your profil')
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: const [
                                                      // ElevatedButton(
                                                      //     onPressed: () {
                                                      //       showDialog(
                                                      //         context: context,
                                                      //         builder:
                                                      //             (context) =>
                                                      //                 AlertDialog(
                                                      //           title: Column(
                                                      //             crossAxisAlignment:
                                                      //                 CrossAxisAlignment
                                                      //                     .start,
                                                      //             children: [
                                                      //               Row(
                                                      //                 children: [
                                                      //                   Text(
                                                      //                     'Add Educational',
                                                      //                     style:
                                                      //                         TextStyle(fontSize: 18),
                                                      //                   ),
                                                      //                   Spacer(),
                                                      //                   IconButton(
                                                      //                       onPressed:
                                                      //                           () {
                                                      //                         Navigator.of(context).pop();
                                                      //                       },
                                                      //                       icon:
                                                      //                           Icon(
                                                      //                         Icons.close,
                                                      //                         size: 15,
                                                      //                       ))
                                                      //                 ],
                                                      //               ),
                                                      //             ],
                                                      //           ),
                                                      //           actions: [
                                                      //             Column(
                                                      //               crossAxisAlignment:
                                                      //                   CrossAxisAlignment
                                                      //                       .start,
                                                      //               children: [
                                                      //                 Text(
                                                      //                     'School'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'Your School',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //                 SizedBox(
                                                      //                   height:
                                                      //                       10,
                                                      //                 ),
                                                      //                 Text(
                                                      //                     'Degree'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'Your Degree',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //                 SizedBox(
                                                      //                   height:
                                                      //                       10,
                                                      //                 ),
                                                      //                 Text(
                                                      //                     'Field of Study'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'Your Study',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //                 SizedBox(
                                                      //                   height:
                                                      //                       10,
                                                      //                 ),
                                                      //                 Text(
                                                      //                     'Year Start'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'Year Start',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //                 SizedBox(
                                                      //                   height:
                                                      //                       10,
                                                      //                 ),
                                                      //                 Text(
                                                      //                     'Year End'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'Year End',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 )
                                                      //               ],
                                                      //             ),
                                                      //             SizedBox(
                                                      //               height: 20,
                                                      //             ),
                                                      //             Row(
                                                      //               mainAxisAlignment:
                                                      //                   MainAxisAlignment
                                                      //                       .end,
                                                      //               children: [
                                                      //                 ElevatedButton(
                                                      //                     style: ButtonStyle(
                                                      //                         backgroundColor: MaterialStatePropertyAll(Colors
                                                      //                             .white)),
                                                      //                     onPressed:
                                                      //                         () {
                                                      //                       Navigator.of(context).pop();
                                                      //                     },
                                                      //                     child:
                                                      //                         Text('Cancel')),
                                                      //                 SizedBox(
                                                      //                   width:
                                                      //                       10,
                                                      //                 ),
                                                      //                 ElevatedButton(
                                                      //                   style: ButtonStyle(
                                                      //                       backgroundColor:
                                                      //                           MaterialStatePropertyAll(Colors.purple)),
                                                      //                   onPressed:
                                                      //                       () {},
                                                      //                   child:
                                                      //                       Text(
                                                      //                     'Submit',
                                                      //                     style:
                                                      //                         TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                                                      //                   ),
                                                      //                 ),
                                                      //               ],
                                                      //             )
                                                      //           ],
                                                      //         ),
                                                      //       );
                                                      //     },
                                                      //     child: Row(
                                                      //       children: [
                                                      //         Icon(
                                                      //           Icons
                                                      //               .add_circle,
                                                      //           color: Colors
                                                      //               .white,
                                                      //           size: 15,
                                                      //         ),
                                                      //         Text(
                                                      //           ' Create New',
                                                      //           style: TextStyle(
                                                      //               color: Colors
                                                      //                   .white),
                                                      //         ),
                                                      //       ],
                                                      //     ))
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 23,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          education[
                                                                  "thumbnail"] ??
                                                              "",
                                                          // 'https://via.placeholder.com/150',
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            education[
                                                                    "school"] ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                          Text(
                                                            education[
                                                                    "degree"] ??
                                                                "",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                                // Text(education["yearStart"] ??
                                                //     ""),
                                                // Text(
                                                //     education["yearEnd"] ?? ""),
                                                // Icon(
                                                //   Icons.archive_outlined,
                                                //   size: 50,
                                                //   color: Colors.grey,
                                                // ),
                                                // Text(
                                                //   'No Data',
                                                //   style: TextStyle(
                                                //       color: Colors.grey),
                                                // ),
                                              ],
                                            ),
                                          );
                                        }
                                        return Container();
                                      });
                                }),
                            const Divider(
                              indent: 1,
                            ),
                            FutureBuilder<GetUserData>(
                                future: getUserDataFromJson(),
                                builder: (context, snapshot) {
                                  GetUserData? user = snapshot.data;
                                  return Query(
                                      options: QueryOptions(
                                          document: gql(works),
                                          variables: {"createdById": user?.id}),
                                      builder: (result, {fetchMore, refetch}) {
                                        if (result.isLoading) {
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .halfTriangleDot(
                                                    color: Colors.black,
                                                    size: 50),
                                          );
                                        }
                                        if (result.hasException) {
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .halfTriangleDot(
                                                    color: Colors.black,
                                                    size: 50),
                                          );
                                        }
                                        if (result.data!['works'].length == 0) {
                                          return const noworks();
                                        }
                                        // if (result.da){}
                                        // print(result.data?["profiles"][0]["facebook"]);
                                        if (result.data != null) {
                                          dynamic works =
                                              result.data?["works"][0];
                                          return Container(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Text(
                                                        'Work Experience',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Text(
                                                          'This information can be edited from your profil')
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: const [
                                                      // ElevatedButton(
                                                      // onPressed: () {
                                                      //   showDialog(
                                                      // //     context: context,
                                                      //     builder:
                                                      //         (context) =>
                                                      //             AlertDialog(
                                                      //       title: Column(
                                                      //         crossAxisAlignment:
                                                      //             CrossAxisAlignment
                                                      //                 .start,
                                                      //         children: [
                                                      //           Text(
                                                      //               'Add Work'),
                                                      //         ],
                                                      //       ),
                                                      //       actions: [
                                                      //         Column(
                                                      //           crossAxisAlignment:
                                                      //               CrossAxisAlignment
                                                      //                   .start,
                                                      //           children: [
                                                      //             Text(
                                                      //                 'Title'),
                                                      //             TextFormField(
                                                      //               decoration: InputDecoration(
                                                      //                   hintText:
                                                      //                       'Enter your job title',
                                                      //                   border:
                                                      //                       OutlineInputBorder()),
                                                      //             ),
                                                      //             SizedBox(
                                                      //               height:
                                                      //                   10,
                                                      //             ),
                                                      //             Text(
                                                      //                 'Company Name'),
                                                      //             TextFormField(
                                                      //               decoration: InputDecoration(
                                                      //                   hintText:
                                                      //                       'Enter the company name',
                                                      //                   border:
                                                      //                       OutlineInputBorder()),
                                                      //             ),
                                                      //             SizedBox(
                                                      //               height:
                                                      //                   10,
                                                      //             ),
                                                      //             Text(
                                                      //                 'Location'),
                                                      //             TextFormField(
                                                      //               decoration: InputDecoration(
                                                      //                   hintText:
                                                      //                       'Enter the company addres',
                                                      //                   border:
                                                      //                       OutlineInputBorder()),
                                                      //             ),
                                                      //             SizedBox(
                                                      //               height:
                                                      //                   10,
                                                      //             ),
                                                      //             Text(
                                                      //                 'Starting work on'),
                                                      //             TextFormField(
                                                      //               decoration: InputDecoration(
                                                      //                   hintText:
                                                      //                       'Selecet date',
                                                      //                   border:
                                                      //                       OutlineInputBorder()),
                                                      //             ),
                                                      //             SizedBox(
                                                      //               height:
                                                      //                   10,
                                                      //             ),
                                                      //             Text(
                                                      //                 'I ended up working on'),
                                                      //             TextFormField(
                                                      //               decoration: InputDecoration(
                                                      //                   hintText:
                                                      //                       'Select date',
                                                      //                   border:
                                                      //                       OutlineInputBorder()),
                                                      //             )
                                                      //           ],
                                                      //         ),
                                                      //         SizedBox(
                                                      //           height: 20,
                                                      //         ),
                                                      //         Row(
                                                      //           mainAxisAlignment:
                                                      //               MainAxisAlignment
                                                      //                   .end,
                                                      //           children: [
                                                      //             ElevatedButton(
                                                      //                 style: ButtonStyle(
                                                      //                     backgroundColor: MaterialStatePropertyAll(Colors
                                                      //                         .white)),
                                                      //                 onPressed:
                                                      //                     () {
                                                      //                   Navigator.of(context).pop();
                                                      //                 },
                                                      //                 child:
                                                      //                     Text('Cancel')),
                                                      //             SizedBox(
                                                      //               width:
                                                      //                   10,
                                                      //             ),
                                                      //             ElevatedButton(
                                                      //               style: ButtonStyle(
                                                      //                   backgroundColor:
                                                      //                       MaterialStatePropertyAll(Colors.purple)),
                                                      //               onPressed:
                                                      //                   () {},
                                                      //               child:
                                                      //                   Text(
                                                      //                 'Submit',
                                                      //                 style:
                                                      //                     TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                                                      //               ),
                                                      //             ),
                                                      //           ],
                                                      //         )
                                                      //       ],
                                                      //     ),
                                                      //   );
                                                      // },
                                                      // child: Row(
                                                      //   children: [
                                                      //     Icon(
                                                      //       Icons
                                                      //           .add_circle,
                                                      //       color: Colors
                                                      //           .white,
                                                      //       size: 15,
                                                      //     ),
                                                      //     Text(
                                                      //       ' Create New',
                                                      //       style: TextStyle(
                                                      //           color: Colors
                                                      //               .white),
                                                      //     ),
                                                      //   ],
                                                      // ))
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 23,
                                                          backgroundImage:
                                                              NetworkImage(
                                                            works["thumbnail"] ??
                                                                "",
                                                            // 'https://via.placeholder.com/150',
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              works["title"] ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 17),
                                                            ),
                                                            Text(
                                                              works["company"] ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            Text(
                                                              works["startDate"] ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            Text(
                                                              works["endDate"] ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            Text(
                                                              works["address"] ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            Text(
                                                              works["description"] ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Icon(
                                                //   Icons.archive_outlined,
                                                //   size: 50,
                                                //   color: Colors.grey,
                                                // ),
                                                // Text(
                                                //   'No Data',
                                                //   style: TextStyle(
                                                //       color: Colors.grey),
                                                // ),
                                              ],
                                            ),
                                          );
                                        }
                                        return Container();
                                      });
                                }),
                            const Divider(
                              indent: 1,
                            ),
                            FutureBuilder<GetUserData>(
                                future: getUserDataFromJson(),
                                builder: (context, snapshot) {
                                  GetUserData? user = snapshot.data;
                                  return Query(
                                      options: QueryOptions(
                                          document: gql(skilss),
                                          variables: {"createdById": user?.id}),
                                      builder: (result, {fetchMore, refetch}) {
                                        if (result.isLoading) {
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .halfTriangleDot(
                                                    color: Colors.black,
                                                    size: 50),
                                          );
                                        }
                                        if (result.hasException) {
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .halfTriangleDot(
                                                    color: Colors.black,
                                                    size: 50),
                                          );
                                        }
                                        if (result.data!['skills'].length ==
                                            0) {
                                          return const noexpertise();
                                        }
                                        // if (result.data == null) {
                                        //   return Container(
                                        //     height: 30,
                                        //     width: 30,
                                        //     color: Colors.blue,
                                        //   );
                                        // }
                                        // print(result.data?["profiles"][0]["facebook"]);
                                        if (result.data != null) {
                                          dynamic skilss =
                                              result.data?["skills"][0];
                                          return Container(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Text(
                                                        'Expertise',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Text(
                                                          'This information can be edited from your profil')
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: const [
                                                      // ElevatedButton(
                                                      //     onPressed: () {
                                                      //       showDialog(
                                                      //         context: context,
                                                      //         builder:
                                                      //             (context) =>
                                                      //                 AlertDialog(
                                                      //           title: Column(
                                                      //             crossAxisAlignment:
                                                      //                 CrossAxisAlignment
                                                      //                     .start,
                                                      //             children: [
                                                      //               Text(
                                                      //                   'Add Work'),
                                                      //             ],
                                                      //           ),
                                                      //           actions: [
                                                      //             Column(
                                                      //               crossAxisAlignment:
                                                      //                   CrossAxisAlignment
                                                      //                       .start,
                                                      //               children: [
                                                      //                 Text(
                                                      //                     'Title'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'Enter your job title',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //               ],
                                                      //             ),
                                                      //             SizedBox(
                                                      //               height: 20,
                                                      //             ),
                                                      //             Row(
                                                      //               mainAxisAlignment:
                                                      //                   MainAxisAlignment
                                                      //                       .end,
                                                      //               children: [
                                                      //                 ElevatedButton(
                                                      //                     style: ButtonStyle(
                                                      //                         backgroundColor: MaterialStatePropertyAll(Colors
                                                      //                             .white)),
                                                      //                     onPressed:
                                                      //                         () {
                                                      //                       Navigator.of(context).pop();
                                                      //                     },
                                                      //                     child:
                                                      //                         Text('Cancel')),
                                                      //                 SizedBox(
                                                      //                   width:
                                                      //                       10,
                                                      //                 ),
                                                      //                 ElevatedButton(
                                                      //                   style: ButtonStyle(
                                                      //                       backgroundColor:
                                                      //                           MaterialStatePropertyAll(Colors.purple)),
                                                      //                   onPressed:
                                                      //                       () {},
                                                      //                   child:
                                                      //                       Text(
                                                      //                     'Submit',
                                                      //                     style:
                                                      //                         TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                                                      //                   ),
                                                      //                 ),
                                                      //               ],
                                                      //             )
                                                      //           ],
                                                      //         ),
                                                      //       );
                                                      //     },
                                                      //     child: Row(
                                                      //       children: [
                                                      //         Icon(
                                                      //           Icons
                                                      //               .add_circle,
                                                      //           color: Colors
                                                      //               .white,
                                                      //           size: 15,
                                                      //         ),
                                                      //         Text(
                                                      //           ' Create New',
                                                      //           style: TextStyle(
                                                      //               color: Colors
                                                      //                   .white),
                                                      //         ),
                                                      //       ],
                                                      //     ))
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        skilss["name"] ?? "",
                                                        style: const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                // Icon(
                                                //   Icons.archive_outlined,
                                                //   size: 50,
                                                //   color: Colors.grey,
                                                // ),
                                                // Text(
                                                //   'No Data',
                                                //   style: TextStyle(
                                                //       color: Colors.grey),
                                                // ),
                                              ],
                                            ),
                                          );
                                        }
                                        return Container();
                                      });
                                }),
                            const Divider(
                              indent: 1,
                            ),
                            FutureBuilder<GetUserData>(
                                future: getUserDataFromJson(),
                                builder: (context, snapshot) {
                                  GetUserData? user = snapshot.data;
                                  return Query(
                                      options: QueryOptions(
                                          document: gql(project),
                                          variables: {"createdById": user?.id}),
                                      builder: (result, {fetchMore, refetch}) {
                                        if (result.isLoading) {
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .halfTriangleDot(
                                                    color: Colors.black,
                                                    size: 50),
                                          );
                                        }
                                        if (result.hasException) {
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .halfTriangleDot(
                                                    color: Colors.black,
                                                    size: 50),
                                          );
                                        }
                                        if (result.data!['projects'].length ==
                                            0) {
                                          return const noslide();
                                        }
                                        // if (result.data == null) {
                                        //   return Container(
                                        //     height: 30,
                                        //     width: 30,
                                        //     color: Colors.blue,
                                        //   );
                                        // }
                                        // print(result.data?["profiles"][0]["facebook"]);
                                        if (result.data != null) {
                                          dynamic project =
                                              result.data?["projects"][0];
                                          return Container(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Text(
                                                        'Presentation Slide',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Text(
                                                          'This information can be edited from your profil')
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: const [
                                                      // ElevatedButton(
                                                      //     onPressed: () {
                                                      //       showDialog(
                                                      //         context: context,
                                                      //         builder:
                                                      //             (context) =>
                                                      //                 AlertDialog(
                                                      //           title: Column(
                                                      //             crossAxisAlignment:
                                                      //                 CrossAxisAlignment
                                                      //                     .start,
                                                      //             children: [
                                                      //               Text(
                                                      //                   'Add Presentation'),
                                                      //             ],
                                                      //           ),
                                                      //           actions: [
                                                      //             Column(
                                                      //               crossAxisAlignment:
                                                      //                   CrossAxisAlignment
                                                      //                       .start,
                                                      //               children: [
                                                      //                 Text(
                                                      //                     'Slide Title'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'Enter slide title',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //                 SizedBox(
                                                      //                   height:
                                                      //                       10,
                                                      //                 ),
                                                      //                 Text(
                                                      //                     'Thumbnail'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'Your Degree',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //                 SizedBox(
                                                      //                   height:
                                                      //                       10,
                                                      //                 ),
                                                      //                 Text(
                                                      //                     'Embed Link'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'e.g https://docs.google.com/presentation/d/e/2PACX..',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //                 SizedBox(
                                                      //                   height:
                                                      //                       10,
                                                      //                 ),
                                                      //                 Text(
                                                      //                     'Note'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'Add note',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //               ],
                                                      //             ),
                                                      //             SizedBox(
                                                      //               height: 20,
                                                      //             ),
                                                      //             Row(
                                                      //               mainAxisAlignment:
                                                      //                   MainAxisAlignment
                                                      //                       .end,
                                                      //               children: [
                                                      //                 ElevatedButton(
                                                      //                     style: ButtonStyle(
                                                      //                         backgroundColor: MaterialStatePropertyAll(Colors
                                                      //                             .white)),
                                                      //                     onPressed:
                                                      //                         () {
                                                      //                       Navigator.of(context).pop();
                                                      //                     },
                                                      //                     child:
                                                      //                         Text('Cancel')),
                                                      //                 SizedBox(
                                                      //                   width:
                                                      //                       10,
                                                      //                 ),
                                                      //                 ElevatedButton(
                                                      //                   style: ButtonStyle(
                                                      //                       backgroundColor:
                                                      //                           MaterialStatePropertyAll(Colors.purple)),
                                                      //                   onPressed:
                                                      //                       () {},
                                                      //                   child:
                                                      //                       Text(
                                                      //                     'Submit',
                                                      //                     style:
                                                      //                         TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                                                      //                   ),
                                                      //                 ),
                                                      //               ],
                                                      //             )
                                                      //           ],
                                                      //         ),
                                                      //       );
                                                      //     },
                                                      //     child: Row(
                                                      //       children: [
                                                      //         Icon(
                                                      //           Icons
                                                      //               .add_circle,
                                                      //           color: Colors
                                                      //               .white,
                                                      //           size: 15,
                                                      //         ),
                                                      //         Text(
                                                      //           ' Create New',
                                                      //           style: TextStyle(
                                                      //               color: Colors
                                                      //                   .white),
                                                      //         ),
                                                      //       ],
                                                      //     ))
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(project["title"] ??
                                                          ""),
                                                      Text(project["link"] ??
                                                          ""),
                                                      Text(project["note"] ??
                                                          ""),
                                                    ],
                                                  ),
                                                )
                                                // Icon(
                                                //   Icons.archive_outlined,
                                                //   size: 50,
                                                //   color: Colors.grey,
                                                // ),
                                                // Text(
                                                //   'No Data',
                                                //   style: TextStyle(
                                                //       color: Colors.grey),
                                                // ),
                                              ],
                                            ),
                                          );
                                        }
                                        return Container();
                                      });
                                }),
                            const Divider(
                              indent: 1,
                            ),
                            FutureBuilder<GetUserData>(
                                future: getUserDataFromJson(),
                                builder: (context, snapshot) {
                                  GetUserData? user = snapshot.data;
                                  return Query(
                                      options: QueryOptions(
                                          document: gql(projects1),
                                          variables: {"createdById": user?.id}),
                                      builder: (result, {fetchMore, refetch}) {
                                        if (result.isLoading) {
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .halfTriangleDot(
                                                    color: Colors.black,
                                                    size: 50),
                                          );
                                        }
                                        if (result.hasException) {
                                          return Center(
                                            child: LoadingAnimationWidget
                                                .halfTriangleDot(
                                                    color: Colors.black,
                                                    size: 50),
                                          );
                                        }
                                        if (result.data!['projects'].length ==
                                            0) {
                                          return const noporto();
                                        }
                                        // if (result.data == null) {
                                        //   return Container(
                                        //     height: 30,
                                        //     width: 30,
                                        //     color: Colors.blue,
                                        //   );
                                        // }
                                        // print(result.data?["profiles"][0]["facebook"]);
                                        if (result.data != null) {
                                          dynamic project1 =
                                              result.data?["projects"][0];
                                          return Container(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Text(
                                                        'Portfolio',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Text(
                                                          'This information can be edited from your profil')
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: const [
                                                      // ElevatedButton(
                                                      //     onPressed: () {
                                                      //       showDialog(
                                                      //         context: context,
                                                      //         builder:
                                                      //             (context) =>
                                                      //                 AlertDialog(
                                                      //           title: Column(
                                                      //             crossAxisAlignment:
                                                      //                 CrossAxisAlignment
                                                      //                     .start,
                                                      //             children: [
                                                      //               Text(
                                                      //                   'Add Presentation'),
                                                      //             ],
                                                      //           ),
                                                      //           actions: [
                                                      //             Column(
                                                      //               crossAxisAlignment:
                                                      //                   CrossAxisAlignment
                                                      //                       .start,
                                                      //               children: [
                                                      //                 Text(
                                                      //                     'Slide Title'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'Enter slide title',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //                 SizedBox(
                                                      //                   height:
                                                      //                       10,
                                                      //                 ),
                                                      //                 Text(
                                                      //                     'Thumbnail'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'Your Degree',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //                 SizedBox(
                                                      //                   height:
                                                      //                       10,
                                                      //                 ),
                                                      //                 Text(
                                                      //                     'Embed Link'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'e.g https://docs.google.com/presentation/d/e/2PACX..',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //                 SizedBox(
                                                      //                   height:
                                                      //                       10,
                                                      //                 ),
                                                      //                 Text(
                                                      //                     'Note'),
                                                      //                 TextFormField(
                                                      //                   decoration: InputDecoration(
                                                      //                       hintText:
                                                      //                           'Add note',
                                                      //                       border:
                                                      //                           OutlineInputBorder()),
                                                      //                 ),
                                                      //               ],
                                                      //             ),
                                                      //             SizedBox(
                                                      //               height: 20,
                                                      //             ),
                                                      //             Row(
                                                      //               mainAxisAlignment:
                                                      //                   MainAxisAlignment
                                                      //                       .end,
                                                      //               children: [
                                                      //                 ElevatedButton(
                                                      //                     style: ButtonStyle(
                                                      //                         backgroundColor: MaterialStatePropertyAll(Colors
                                                      //                             .white)),
                                                      //                     onPressed:
                                                      //                         () {
                                                      //                       Navigator.of(context).pop();
                                                      //                     },
                                                      //                     child:
                                                      //                         Text('Cancel')),
                                                      //                 SizedBox(
                                                      //                   width:
                                                      //                       10,
                                                      //                 ),
                                                      //                 ElevatedButton(
                                                      //                   style: ButtonStyle(
                                                      //                       backgroundColor:
                                                      //                           MaterialStatePropertyAll(Colors.purple)),
                                                      //                   onPressed:
                                                      //                       () {},
                                                      //                   child:
                                                      //                       Text(
                                                      //                     'Submit',
                                                      //                     style:
                                                      //                         TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                                                      //                   ),
                                                      //                 ),
                                                      //               ],
                                                      //             )
                                                      //           ],
                                                      //         ),
                                                      //       );
                                                      //     },
                                                      //     child: Row(
                                                      //       children: [
                                                      //         Icon(
                                                      //           Icons
                                                      //               .add_circle,
                                                      //           color: Colors
                                                      //               .white,
                                                      //           size: 15,
                                                      //         ),
                                                      //         Text(
                                                      //           ' Create New',
                                                      //           style: TextStyle(
                                                      //               color: Colors
                                                      //                   .white),
                                                      //         ),
                                                      //       ],
                                                      //     ))
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(project1["title"] ??
                                                          ""),
                                                      Text(project1["link"] ??
                                                          ""),
                                                      Text(project1["note"] ??
                                                          ""),
                                                    ],
                                                  ),
                                                )

                                                // Icon(
                                                //   Icons.archive_outlined,
                                                //   size: 50,
                                                //   color: Colors.grey,
                                                // ),
                                                // Text(
                                                //   'No Data',
                                                //   style: TextStyle(
                                                //       color: Colors.grey),
                                                // ),
                                              ],
                                            ),
                                          );
                                        }
                                        return Container();
                                      });
                                }),
                          ],
                        );
                      }
                      return Container();
                    });
              }),
        ),
      ),
    );
  }
}
