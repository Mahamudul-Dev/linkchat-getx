
import '../models/call_model.dart';

final List<CallModel> calls = [
  CallModel(
      callId: 123456,
      callerId: 124561715,
      receiverId: 34757984127,
      callType: 'audio',
      startTime: "2023-05-30T10:00:00Z",
      endTime: "2023-05-30T10:30:00Z",
      duration: 30,
      isComplete: true,
      participants: [
        Participants(
            userId: 124561715,
            displayName: 'Mohammad Jashim Akbar',
            avatar:
                'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg')
      ],
      media: Media(
          audio: Audio(enabled: true, muted: false),
          video: Video(enabled: false, muted: false)),
      network: Network(type: 'wifi', quality: 'high'))
];
