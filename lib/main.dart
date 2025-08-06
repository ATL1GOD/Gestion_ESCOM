import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:device_preview/device_preview.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // DevicePreview(
    //   enabled: true,
    //   tools: [...DevicePreview.defaultTools],
    //   builder: (context) =>
    const ProviderScope(child: MyApp()),
    // ),
  );
}
