class CallModel {
  CallModel({
    required this.callId,
    required this.callerId,
    required this.receiverId,
    required this.callType,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.isComplete,
    required this.participants,
    required this.media,
    required this.network,
  });
  late final int callId;
  late final int callerId;
  late final int receiverId;
  late final String callType;
  late final String startTime;
  late final String endTime;
  late final int duration;
  late final bool isComplete;
  late final List<Participants> participants;
  late final Media media;
  late final Network network;

  CallModel.fromJson(Map<String, dynamic> json) {
    callId = json['callId'];
    callerId = json['callerId'];
    receiverId = json['receiverId'];
    callType = json['callType'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    duration = json['duration'];
    isComplete = json['status'];
    participants = List.from(json['participants'])
        .map((e) => Participants.fromJson(e))
        .toList();
    media = Media.fromJson(json['media']);
    network = Network.fromJson(json['network']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['callId'] = callId;
    data['callerId'] = callerId;
    data['receiverId'] = receiverId;
    data['callType'] = callType;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['duration'] = duration;
    data['status'] = isComplete;
    data['participants'] = participants.map((e) => e.toJson()).toList();
    data['media'] = media.toJson();
    data['network'] = network.toJson();
    return data;
  }
}

class Participants {
  Participants({
    required this.userId,
    required this.displayName,
    required this.avatar,
  });
  late final int userId;
  late final String displayName;
  late final String avatar;

  Participants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    displayName = json['displayName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['displayName'] = displayName;
    data['avatar'] = avatar;
    return data;
  }
}

class Media {
  Media({
    required this.audio,
    required this.video,
  });
  late final Audio audio;
  late final Video video;

  Media.fromJson(Map<String, dynamic> json) {
    audio = Audio.fromJson(json['audio']);
    video = Video.fromJson(json['video']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['audio'] = audio.toJson();
    data['video'] = video.toJson();
    return data;
  }
}

class Audio {
  Audio({
    required this.enabled,
    required this.muted,
  });
  late final bool enabled;
  late final bool muted;

  Audio.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    muted = json['muted'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['muted'] = muted;
    return data;
  }
}

class Video {
  Video({
    required this.enabled,
    required this.muted,
  });
  late final bool enabled;
  late final bool muted;

  Video.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    muted = json['muted'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['muted'] = muted;
    return data;
  }
}

class Network {
  Network({
    required this.type,
    required this.quality,
  });
  late final String type;
  late final String quality;

  Network.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    quality = json['quality'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['quality'] = quality;
    return data;
  }
}
