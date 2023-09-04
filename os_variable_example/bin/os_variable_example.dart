// import 'dart:html';
import 'dart:async';
import 'dart:io';

import 'package:os_variable_example/os_variable_example.dart'
    as os_varialble_example;

void main(List<String> arguments) {
  // print('Hello world: ${os_varialble_example.calculate()}!');
  print('os: ${Platform.operatingSystem} is ${Platform.version}');

  if (Platform.isLinux) {
    print("Run linux code");
  } else if (Platform.isIOS) {
    print("Run ios code");
  } else if (Platform.isMacOS) {
    print("Run macos code");
  } else if (Platform.isAndroid) {
    print("Run android code");
  } else if (Platform.isFuchsia) {
    print("Run fuchsia code");
  } else {
    print("Run normal code");
  }

  ///   "android"
  ///   "fuchsia"
  ///   "ios"
  ///   "linux"
  ///   "macos"
  ///   "windows"
  switch (Platform.operatingSystem) {
    case "android":
      {
        print("run android code");
      }
      break;
    case "fuchsia":
      {
        print("run fuchsia code");
      }
      break;
    case "ios":
      {
        print("run ios code");
      }
      break;
    case "linux":
      {
        print("run linux code");
      }
      break;
    case "macos":
      {
        print("run macos code");
      }
      break;
    case "windows":
      {
        print("run windows code");
      }
      break;
    default:
      {
        print("unknown platform");
      }
      break;
  }

  print("path : ${Platform.script.path}");
  print("path : ${Platform.executable}");

  print("Env:");
  Platform.environment.keys.forEach((key) {
    print("${key} ${Platform.environment[key]}");
  });
}
