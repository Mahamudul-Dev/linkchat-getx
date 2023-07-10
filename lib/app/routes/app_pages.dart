// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:linkchat/app/services/auth_service.dart';

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
import '../modules/followers/bindings/followers_binding.dart';
import '../modules/followers/views/followers_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/message/bindings/message_binding.dart';
import '../modules/message/views/message_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/random_call/bindings/random_call_binding.dart';
import '../modules/random_call/views/random_call_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/setup_pin/bindings/setup_pin_binding.dart';
import '../modules/setup_pin/views/setup_pin_view.dart';
import '../modules/video_call/bindings/video_call_binding.dart';
import '../modules/video_call/views/video_call_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final INITIAL = AuthService().checkLogedIn() ? Routes.HOME : Routes.REGISTER;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        bindings: [HomeBinding(), FollowersBinding()]),
    GetPage(
      name: _Paths.CALL,
      page: () => const CallListView(),
      bindings: [CallListBinding(), FollowersBinding()],
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
      name: _Paths.FOLLOWERS,
      page: () => FollowersView(),
      binding: FollowersBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
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
        FollowersBinding()
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
      bindings: [BlockListBinding(), FollowersBinding()],
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
  ];
}
