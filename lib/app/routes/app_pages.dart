import 'package:get/get.dart';
import 'package:linkchat/app/modules/room_chat/views/room_conversation_view.dart';

import '../modules/audio_call/bindings/audio_call_binding.dart';
import '../modules/audio_call/views/audio_call_view.dart';
import '../modules/block_list/bindings/block_list_binding.dart';
import '../modules/block_list/views/block_list_view.dart';
import '../modules/call_list/bindings/call_list_binding.dart';
import '../modules/call_list/views/call_list_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/dialer/bindings/dialer_binding.dart';
import '../modules/dialer/views/dialer_view.dart';
import '../modules/email_verification/bindings/email_verification_binding.dart';
import '../modules/email_verification/views/email_verification_view.dart';
import '../modules/followers/bindings/followers_binding.dart';
import '../modules/followers/views/followers_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/links/bindings/linklist_binding.dart';
import '../modules/links/views/linklist_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/email_login/bindings/email_login_binding.dart';
import '../modules/login/email_login/views/email_login_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/match/bindings/match_binding.dart';
import '../modules/match/views/match_view.dart';
import '../modules/message/bindings/message_binding.dart';
import '../modules/message/views/message_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/otp_verification/views/otp_verification_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/profile/edit_profile/views/edit_profile_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/random_call/bindings/random_call_binding.dart';
import '../modules/random_call/views/random_call_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/room_chat/bindings/room_chat_binding.dart';
import '../modules/room_chat/views/room_chat_view.dart';
import '../modules/room_explore/bindings/room_explore_binding.dart';
import '../modules/room_explore/views/room_explore_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/setup_pin/bindings/setup_pin_binding.dart';
import '../modules/setup_pin/views/setup_pin_view.dart';
import '../modules/video_call/bindings/video_call_binding.dart';
import '../modules/video_call/views/video_call_view.dart';
import '../services/auth_service.dart';

// ignore_for_file: non_constant_identifier_names

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final INITIAL =
      AuthService().checkLoggedIn() ? Routes.HOME : Routes.LOGIN;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        bindings: [HomeBinding(), LinklistBinding()]),
    GetPage(
      name: _Paths.CALL,
      page: () => const CallListView(),
      bindings: [CallListBinding(), LinklistBinding()],
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.DIALER,
      page: () => const DialerView(),
      binding: DialerBinding(),
    ),
    GetPage(
      name: _Paths.LINK_LIST,
      page: () => LinklistView(),
      binding: LinklistBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      children: [
        GetPage(
          name: _Paths.EDIT_PROFILE,
          page: () => const EditProfileView(),
          binding: EditProfileBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      children: [
        GetPage(
          name: _Paths.EMAIL_LOGIN,
          page: () => const EmailLoginView(),
          binding: EmailLoginBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      bindings: [
        SettingsBinding(),
        BlockListBinding(),
        SetupPinBinding(),
        LinklistBinding()
      ],
    ),
    GetPage(
      name: _Paths.AUDIO_CALL,
      page: () => const AudioCallView(),
      binding: AudioCallBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_CALL,
      page: () => VideoCallView(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: _Paths.RANDOM_CALL,
      page: () => const RandomCallView(),
      binding: RandomCallBinding(),
    ),
    GetPage(
      name: _Paths.BLOCK_LIST,
      page: () => BlockListView(),
      bindings: [BlockListBinding(), LinklistBinding()],
    ),
    GetPage(
      name: _Paths.SETUP_PIN,
      page: () => const SetupPinView(),
      binding: SetupPinBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.EMAIL_VERIFICATION,
      page: () => const EmailVerificationView(),
      binding: EmailVerificationBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFICATION,
      page: () => const OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.FOLLOWERS,
      page: () => const FollowersView(),
      binding: FollowersBinding(),
    ),
    GetPage(
      name: _Paths.MATCH,
      page: () => const MatchView(),
      binding: MatchBinding(),
    ),
    GetPage(
      name: _Paths.ROOM_CHAT,
      page: () => const RoomChatView(),
      binding: RoomChatBinding(),
    ),
    GetPage(
      name: _Paths.ROOM_EXPLORE,
      page: () => const RoomExploreView(),
      binding: RoomExploreBinding(),
    ),
    GetPage(
      name: _Paths.ROOM_CONVERSATION,
      page: () => const RoomConversationView(),
      binding: RoomChatBinding(),
    ),
  ];
}
