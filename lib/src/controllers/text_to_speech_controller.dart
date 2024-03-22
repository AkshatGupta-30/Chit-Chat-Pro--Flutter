import 'package:text_to_speech/text_to_speech.dart';
import 'package:get/get.dart';

class TTSController extends GetxController {
  final String text;
  TTSController(this.text);

  TextToSpeech tts = TextToSpeech();
  final double _volume = 1; //? Range: 0-1
  final double _rate = 1.0; //? Range: 0-2
  final double _pitch = 1.0; //? Range: 0-2

  late final _languageCode = ''.obs;
  late final voice = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _getVoice();
    _getLangCode();
    _setTTS();
  }

  Future<void> _getVoice() async {
    final String? defaultLangCode = await tts.getDefaultLanguage();
    final List<String>? voices = await tts.getVoiceByLang(defaultLangCode!);
    if (voices != null && voices.isNotEmpty) {
      voice.value = voices.first;
    }
  }

  Future<void> _getLangCode() async => _languageCode.value = (await tts.getDefaultLanguage())!;

  void _setTTS() {
    tts.setVolume(_volume);
    tts.setRate(_rate);
    tts.setLanguage(_languageCode.value);
    tts.setPitch(_pitch);
  }

  void speak() => tts.speak(text);
  void pause() => tts.pause();
  void resume() => tts.resume();
  void stop() => tts.stop();
}