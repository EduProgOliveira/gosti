import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';

class SearchFreezer extends StatelessWidget {
  const SearchFreezer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search_rounded),
          hintText: 'Localize um freezer',
          hintStyle: AppTextStyles.body20.copyWith(fontSize: 16),
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
