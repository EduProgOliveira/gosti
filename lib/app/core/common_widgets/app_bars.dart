import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/app_images.dart';

PreferredSize buildAppBar({bool showBackChevron = true}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(118.0),
    child: AppBar(
      automaticallyImplyLeading: showBackChevron,
      flexibleSpace: Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset(
          AppImages.appBar,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
