import 'dart:convert';

import 'package:safra/backend/supabase.dart';

List<CommentForTrips> commentForTripsFromJson(String str) =>
    List<CommentForTrips>.from(
        json.decode(str).map((x) => CommentForTrips.fromJson(x)));

String commentForTripsToJson(List<CommentForTrips> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentForTrips {
  CommentForTrips({
    required this.trip_comment_id,
    required this.trip_id,
    required this.username,
    required this.comment,
    required this.likes,
    required this.dislikes,
  });

  String trip_comment_id;
  String trip_id;
  String username;
  String comment;
  int likes;
  int dislikes;

  factory CommentForTrips.fromJson(Map<String, dynamic> json) =>
      CommentForTrips(
        trip_comment_id: json["trip_comment_id"],
        trip_id: json["trip_id"],
        username: json["username"],
        comment: json["comment"],
        likes: json["likes"],
        dislikes: json["dislikes"],
      );

  Map<String, dynamic> toJson() => {
        "trip_comment_id": trip_comment_id,
        "trip_id": trip_id,
        "username": username,
        "comment": comment,
        "likes": likes,
        "dislikes": dislikes,
      };

  static Future<List<CommentForTrips>?> readComments(String trip_id) async {
    final response = await SupaBase_Manager()
        .client
        .from('trip_comments')
        .select()
        .eq('trip_id', trip_id)
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
      data = data.replaceAll('"6"', '6');

      return commentForTripsFromJson(data);
    }
  }

  static Future<bool> increment_likes(String comment_id, int likes) async {
    final response = await SupaBase_Manager()
        .client
        .from('trip_comments')
        .update({'likes': likes + 1}).match(
            {'trip_comment_id': comment_id}).execute();
    if (response.error == null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> increment_dislikes(
      String comment_id, int dislikes) async {
    final response = await SupaBase_Manager()
        .client
        .from('trip_comments')
        .update({'dislikes': dislikes + 1}).match(
            {'trip_comment_id': comment_id}).execute();

    if (response.error == null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> addCommentInTrips(
      {required String trip_comment_id,
      required String trip_id,
      required String comment,
      required int likes,
      required String username,
      required int dislikes}) async {
    final commentForTrips = CommentForTrips(
        trip_comment_id: trip_comment_id,
        trip_id: trip_id,
        username: username,
        comment: comment,
        likes: likes,
        dislikes: dislikes);

    final doc = await SupaBase_Manager()
        .client
        .from('trip_comments')
        .insert([commentForTrips.toJson()]).execute();
    if (doc.error == null) {
      return true;
    } else {
      return false;
    }
  }
}
