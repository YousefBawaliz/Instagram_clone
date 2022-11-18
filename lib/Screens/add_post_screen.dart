import 'package:flutter/material.dart';
import 'package:instagram_clone/Provider/user_provider.dart';
import 'package:instagram_clone/Utils/colors.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Post to',
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: () => postImage(
              userProvider.getUser.uid,
              userProvider.getUser.username,
              userProvider.getUser.photoUrl,
            ),
            child: const Text(
              "Post",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          )
        ],
      ),
      // POST FORM
      body: Column(
        children: <Widget>[
          isLoading
              ? const LinearProgressIndicator()
              : const Padding(padding: EdgeInsets.only(top: 0.0)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  userProvider.getUser.photoUrl,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      hintText: "Write a caption...", border: InputBorder.none),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //   fit: BoxFit.fill,
                      //   alignment: FractionalOffset.topCenter,
                      //   image: MemoryImage(_file!),
                      // )),
                      ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
