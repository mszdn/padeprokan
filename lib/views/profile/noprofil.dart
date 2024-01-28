import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class noeducational extends StatefulWidget {
  const noeducational({super.key});

  @override
  State<noeducational> createState() => _noeducationalState();
}

class _noeducationalState extends State<noeducational> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Educational Background',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('This information can be edited from your profil')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // ElevatedButton(
                //     onPressed: () {
                //       showDialog(
                //         context: context,
                //         builder: (context) => AlertDialog(
                //           title: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Row(
                //                 children: [
                //                   const Text(
                //                     'Add Educational',
                //                     style: TextStyle(fontSize: 18),
                //                   ),
                //                   const Spacer(),
                //                   IconButton(
                //                       onPressed: () {
                //                         Navigator.of(context).pop();
                //                       },
                //                       icon: const Icon(
                //                         Icons.close,
                //                         size: 15,
                //                       ))
                //                 ],
                //               ),
                //             ],
                //           ),
                //           actions: [
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 const Text('School'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText: 'Your School',
                //                       border: OutlineInputBorder()),
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 const Text('Degree'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText: 'Your Degree',
                //                       border: OutlineInputBorder()),
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 const Text('Field of Study'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText: 'Your Study',
                //                       border: OutlineInputBorder()),
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 const Text('Year Start'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText: 'Year Start',
                //                       border: OutlineInputBorder()),
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 const Text('Year End'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText: 'Year End',
                //                       border: OutlineInputBorder()),
                //                 )
                //               ],
                //             ),
                //             const SizedBox(
                //               height: 20,
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.end,
                //               children: [
                //                 ElevatedButton(
                //                     style: const ButtonStyle(
                //                         backgroundColor:
                //                             MaterialStatePropertyAll(
                //                                 Colors.white)),
                //                     onPressed: () {
                //                       Navigator.of(context).pop();
                //                     },
                //                     child: const Text('Cancel')),
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //                 ElevatedButton(
                //                   style: const ButtonStyle(
                //                       backgroundColor: MaterialStatePropertyAll(
                //                           Colors.purple)),
                //                   onPressed: () {},
                //                   child: const Text(
                //                     'Submit',
                //                     style: TextStyle(
                //                         color:
                //                             Color.fromRGBO(255, 255, 255, 1)),
                //                   ),
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       );
                //     },
                //     child: Row(
                //       children: const [
                //         Icon(
                //           Icons.add_circle,
                //           color: Colors.white,
                //           size: 15,
                //         ),
                //         Text(
                //           ' ',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ],
                //     ))
              ],
            ),
          ),
          // Padding(
          //   padding:
          //       const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       CircleAvatar(
          //         radius: 23,
          //         backgroundImage:
          //             NetworkImage(
          //           education[
          //                   "thumbnail"] ??
          //               "",
          //           // 'https://via.placeholder.com/150',
          //         ),
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Column(
          //         crossAxisAlignment:
          //             CrossAxisAlignment
          //                 .start,
          //         children: [
          //           Text(
          //             education[
          //                     "school"] ??
          //                 "",
          //             style: TextStyle(
          //                 fontWeight:
          //                     FontWeight
          //                         .bold,
          //                 fontSize: 17),
          //           ),
          //           Text(
          //             education[
          //                     "degree"] ??
          //                 "",
          //             style: TextStyle(
          //                 color: Colors
          //                     .grey),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // )
          // Text(education["yearStart"] ??
          //     ""),
          // Text(
          //     education["yearEnd"] ?? ""),
          const Icon(
            Icons.archive_outlined,
            size: 50,
            color: Colors.grey,
          ),
          const Text(
            'No Data',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class noworks extends StatefulWidget {
  const noworks({super.key});

  @override
  State<noworks> createState() => _noworksState();
}

class _noworksState extends State<noworks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Work Experience',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('This information can be edited from your profil')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //   ElevatedButton(
                //       onPressed: () {
                //         showDialog(
                //           context: context,
                //           builder: (context) => AlertDialog(
                //             title: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: const [
                //                 Text('Add Work'),
                //               ],
                //             ),
                //             actions: [
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   const Text('Title'),
                //                   TextFormField(
                //                     decoration: const InputDecoration(
                //                         hintText: 'Enter your job title',
                //                         border: OutlineInputBorder()),
                //                   ),
                //                   const SizedBox(
                //                     height: 10,
                //                   ),
                //                   const Text('Company Name'),
                //                   TextFormField(
                //                     decoration: const InputDecoration(
                //                         hintText: 'Enter the company name',
                //                         border: OutlineInputBorder()),
                //                   ),
                //                   const SizedBox(
                //                     height: 10,
                //                   ),
                //                   const Text('Location'),
                //                   TextFormField(
                //                     decoration: const InputDecoration(
                //                         hintText: 'Enter the company addres',
                //                         border: OutlineInputBorder()),
                //                   ),
                //                   const SizedBox(
                //                     height: 10,
                //                   ),
                //                   const Text('Starting work on'),
                //                   TextFormField(
                //                     decoration: const InputDecoration(
                //                         hintText: 'Selecet date',
                //                         border: OutlineInputBorder()),
                //                   ),
                //                   const SizedBox(
                //                     height: 10,
                //                   ),
                //                   const Text('I ended up working on'),
                //                   TextFormField(
                //                     decoration: const InputDecoration(
                //                         hintText: 'Select date',
                //                         border: OutlineInputBorder()),
                //                   )
                //                 ],
                //               ),
                //               const SizedBox(
                //                 height: 20,
                //               ),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.end,
                //                 children: [
                //                   ElevatedButton(
                //                       style: const ButtonStyle(
                //                           backgroundColor:
                //                               MaterialStatePropertyAll(
                //                                   Colors.white)),
                //                       onPressed: () {
                //                         Navigator.of(context).pop();
                //                       },
                //                       child: const Text('Cancel')),
                //                   const SizedBox(
                //                     width: 10,
                //                   ),
                //                   ElevatedButton(
                //                     style: const ButtonStyle(
                //                         backgroundColor: MaterialStatePropertyAll(
                //                             Colors.purple)),
                //                     onPressed: () {},
                //                     child: const Text(
                //                       'Submit',
                //                       style: TextStyle(
                //                           color:
                //                               Color.fromRGBO(255, 255, 255, 1)),
                //                     ),
                //                   ),
                //                 ],
                //               )
                //             ],
                //           ),
                //         );
                //       },
                //       child: Row(
                //         children: const [
                //           Text(
                //             ' ',
                //             style: TextStyle(color: Colors.white),
                //           ),
                //         ],
                //       ))
              ],
            ),
          ),
          // Padding(
          //   padding:
          //       const EdgeInsets.all(8.0),
          //   child: SingleChildScrollView(
          //     scrollDirection:
          //         Axis.horizontal,
          //     child: Row(
          //       children: [
          //         CircleAvatar(
          //           radius: 23,
          //           backgroundImage:
          //               NetworkImage(
          //             works["thumbnail"] ??
          //                 "",
          //             // 'https://via.placeholder.com/150',
          //           ),
          //         ),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Column(
          //           crossAxisAlignment:
          //               CrossAxisAlignment
          //                   .start,
          //           children: [
          //             Text(
          //               works["title"] ??
          //                   "",
          //               style: TextStyle(
          //                   fontWeight:
          //                       FontWeight
          //                           .bold,
          //                   fontSize: 17),
          //             ),
          //             Text(
          //               works["company"] ??
          //                   "",
          //               style: TextStyle(
          //                   color: Colors
          //                       .grey),
          //             ),
          //             Text(
          //               works["startDate"] ??
          //                   "",
          //               style: TextStyle(
          //                   color: Colors
          //                       .grey),
          //             ),
          //             Text(
          //               works["endDate"] ??
          //                   "",
          //               style: TextStyle(
          //                   color: Colors
          //                       .grey),
          //             ),
          //             Text(
          //               works["address"] ??
          //                   "",
          //               style: TextStyle(
          //                   color: Colors
          //                       .grey),
          //             ),
          //             Text(
          //               works["description"] ??
          //                   "",
          //               style: TextStyle(
          //                   color: Colors
          //                       .grey),
          //             ),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          const Icon(
            Icons.archive_outlined,
            size: 50,
            color: Colors.grey,
          ),
          const Text(
            'No Data',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class noexpertise extends StatefulWidget {
  const noexpertise({super.key});

  @override
  State<noexpertise> createState() => _noexpertiseState();
}

class _noexpertiseState extends State<noexpertise> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Expertise',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('This information can be edited from your profil')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // ElevatedButton(
                //     onPressed: () {
                //       showDialog(
                //         context: context,
                //         builder: (context) => AlertDialog(
                //           title: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: const [
                //               Text('Add Work'),
                //             ],
                //           ),
                //           actions: [
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 const Text('Title'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText: 'Enter your job title',
                //                       border: OutlineInputBorder()),
                //                 ),
                //               ],
                //             ),
                //             const SizedBox(
                //               height: 20,
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.end,
                //               children: [
                //                 ElevatedButton(
                //                     style: const ButtonStyle(
                //                         backgroundColor:
                //                             MaterialStatePropertyAll(
                //                                 Colors.white)),
                //                     onPressed: () {
                //                       Navigator.of(context).pop();
                //                     },
                //                     child: const Text('Cancel')),
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //                 ElevatedButton(
                //                   style: const ButtonStyle(
                //                       backgroundColor: MaterialStatePropertyAll(
                //                           Colors.purple)),
                //                   onPressed: () {},
                //                   child: const Text(
                //                     'Submit',
                //                     style: TextStyle(
                //                         color:
                //                             Color.fromRGBO(255, 255, 255, 1)),
                //                   ),
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       );
                //     },
                //     child: Row(
                //         // children: const [
                //         //   Icon(
                //         //     Icons.add_circle,
                //         //     color: Colors.white,
                //         //     size: 15,
                //         //   ),
                //         //   Text(
                //         //     ' Create New',
                //         //     style: TextStyle(color: Colors.white),
                //         //   ),
                //         // ],
                //         ))
              ],
            ),
          ),
          // Padding(
          //   padding:
          //       const EdgeInsets.all(8.0),
          //   child: Row(
          //     mainAxisAlignment:
          //         MainAxisAlignment.start,
          //     children: [
          //       Text(
          //         skilss["name"] ?? "",
          //         style: TextStyle(
          //             fontSize: 17,
          //             fontWeight:
          //                 FontWeight
          //                     .bold),
          //       ),
          //     ],
          //   ),
          // )
          const Icon(
            Icons.archive_outlined,
            size: 50,
            color: Colors.grey,
          ),
          const Text(
            'No Data',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class noslide extends StatefulWidget {
  const noslide({super.key});

  @override
  State<noslide> createState() => _noslideState();
}

class _noslideState extends State<noslide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Presentation Slide',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('This information can be edited from your profil')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // ElevatedButton(
                //     onPressed: () {
                //       showDialog(
                //         context: context,
                //         builder: (context) => AlertDialog(
                //           title: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: const [
                //               Text('Add Presentation'),
                //             ],
                //           ),
                //           actions: [
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 const Text('Slide Title'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText: 'Enter slide title',
                //                       border: OutlineInputBorder()),
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 const Text('Thumbnail'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText: 'Your Degree',
                //                       border: OutlineInputBorder()),
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 const Text('Embed Link'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText:
                //                           'e.g https://docs.google.com/presentation/d/e/2PACX..',
                //                       border: OutlineInputBorder()),
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 const Text('Note'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText: 'Add note',
                //                       border: OutlineInputBorder()),
                //                 ),
                //               ],
                //             ),
                //             const SizedBox(
                //               height: 20,
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.end,
                //               children: [
                //                 ElevatedButton(
                //                     style: const ButtonStyle(
                //                         backgroundColor:
                //                             MaterialStatePropertyAll(
                //                                 Colors.white)),
                //                     onPressed: () {
                //                       Navigator.of(context).pop();
                //                     },
                //                     child: const Text('Cancel')),
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //                 ElevatedButton(
                //                   style: const ButtonStyle(
                //                       backgroundColor: MaterialStatePropertyAll(
                //                           Colors.purple)),
                //                   onPressed: () {},
                //                   child: const Text(
                //                     'Submit',
                //                     style: TextStyle(
                //                         color:
                //                             Color.fromRGBO(255, 255, 255, 1)),
                //                   ),
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       );
                //     },
                //     child: Row(
                //         // children: const [
                //         //   Icon(
                //         //     Icons.add_circle,
                //         //     color: Colors.white,
                //         //     size: 15,
                //         //   ),
                //         //   Text(
                //         //     ' Create New',
                //         //     style: TextStyle(color: Colors.white),
                //         //   ),
                //         // ],
                //         ))
              ],
            ),
          ),
          // Padding(
          //   padding:
          //       const EdgeInsets.all(8.0),
          //   child: Column(
          //     crossAxisAlignment:
          //         CrossAxisAlignment
          //             .start,
          //     children: [
          //       Text(project["title"] ??
          //           ""),
          //       Text(project["link"] ??
          //           ""),
          //       Text(project["note"] ??
          //           ""),
          //     ],
          //   ),
          // )
          Center(
            child: Column(
              children: const [
                Icon(
                  Icons.archive_outlined,
                  size: 50,
                  color: Colors.grey,
                ),
                Text(
                  'No Data',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class noporto extends StatefulWidget {
  const noporto({super.key});

  @override
  State<noporto> createState() => _noportoState();
}

class _noportoState extends State<noporto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Portfolio',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('This information can be edited from your profil')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // ElevatedButton(
                //     onPressed: () {
                //       showDialog(
                //         context: context,
                //         builder: (context) => AlertDialog(
                //           title: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: const [
                //               Text('Add Presentation'),
                //             ],
                //           ),
                //           actions: [
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 const Text('Slide Title'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText: 'Enter slide title',
                //                       border: OutlineInputBorder()),
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 const Text('Thumbnail'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText: 'Your Degree',
                //                       border: OutlineInputBorder()),
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 const Text('Embed Link'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText:
                //                           'e.g https://docs.google.com/presentation/d/e/2PACX..',
                //                       border: OutlineInputBorder()),
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 const Text('Note'),
                //                 TextFormField(
                //                   decoration: const InputDecoration(
                //                       hintText: 'Add note',
                //                       border: OutlineInputBorder()),
                //                 ),
                //               ],
                //             ),
                //             const SizedBox(
                //               height: 20,
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.end,
                //               children: [
                //                 ElevatedButton(
                //                     style: const ButtonStyle(
                //                         backgroundColor:
                //                             MaterialStatePropertyAll(
                //                                 Colors.white)),
                //                     onPressed: () {
                //                       Navigator.of(context).pop();
                //                     },
                //                     child: const Text('Cancel')),
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //                 ElevatedButton(
                //                   style: const ButtonStyle(
                //                       backgroundColor: MaterialStatePropertyAll(
                //                           Colors.purple)),
                //                   onPressed: () {},
                //                   child: const Text(
                //                     'Submit',
                //                     style: TextStyle(
                //                         color:
                //                             Color.fromRGBO(255, 255, 255, 1)),
                //                   ),
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       );
                //     },
                //     child: Row(
                //         // children: const [
                //         //   Icon(
                //         //     Icons.add_circle,
                //         //     color: Colors.white,
                //         //     size: 15,
                //         //   ),
                //         //   Text(
                //         //     ' Create New',
                //         //     style: TextStyle(color: Colors.white),
                //         //   ),
                //         // ],
                //         ))
              ],
            ),
          ),
          // Padding(
          //   padding:
          //       const EdgeInsets.all(8.0),
          //   child: Column(
          //     crossAxisAlignment:
          //         CrossAxisAlignment
          //             .start,
          //     children: [
          //       Text(project1["title"] ??
          //           ""),
          //       Text(project1["link"] ??
          //           ""),
          //       Text(project1["note"] ??
          //           ""),
          //     ],
          //   ),
          // )

          Center(
            child: Column(
              children: const [
                Icon(
                  Icons.archive_outlined,
                  size: 50,
                  color: Colors.grey,
                ),
                Text(
                  'No Data',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
