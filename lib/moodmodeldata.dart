class MoodModel {
  MoodModel(
      {this.count,
      this.msg,
      this.data,
      this.teamMood,
      this.moodalytics,
      this.responseCode});

  MoodModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    teamMood = json['team_mood'];
    if (json['moodalytics'] != null) {
      moodalytics = <Moodalytics>[];
      json['moodalytics'].forEach((v) {
        moodalytics!.add(new Moodalytics.fromJson(v));
      });
    }
    responseCode = json['response_code'];
  }

  int? count;
  Data? data;
  List<Moodalytics>? moodalytics;
  String? msg;
  int? responseCode;
  int? teamMood;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['team_mood'] = this.teamMood;
    if (this.moodalytics != null) {
      data['moodalytics'] = this.moodalytics!.map((v) => v.toJson()).toList();
    }
    data['response_code'] = this.responseCode;
    return data;
  }
}

class Data {
  Data(
      {this.managerId,
      this.description,
      this.emojiPoint,
      this.userProfile,
      this.reasonType});

  Data.fromJson(Map<String, dynamic> json) {
    managerId = json['manager_id'];
    description = json['description'];
    emojiPoint = json['emoji_point'];
    userProfile = json['user_profile'];
    reasonType = json['reason_type'];
  }

  String? description;
  Null? emojiPoint;
  Null? managerId;
  Null? reasonType;
  Null? userProfile;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manager_id'] = this.managerId;
    data['description'] = this.description;
    data['emoji_point'] = this.emojiPoint;
    data['user_profile'] = this.userProfile;
    data['reason_type'] = this.reasonType;
    return data;
  }
}

class Moodalytics {
  Moodalytics(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.userProfileId,
      this.reasonTypeId,
      this.managerId,
      this.description,
      this.emojiPoint});

  Moodalytics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userProfileId = json['user_profile_id'];
    reasonTypeId = json['reason_type_id'];
    managerId = json['manager_id'];
    description = json['description'];
    emojiPoint = json['emoji_point'];
  }

  String? createdAt;
  String? description;
  int? emojiPoint;
  int? id;
  int? managerId;
  int? reasonTypeId;
  String? updatedAt;
  int? userProfileId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_profile_id'] = this.userProfileId;
    data['reason_type_id'] = this.reasonTypeId;
    data['manager_id'] = this.managerId;
    data['description'] = this.description;
    data['emoji_point'] = this.emojiPoint;
    return data;
  }
}
