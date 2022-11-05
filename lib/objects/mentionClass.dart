import 'dart:convert';

import 'package:safra/backend/supabase.dart';

List<Mention> mentionFromJson(String str) =>
    List<Mention>.from(json.decode(str).map((x) => Mention.fromJson(x)));

String mentionToJson(List<Mention> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mention {
  Mention({
    required this.mentionId,
    required this.susername,
    required this.message,
    required this.uid,
    required this.trip_id,
    required this.trip_name,
  });

  String mentionId;
  String susername;
  String message;
  String uid;
  String trip_id;
  String trip_name;

  factory Mention.fromJson(Map<String, dynamic> json) => Mention(
        mentionId: json["mention_id"],
        susername: json["susername"],
        message: json["message"],
        uid: json["uid"],
        trip_name: json["trip_name"],
        trip_id: json["trip_id"],
      );

  Map<String, dynamic> toJson() => {
        "mention_id": mentionId,
        "susername": susername,
        "message": message,
        "uid": uid,
        "trip_name": trip_name,
        "trip_id": trip_id,
      };

  static Future<List<Mention>?> readRequests(String uid) async {
    final response = await SupaBase_Manager()
        .client
        .from('mention')
        .select()
        .eq('uid', uid)
        .like('message', '%Has Requested%')
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

Future addMention(
    {required String mentionId,
    required String susername,
    required String message,
    required String uid,
    required String trip_name,
    required String trip_id}) async {
  final mention = Mention(
      mentionId: mentionId,
      susername: susername,
      trip_name: trip_name,
      message: message,
      uid: uid,
      trip_id: trip_id);

  await SupaBase_Manager()
      .client
      .from('mention')
      .insert([mention.toJson()]).execute();
}
