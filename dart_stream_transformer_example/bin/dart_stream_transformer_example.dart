// import 'package:dart_stream_transformer_example/dart_stream_transformer_example.dart' as dart_stream_transformer_example;

import 'dart:async';

//一个字母和空格流，空格分割的字母序列都是一个单词
Stream<String> buildLetterStream() async* {
  String s = "One World One Dream";
  for (int i = 0; i < s.length; i++) {
    String letter = s.substring(i, i + 1);
    yield letter;
  }
}

void main(List<String> arguments) async {
  // print('Hello world: ${dart_stream_transformer_example.calculate()}!');

  Stream<String> letterStream = buildLetterStream();
  var wordSplitter = WordSplitter();
  //字母组成单词。字母序列-->单词序列
  Stream<String> wordStream =
      letterStream.transform(wordSplitter.transformer());
  await wordStream.forEach((word) => print(word));
}

class WordSplitter {
  StreamTransformer<String, String>? _transformer; // Make it nullable
  StringBuffer _wordBuilder = new StringBuffer();

  StreamTransformer<String, String> transformer() {
    if (_transformer == null) { // Check for null and initialize if needed
      _transformer = StreamTransformer<String, String>.fromHandlers(
        handleData: _handleData, handleDone: _sinkWord);
    }
    return _transformer!;
  }

  void _handleData(String letter, EventSink<String> sink) {
    if (letter == " ") {
      _sinkWord(sink);
    } else {
      _wordBuilder.write(letter);
    }
  }

  void _sinkWord(EventSink<String> sink) {
    if (_wordBuilder.isNotEmpty) {
      sink.add(_wordBuilder.toString());
      _wordBuilder.clear();
    }
  }
}

// copy from https://juejin.cn/post/6844904154171703309
