import 'dart:convert';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/TripsInfo.dart';
import 'package:safra/objects/participate.dart';

List<displayMention> mentionFromJson(String str) => List<displayMention>.from(
    json.decode(str).map((x) => displayMention.fromJson(x)));

class displayMention {
  displayMention({
    required this.uid,
    required this.comment_id,
    required this.comment,
    required this.likes,
    required this.dislikes,
    required this.fsq_id,
  });

  String uid;
  String comment;
  String comment_id;
  int likes;
  int dislikes;
  String fsq_id;

  factory displayMention.fromJson(Map<String, dynamic> json) => displayMention(
      comment_id: json["comment_id"],
      uid: json["uid"],
      comment: json["comment"],
      likes: json["likes"],
      dislikes: json["dislikes"],
      fsq_id: json['fsq_id']);

  static Future<List<displayMention>?> readMention(String uid) async {
    final response = await SupaBase_Manager()
        .client
        .from('comments')
        .select()
        .eq('uid', uid)
        .execute();

    if (response.error == null) {
      var data = response.data.toString();
      data = data.replaceAll('{', '{"');
      data = data.replaceAll(': ', '": "');
      data = data.replaceAll(', ', '", "');
      data = data.replaceAll('}', '"}');
      data = data.replaceAll('}",', '},');
      data = data.replaceAll('"{', '{');
      return mentionFromJson(data);
    }
  }
}
