import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/add_post_screen.dart';
import 'package:instagram_clone/Screens/favourite_screen.dart';
import 'package:instagram_clone/Screens/feed_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  Comment_screen(),
  Text('text2'),
  AddPostScreen(),
  FavouriteScreen(),
  Text('text5'),
];
