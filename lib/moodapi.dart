import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/moodmodeldata.dart';

class MoodAPI {
  static Future<MoodModel> getchardata() async {
    String baseurl =
        "http://api.reward-dragon.com:8000/customers/customer-josh-reason-today/?user_profile=500";

    var uri = Uri.parse(baseurl);

    var response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'c3fb04334a7c647338cdfd500e2997bb9898cf52',
      },
    );

    var responseJson = json.decode(response.body);

    return MoodModel.fromJson(responseJson);
  }

  static Future<List<MoodData>> mgetchardata() async {
    var futureMoodData = await getchardata();

    var moodalytics = futureMoodData.moodalytics;

    return moodalytics!
        .map((job) => MoodData(
              DateTime(
                int.parse(
                  job.createdAt!.split('-')[0],
                ),
                int.parse(
                  job.createdAt!.split('-')[1],
                ),
                int.parse(
                  job.createdAt!.split('-')[2],
                ),
              ),
              double.parse(job.emojiPoint.toString()),
            ))
        .toList();
  }
}

class MoodData {
  MoodData(this.date, this.emoji_point);

  final DateTime date;
  final double emoji_point;
}
