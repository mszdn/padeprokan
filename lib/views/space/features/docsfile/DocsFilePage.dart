import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget_docsfile.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class Docsfile extends StatefulWidget {
  const Docsfile({super.key});

  @override
  State<Docsfile> createState() => _DocsfileState();
}

class _DocsfileState extends State<Docsfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, 'Docs & Files'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Container(
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200, width: 0.5),
              ),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 20),
                    hintText: "search file or folder",
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
          ),
          const Getimage(),
        ],
      ),
      floatingActionButton: SpeedDial(
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
        // openBackgroundColor: ColorStyle().kuningColor,

        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
              child: const Icon(
                Icons.add_to_drive_outlined, color: Colors.white,
                // size: ,
              ),
              label: "Google Drive",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Row(
                      children: [
                        const Text(
                          "Embed link from google Drive",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: IconButton(
                            alignment: Alignment.centerRight,
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close),
                            iconSize: 14,
                          ),
                        ),
                      ],
                    ),
                    content: Container(
                      height: 275,
                      width: 315,
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text('File name'),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 47,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                hoverColor: Colors.purple,
                                hintText: 'Untitled',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Text('Embed link'),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  '*',
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
                          Container(
                            height: 47,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText:
                                    'e.g.https://drive.google.com/open?id=1cMc-qT_W..',
                                hintStyle: const TextStyle(color: Colors.grey),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 1,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Spacer(),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color:
                                              const Color.fromRGBO(173, 120, 211, 1),
                                        ),
                                      ),
                                      child: TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          SpeedDialChild(
              child: const Icon(
                Icons.cloud_upload_outlined, color: Colors.white,
                // size: ,
              ),
              label: "Upload File",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Text(
                            "Upload Files",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 230,
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    content: Container(
                      height: 160,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple),
                          color: Colors.grey.shade200),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: const [
                              Icon(
                                Icons.archive_outlined,
                                size: 40,
                                color: Color.fromRGBO(173, 120, 211, 1),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Click or drag file to this area to upload',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Support for a single or bulk upload. Strictly prohibit from uploading company data or other band files',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Spacer(),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.purple)),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text('Upload',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
          SpeedDialChild(
            child: const Icon(
              Icons.create_new_folder_outlined, color: Colors.white,
              // size: ,
            ),
            label: 'Add Folder',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Add Folder"),
                            const SizedBox(
                              width: 240,
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Text(
                              "Folder Name",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 14),
                            ),
                            Padding(padding: EdgeInsets.only(right: 300)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  content: Container(
                    height: 40,
                    width: 400,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        hintText: "New Folder Name",
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Spacer(),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.purple)),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Submit',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.upload_file, color: Colors.white,
              // size: ,
            ),
            label: 'New File Txt',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 350,
                        child: Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                              ),
                              child: const TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 1,
                                decoration: InputDecoration.collapsed(
                                  border: InputBorder.none,
                                  hintText: 'File Name',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        width: 350,
                        child: Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                              ),
                              child: const TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 7,
                                decoration: InputDecoration.collapsed(
                                  border: InputBorder.none,
                                  hintText: 'Write your document here',
                                  hintStyle: TextStyle(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.green),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.file_copy,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Save & Publish",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
        closedForegroundColor: ColorStyle().yellowButton,
        openForegroundColor: ColorStyle().yellowButton,
        closedBackgroundColor: ColorStyle().yellowButton,
        openBackgroundColor: ColorStyle().yellowButton,
        labelsStyle: const TextStyle(color: Colors.white),
        labelsBackgroundColor: const Color.fromRGBO(0, 0, 0, 0.500),
      ),
    );
  }
}

class Getimage extends StatefulWidget {
  const Getimage({super.key});

  @override
  State<Getimage> createState() => _GetimageState();
}

class _GetimageState extends State<Getimage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            'assets/images/docs.png',
            width: MediaQuery.of(context).size.width / 2,
          ),
          const Text(
            "You don't have any file!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text(
                      'Upload your first file',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const Text(
                                    'Upload files',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 230,
                                  ),
                                  IconButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      icon: const Icon(Icons.close)),
                                ],
                              ),
                            ),
                            content: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.purple),
                                  color: Colors.grey.shade200),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.close),
                                      Text(
                                        'Click or drag file to this area to upload',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        'Support for a singel or bulk upload. Strictly prohibit',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      ),
                                      Text(
                                        'from uploading company data or other band files',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Spacer(),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.purple)),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text('Upload',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
