import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String commentText;
  final String uid;
  final String username;
  // final likes;
  final String commentId;
  final DateTime datePublished;
  // final String CommentUrl;
  // final String profImage;

  const Comment({
    required this.commentText,
    required this.uid,
    required this.username,
    // required this.likes,
    required this.commentId,
    required this.datePublished,
    // required this.CommentUrl,
    // required this.profImage,
  });

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Comment(
      commentText: snapshot["commentText"],
      uid: snapshot["uid"],
      // likes: snapshot["likes"],
      commentId: snapshot["CommentId"],
      datePublished: snapshot["datePublished"],
      username: snapshot["username"],
      // CommentUrl: snapshot['CommentUrl'],
      // profImage: snapshot['profImage']
    );
  }

  Map<String, dynamic> toJson() => {
        "commentText": commentText,
        "uid": uid,
        // "likes": likes,
        "username": username,
        "CommentId": commentId,
        "datePublished": datePublished,
        // 'CommentUrl': CommentUrl,
        // 'profImage': profImage
      };
}
