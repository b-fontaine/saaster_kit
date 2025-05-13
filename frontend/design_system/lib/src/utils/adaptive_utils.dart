import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

/// Utility class for adaptive design (platform-specific adjustments)
class AdaptiveUtils {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  
  /// Returns true if the app is running on a mobile device
  static bool get isMobileDevice {
    return !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  }
  
  /// Returns true if the app is running on a desktop device
  static bool get isDesktopDevice {
    return !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);
  }
  
  /// Returns true if the app is running on the web
  static bool get isWebPlatform {
    return kIsWeb;
  }
  
  /// Returns true if the app is running on iOS
  static bool get isIOS {
    return !kIsWeb && Platform.isIOS;
  }
  
  /// Returns true if the app is running on Android
  static bool get isAndroid {
    return !kIsWeb && Platform.isAndroid;
  }
  
  /// Returns true if the app is running on macOS
  static bool get isMacOS {
    return !kIsWeb && Platform.isMacOS;
  }
  
  /// Returns true if the app is running on Windows
  static bool get isWindows {
    return !kIsWeb && Platform.isWindows;
  }
  
  /// Returns true if the app is running on Linux
  static bool get isLinux {
    return !kIsWeb && Platform.isLinux;
  }
  
  /// Returns a value based on the current platform
  static T adaptiveValue<T>({
    required T defaultValue,
    T? android,
    T? iOS,
    T? web,
    T? windows,
    T? macOS,
    T? linux,
  }) {
    if (kIsWeb && web != null) return web;
    
    if (!kIsWeb) {
      if (Platform.isAndroid && android != null) return android;
      if (Platform.isIOS && iOS != null) return iOS;
      if (Platform.isWindows && windows != null) return windows;
      if (Platform.isMacOS && macOS != null) return macOS;
      if (Platform.isLinux && linux != null) return linux;
    }
    
    return defaultValue;
  }
  
  /// Returns a widget based on the current platform
  static Widget adaptiveWidget({
    required Widget defaultWidget,
    Widget? android,
    Widget? iOS,
    Widget? web,
    Widget? windows,
    Widget? macOS,
    Widget? linux,
  }) {
    return adaptiveValue<Widget>(
      defaultValue: defaultWidget,
      android: android,
      iOS: iOS,
      web: web,
      windows: windows,
      macOS: macOS,
      linux: linux,
    );
  }
  
  /// Returns true if the device has a notch (iOS only)
  static Future<bool> hasNotch() async {
    if (!isIOS) return false;
    
    final iosInfo = await _deviceInfoPlugin.iosInfo;
    // iPhone X and newer have notches (except SE models)
    final List<String> notchedDevices = [
      'iPhone10,3', 'iPhone10,6', // iPhone X
      'iPhone11,2', 'iPhone11,4', 'iPhone11,6', // iPhone XS, XS Max
      'iPhone11,8', // iPhone XR
      'iPhone12,1', 'iPhone12,3', 'iPhone12,5', // iPhone 11, 11 Pro, 11 Pro Max
      'iPhone13,1', 'iPhone13,2', 'iPhone13,3', 'iPhone13,4', // iPhone 12 mini, 12, 12 Pro, 12 Pro Max
      'iPhone14,2', 'iPhone14,3', 'iPhone14,4', 'iPhone14,5', // iPhone 13 Pro, 13 Pro Max, 13 mini, 13
      'iPhone14,7', 'iPhone14,8', 'iPhone15,2', 'iPhone15,3', // iPhone 14, 14 Plus, 14 Pro, 14 Pro Max
      'iPhone15,4', 'iPhone15,5', 'iPhone16,1', 'iPhone16,2', // iPhone 15, 15 Plus, 15 Pro, 15 Pro Max
    ];
    
    return notchedDevices.contains(iosInfo.utsname.machine);
  }
  
  /// Returns the safe area insets for the current device
  static EdgeInsets getSafeAreaInsets(BuildContext context) {
    return MediaQuery.of(context).padding;
  }
}
