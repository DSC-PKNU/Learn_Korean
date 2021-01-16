import 'package:flutter_tts/flutter_tts.dart';

FlutterTts flutterTts = FlutterTts();

Future ttsSpeak(String str) async {
  await ttsStop();
  flutterTts.setLanguage("ko-KR");
  flutterTts.setPitch(0.75);
  flutterTts.setSpeechRate(0.35);
  await flutterTts.speak(str);
}

ttsStop() async {
  await flutterTts.pause();
}
