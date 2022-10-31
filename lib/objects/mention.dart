import 'dart:convert';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/TripsInfo.dart';
import 'package:safra/objects/participate.dart';

List<mention> mentionFromJson(String str) =>
    List<mention>.from(json.decode(str).map((x) => mention.fromJson(x)));

class mention {
  mention({
    required this.uid,
    required this.comment_id,
    required this.comment,
    required this.likes,
    required this.dislikes,
  });

  String uid;
  String comment;
  String comment_id;
  int likes;
  int dislikes;

  factory mention.fromJson(Map<String, dynamic> json) => mention(
        comment_id: json["comment_id"],
        uid: json["uid"],
        comment: json["comment"],
        likes: json["likes"],
        dislikes: json["dislikes"],
      );
}

Future<List<mention>?> readMention(String uid) async {
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
