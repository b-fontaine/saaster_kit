import 'package:flutter/material.dart';

import '../utils/responsive_utils.dart';
import 'colors.dart';

/// Design System Icons
class DSIcons {
  // Icon Sizes
  static const double sizeXXS = 12.0;
  static const double sizeXS = 16.0;
  static const double sizeSM = 20.0;
  static const double sizeMD = 24.0;
  static const double sizeLG = 32.0;
  static const double sizeXL = 40.0;
  static const double sizeXXL = 48.0;

  // App Theme Icon Colors
  static const Color appIconPrimary = DSColors.primaryApp;
  static const Color appIconSecondary = DSColors.secondaryApp;
  static const Color appIconDefault = DSColors.textPrimary;
  static const Color appIconDisabled = DSColors.textDisabled;
  static const Color appIconOnPrimary = DSColors.textOnPrimary;
  static const Color appIconOnSecondary = DSColors.textOnSecondary;
  static const Color appIconError = DSColors.errorApp;
  static const Color appIconSuccess = DSColors.successApp;
  static const Color appIconWarning = DSColors.warningApp;
  static const Color appIconInfo = DSColors.infoApp;

  // Landing Theme Icon Colors
  static const Color landingIconPrimary = DSColors.primaryLanding;
  static const Color landingIconSecondary = DSColors.secondaryLanding;
  static const Color landingIconDefault = DSColors.textPrimary;
  static const Color landingIconDisabled = DSColors.textDisabled;
  static const Color landingIconOnPrimary = DSColors.textOnPrimary;
  static const Color landingIconOnSecondary = DSColors.textOnSecondary;
  static const Color landingIconError = DSColors.errorLanding;
  static const Color landingIconSuccess = DSColors.successLanding;
  static const Color landingIconWarning = DSColors.warningLanding;
  static const Color landingIconInfo = DSColors.infoLanding;

  // Common App Icons
  static const IconData home = Icons.home;
  static const IconData settings = Icons.settings;
  static const IconData profile = Icons.person;
  static const IconData notifications = Icons.notifications;
  static const IconData search = Icons.search;
  static const IconData menu = Icons.menu;
  static const IconData close = Icons.close;
  static const IconData add = Icons.add;
  static const IconData edit = Icons.edit;
  static const IconData delete = Icons.delete;
  static const IconData favorite = Icons.favorite;
  static const IconData favoriteBorder = Icons.favorite_border;
  static const IconData share = Icons.share;
  static const IconData download = Icons.download;
  static const IconData upload = Icons.upload;
  static const IconData check = Icons.check;
  static const IconData error = Icons.error;
  static const IconData warning = Icons.warning;
  static const IconData info = Icons.info;
  static const IconData help = Icons.help;
  static const IconData arrowBack = Icons.arrow_back;
  static const IconData arrowForward = Icons.arrow_forward;
  static const IconData arrowUp = Icons.arrow_upward;
  static const IconData arrowDown = Icons.arrow_downward;
  static const IconData more = Icons.more_vert;
  static const IconData moreHoriz = Icons.more_horiz;
  static const IconData calendar = Icons.calendar_today;
  static const IconData time = Icons.access_time;
  static const IconData location = Icons.location_on;
  static const IconData phone = Icons.phone;
  static const IconData email = Icons.email;
  static const IconData link = Icons.link;
  static const IconData copy = Icons.content_copy;
  static const IconData filter = Icons.filter_list;
  static const IconData sort = Icons.sort;
  static const IconData refresh = Icons.refresh;
  static const IconData logout = Icons.logout;
  static const IconData login = Icons.login;
  static const IconData visibility = Icons.visibility;
  static const IconData visibilityOff = Icons.visibility_off;
  static const IconData lock = Icons.lock;
  static const IconData unlock = Icons.lock_open;
  static const IconData star = Icons.star;
  static const IconData starBorder = Icons.star_border;
  static const IconData bookmark = Icons.bookmark;
  static const IconData bookmarkBorder = Icons.bookmark_border;
  static const IconData dashboard = Icons.dashboard;
  static const IconData list = Icons.list;
  static const IconData grid = Icons.grid_view;
  static const IconData camera = Icons.camera_alt;
  static const IconData image = Icons.image;
  static const IconData video = Icons.videocam;
  static const IconData mic = Icons.mic;
  static const IconData micOff = Icons.mic_off;
  static const IconData volume = Icons.volume_up;
  static const IconData volumeOff = Icons.volume_off;
  static const IconData play = Icons.play_arrow;
  static const IconData pause = Icons.pause;
  static const IconData stop = Icons.stop;
  static const IconData skip = Icons.skip_next;
  static const IconData previous = Icons.skip_previous;
  static const IconData smartphone = Icons.smartphone;
  static const IconData tablet = Icons.tablet;
  static const IconData desktop = Icons.desktop_mac;
  static const IconData formatQuote = Icons.format_quote;

  // Helper methods

  /// Returns a responsive icon size that scales with the screen size
  static double responsiveIconSize(
    BuildContext context, {
    required double defaultSize,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return ResponsiveUtils.responsiveValue<double>(
      context: context,
      defaultValue: defaultSize,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    );
  }

  /// Creates an icon with the specified color and size
  static Icon getIcon(
    IconData icon, {
    Color? color,
    double? size,
    String? semanticLabel,
  }) {
    return Icon(icon, color: color, size: size, semanticLabel: semanticLabel);
  }

  /// Creates an app-themed icon
  static Icon getAppIcon(
    IconData icon, {
    Color? color,
    double size = sizeMD,
    String? semanticLabel,
  }) {
    return Icon(
      icon,
      color: color ?? appIconDefault,
      size: size,
      semanticLabel: semanticLabel,
    );
  }

  /// Creates a landing-themed icon
  static Icon getLandingIcon(
    IconData icon, {
    Color? color,
    double size = sizeMD,
    String? semanticLabel,
  }) {
    return Icon(
      icon,
      color: color ?? landingIconDefault,
      size: size,
      semanticLabel: semanticLabel,
    );
  }
}
