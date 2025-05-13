import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class IconGalleryShowcase extends StatelessWidget {
  const IconGalleryShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a list of all icon data fields from DSIcons
    final iconList = [
      _IconItem('home', DSIcons.home),
      _IconItem('settings', DSIcons.settings),
      _IconItem('profile', DSIcons.profile),
      _IconItem('notifications', DSIcons.notifications),
      _IconItem('search', DSIcons.search),
      _IconItem('menu', DSIcons.menu),
      _IconItem('close', DSIcons.close),
      _IconItem('add', DSIcons.add),
      _IconItem('edit', DSIcons.edit),
      _IconItem('delete', DSIcons.delete),
      _IconItem('favorite', DSIcons.favorite),
      _IconItem('favoriteBorder', DSIcons.favoriteBorder),
      _IconItem('share', DSIcons.share),
      _IconItem('download', DSIcons.download),
      _IconItem('upload', DSIcons.upload),
      _IconItem('check', DSIcons.check),
      _IconItem('error', DSIcons.error),
      _IconItem('warning', DSIcons.warning),
      _IconItem('info', DSIcons.info),
      _IconItem('help', DSIcons.help),
      _IconItem('arrowBack', DSIcons.arrowBack),
      _IconItem('arrowForward', DSIcons.arrowForward),
      _IconItem('arrowUp', DSIcons.arrowUp),
      _IconItem('arrowDown', DSIcons.arrowDown),
      _IconItem('more', DSIcons.more),
      _IconItem('moreHoriz', DSIcons.moreHoriz),
      _IconItem('calendar', DSIcons.calendar),
      _IconItem('time', DSIcons.time),
      _IconItem('location', DSIcons.location),
      _IconItem('phone', DSIcons.phone),
      _IconItem('email', DSIcons.email),
      _IconItem('link', DSIcons.link),
      _IconItem('copy', DSIcons.copy),
      _IconItem('filter', DSIcons.filter),
      _IconItem('sort', DSIcons.sort),
      _IconItem('refresh', DSIcons.refresh),
      _IconItem('logout', DSIcons.logout),
      _IconItem('login', DSIcons.login),
      _IconItem('visibility', DSIcons.visibility),
      _IconItem('visibilityOff', DSIcons.visibilityOff),
      _IconItem('lock', DSIcons.lock),
      _IconItem('unlock', DSIcons.unlock),
      _IconItem('star', DSIcons.star),
      _IconItem('starBorder', DSIcons.starBorder),
      _IconItem('bookmark', DSIcons.bookmark),
      _IconItem('bookmarkBorder', DSIcons.bookmarkBorder),
      _IconItem('dashboard', DSIcons.dashboard),
      _IconItem('list', DSIcons.list),
      _IconItem('grid', DSIcons.grid),
      _IconItem('camera', DSIcons.camera),
      _IconItem('image', DSIcons.image),
      _IconItem('video', DSIcons.video),
      _IconItem('mic', DSIcons.mic),
      _IconItem('micOff', DSIcons.micOff),
      _IconItem('volume', DSIcons.volume),
      _IconItem('volumeOff', DSIcons.volumeOff),
      _IconItem('play', DSIcons.play),
      _IconItem('pause', DSIcons.pause),
      _IconItem('stop', DSIcons.stop),
      _IconItem('skip', DSIcons.skip),
      _IconItem('previous', DSIcons.previous),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Icon Gallery',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: iconList.length,
            itemBuilder: (context, index) {
              final icon = iconList[index];
              return _buildIconItem(icon.name, icon.iconData);
            },
          ),
          const SizedBox(height: 32),
          Text(
            'App Theme Icon Colors',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              _buildColoredIcon('Primary', DSIcons.getAppIcon(DSIcons.star, color: DSColors.appIconPrimary)),
              _buildColoredIcon('Secondary', DSIcons.getAppIcon(DSIcons.star, color: DSColors.appIconSecondary)),
              _buildColoredIcon('Default', DSIcons.getAppIcon(DSIcons.star, color: DSColors.appIconDefault)),
              _buildColoredIcon('Disabled', DSIcons.getAppIcon(DSIcons.star, color: DSColors.appIconDisabled)),
              _buildColoredIcon('On Primary', DSIcons.getAppIcon(DSIcons.star, color: DSColors.appIconOnPrimary)),
              _buildColoredIcon('Error', DSIcons.getAppIcon(DSIcons.star, color: DSColors.appIconError)),
              _buildColoredIcon('Success', DSIcons.getAppIcon(DSIcons.star, color: DSColors.appIconSuccess)),
              _buildColoredIcon('Warning', DSIcons.getAppIcon(DSIcons.star, color: DSColors.appIconWarning)),
              _buildColoredIcon('Info', DSIcons.getAppIcon(DSIcons.star, color: DSColors.appIconInfo)),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Landing Theme Icon Colors',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              _buildColoredIcon('Primary', DSIcons.getLandingIcon(DSIcons.star, color: DSColors.landingIconPrimary)),
              _buildColoredIcon('Secondary', DSIcons.getLandingIcon(DSIcons.star, color: DSColors.landingIconSecondary)),
              _buildColoredIcon('Default', DSIcons.getLandingIcon(DSIcons.star, color: DSColors.landingIconDefault)),
              _buildColoredIcon('Disabled', DSIcons.getLandingIcon(DSIcons.star, color: DSColors.landingIconDisabled)),
              _buildColoredIcon('On Primary', DSIcons.getLandingIcon(DSIcons.star, color: DSColors.landingIconOnPrimary)),
              _buildColoredIcon('Error', DSIcons.getLandingIcon(DSIcons.star, color: DSColors.landingIconError)),
              _buildColoredIcon('Success', DSIcons.getLandingIcon(DSIcons.star, color: DSColors.landingIconSuccess)),
              _buildColoredIcon('Warning', DSIcons.getLandingIcon(DSIcons.star, color: DSColors.landingIconWarning)),
              _buildColoredIcon('Info', DSIcons.getLandingIcon(DSIcons.star, color: DSColors.landingIconInfo)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconItem(String name, IconData iconData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 32,
          color: DSColors.primaryApp,
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildColoredIcon(String name, Icon icon) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              icon.icon,
              color: icon.color,
              size: 32,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class IconSizesShowcase extends StatelessWidget {
  const IconSizesShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Icon Sizes',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildIconSizeItem('XXS (12px)', DSIcons.sizeXXS),
          _buildIconSizeItem('XS (16px)', DSIcons.sizeXS),
          _buildIconSizeItem('SM (20px)', DSIcons.sizeSM),
          _buildIconSizeItem('MD (24px)', DSIcons.sizeMD),
          _buildIconSizeItem('LG (32px)', DSIcons.sizeLG),
          _buildIconSizeItem('XL (40px)', DSIcons.sizeXL),
          _buildIconSizeItem('XXL (48px)', DSIcons.sizeXXL),
          const SizedBox(height: 32),
          Text(
            'Helper Methods',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          _buildHelperMethodExample('getIcon', DSIcons.getIcon(
            DSIcons.star,
            color: DSColors.primaryApp,
            size: 32,
          )),
          _buildHelperMethodExample('getAppIcon', DSIcons.getAppIcon(
            DSIcons.star,
            color: DSColors.appIconPrimary,
            size: 32,
          )),
          _buildHelperMethodExample('getLandingIcon', DSIcons.getLandingIcon(
            DSIcons.star,
            color: DSColors.landingIconPrimary,
            size: 32,
          )),
          const SizedBox(height: 32),
          Text(
            'Responsive Icons',
            style: DSTypography.appTextTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Breakpoint: ${DSBreakpoints.getBreakpoint(context)}',
                  style: DSTypography.appTextTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Center(
                  child: Icon(
                    DSIcons.star,
                    size: DSIcons.responsiveIconSize(
                      context,
                      defaultSize: 24,
                      sm: 32,
                      md: 40,
                      lg: 48,
                    ),
                    color: DSColors.primaryApp,
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Responsive Icon (changes size based on screen width)',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconSizeItem(String name, double size) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Icon(
            DSIcons.star,
            size: size,
            color: DSColors.primaryApp,
          ),
          const SizedBox(width: 16),
          Text(
            '${size.toInt()}px',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelperMethodExample(String methodName, Icon icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              methodName,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 24),
          icon,
          const SizedBox(width: 16),
          Text(
            'Size: ${icon.size?.toInt()}px, Color: ${icon.color}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconItem {
  final String name;
  final IconData iconData;

  _IconItem(this.name, this.iconData);
}
