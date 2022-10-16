import 'dart:convert';

import 'package:safra/backend/supabase.dart';

List<Comments> commentsFromJson(String str) =>
    List<Comments>.from(json.decode(str).map((x) => Comments.fromJson(x)));

String commentsToJson(List<Comments> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comments {
  Comments({
    required this.comment_id,
    required this.fsqId,
    required this.comment,
    required this.uid,
    required this.likes,
    required this.dislikes,
  });

  String comment_id;
  String fsqId;
  String comment;
  String uid;
  int likes;
  int dislikes;

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        comment_id: json["comment_id"],
        uid: json["uid"],
        fsqId: json["fsq_id"],
        comment: json["comment"],
        likes: json["likes"],
        dislikes: json["dislikes"],
      );

  Map<String, dynamic> toJson() => {
        "comment_id": comment_id,
        "fsq_id": fsqId,
        "uid": uid,
        "comment": comment,
        "likes": likes,
        "dislikes": dislikes,
      };
  static Future<List<Comments>?> readComments(String fsq_id) async {
    final response = await SupaBase_Manager()
        .client
        .from('comments')
        .select()
        .eq('fsq_id', fsq_id)
        .execute();

    if (response.error == null) {
      var data = response.data.toString();
      data = data.replaceAll('{', '{"');
      data = data.replaceAll(': ', '": "');
      data = data.replaceAll(', ', '", "');
      data = data.replaceAll('}', '"}');
      data = data.replaceAll('}",', '},');
      data = data.replaceAll('"{', '{');
      data = data.replaceAll('"0"', '0');
      data = data.replaceAll('"1"', '1');
      data = data.replaceAll('"2"', '2');
      data = data.replaceAll('"3"', '3');
      data = data.replaceAll('"4"', '4');
      data = data.replaceAll('"5"', '5');

      return commentsFromJson(data);
    }
  }

  static Future<bool> increment_likes(String comment_id, int likes) async {
    final response = await SupaBase_Manager().client.from('comments').update(
        {'likes': likes + 1}).match({'comment_id': comment_id}).execute();
    if (response.error == null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> increment_dislikes(
      String comment_id, int dislikes) async {
    final response = await SupaBase_Manager().client.from('comments').update(
        {'dislikes': dislikes + 1}).match({'comment_id': comment_id}).execute();

    if (response.error == null) {
      return true;
    } else {
      return false;
    }
  }
}

Future addComment(
    {required String comment_id,
    required String fsq_id,
    required String comment,
    required int likes,
    required String uid,
    required int dislikes}) async {
  final comments = Comments(
      comment_id: comment_id,
      fsqId: fsq_id,
      uid: uid,
      comment: comment,
      likes: likes,
      dislikes: dislikes);

  final doc = await SupaBase_Manager()
      .client
      .from('comments')
      .insert([comments.toJson()]).execute();
}
