import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';
import 'package:padeprokan/graphql/info_board/post_board.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoBoardPage extends StatefulWidget {
  final String spaceId;
  const InfoBoardPage({super.key, required this.spaceId});

  @override
  State<InfoBoardPage> createState() => _InfoBoardPageState();
}

class _InfoBoardPageState extends State<InfoBoardPage> {
  final TextEditingController _infoBoard = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle().scaffoldcolor,
      appBar: appBarWidget(context, 'Info Board'),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.red,
                            child: Text('M'),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _infoBoard,
                            maxLines: 2,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'What Do You Think',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {},
                        child: const Text('Post'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ListInfoBoards()
          ],
        ),
      ),
    );
  }
}

class ListInfoBoards extends StatefulWidget {
  const ListInfoBoards({super.key});

  @override
  State<ListInfoBoards> createState() => _ListInfoBoardsState();
}

class _ListInfoBoardsState extends State<ListInfoBoards> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 16,
                  child: Text('M'),
                ),
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('My Name'),
                  ),
                  const Text('a minute ago')
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                top: 10,
                bottom: 8,
              ),
              child: Text('Hai bro'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send),
                  ),
                  hintText: 'Type your massage ',
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide())),
            ),
          ),
        ],
      ),
    );
  }
}
