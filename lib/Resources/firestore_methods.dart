import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/Models/comment.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //upload post function
  Future<String> uploadPost(
      String commentText, String uid, String username) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String commentId = const Uuid().v1();
      Comment post = Comment(
        commentText: commentText,
        uid: uid,
        username: username,
        // likes: [],
        commentId: commentId,
        datePublished: DateTime.now(),
        // postUrl: photoUrl,
        // profImage: profImage,
      );
      _firestore.collection('posts').doc(commentId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> addFavourite(String commentId) async {
    String userId = await _auth.currentUser!.uid;
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(commentId).update({
        'favouritedBy': [userId]
      });
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
