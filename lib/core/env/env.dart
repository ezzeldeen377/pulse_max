import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'assets/env/.env.dev')
abstract class Env {
  @EnviedField(varName: 'DOCTORS_TABLE', obfuscate: false)
  static const String doctorsTable = _Env.doctorsTable;

  @EnviedField(varName: 'PATIENTS_TABLE', obfuscate: false)
  static const String patientsTable = _Env.patientsTable;

  @EnviedField(varName: 'APPOINTMENTS_TABLE', obfuscate: false)
  static const String appointmentsTable = _Env.appointmentsTable;

  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static String apiKey = _Env.apiKey;

  @EnviedField(varName: 'BASE_URL', obfuscate: false)
  static const String baseUrl = _Env.baseUrl;
}
class ImageAssets {
  static const String ahmedPicture = 'assets/images/ahmed.png';
  static const String gemini = 'assets/images/Gemini.svg';
}

class IconAssets {
  static const String videoCall = 'assets/icons/video.svg';
  static const String call = 'assets/icons/call.svg';
  static const String camera = 'assets/icons/camera.svg';
  static const String send = 'assets/icons/send.svg';
  static const String create = 'assets/icons/create.svg';
}
