import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:http_parser/http_parser.dart';

String ppp = """
mutation UploadFile(\$input: CreateUserFileInput!) {
      createUserFile(input: \$input) {
        id
        title: name
        type
        url
        owncloudUrl
        embedLink
        downloadUrl
        path
        createdBy {
          id
        }
      }
    }""";

class DocsFilesViewDummy extends StatefulWidget {
  const DocsFilesViewDummy({super.key});

  @override
  State<DocsFilesViewDummy> createState() => _DocsFilesViewDummyState();
}

class _DocsFilesViewDummyState extends State<DocsFilesViewDummy> {
  File? imager;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // File imager;
    // Future selectImage() async {
    //   // final ImagePicker picker = ImagePicker();
    //   // // Pick an image
    //   // final image = await picker.pickImage(source: ImageSource.gallery);
    //   // setState(() {
    //   //   imager = File(image);
    //   // });
    // }
    // File? selectedImage;

    Future getImage() async {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      // print(image!.path);
      setState(() {
        imager = File(image!.path);

        // print(multipartFile);
      });
    }

    return Scaffold(
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            if (imager != null)
              Mutation(
                options: MutationOptions(
                  document: gql(ppp),
                  onCompleted: (dynamic resultData) {
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
                      height: 50,
                      child: ElevatedButton(
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            var byteData = imager!.readAsBytesSync();
                            var multipartFile = MultipartFile.fromBytes(
                              'photo',
                              byteData,
                              filename: '${DateTime.now().second}.jpg',
                              contentType: MediaType(
                                  "file",
                                  imager!.path
                                      .split("/")
                                      .removeLast()
                                      .split(".")
                                      .removeLast()),
                            );

                            var fileType = {
                              "type": "file",
                              "ext": imager!.path
                                  .split("/")
                                  .removeLast()
                                  .split(".")
                                  .removeLast(),
                            };
                            runMutation({
                              "input": {
                                "name": imager!.path.split("/").removeLast(),
                                "url": multipartFile,
                                "spaceId": "63b52464e7e23f00392482c9",
                                "type": json.encode(fileType)
                              }
                            });
                          }),
                    ),
                  );
                },
              ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.photo_library),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text("Select File"),
                        ElevatedButton(
                            onPressed: () {
                              getImage();
                            },
                            child: const Text("aaaa"))
                      ],
                    ),
                  ),
                  // Mutation Widget Here
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
