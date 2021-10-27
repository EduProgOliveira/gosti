import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_images.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/core/common_widgets/web_viewer.dart';
import 'package:gosti_mobile/app_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.homeBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(AppPages.DASHBOARD),
                  child: HomeOption(
                    text: 'Freezer',
                    imageAsset: AppImages.freezerIcon,
                  ),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWebView(
                          title: 'Delivery Gosti',
                          selectedUrl: 'https://www.gosti.com.br/produtos/',
                        ),
                      ),
                    );
                  },
                  child: HomeOption(
                    text: 'Delivery Gosti',
                    imageAsset: AppImages.deliveryIcon,
                  ),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWebView(
                          title: 'Delivery Vivenda',
                          selectedUrl:
                              'https://www.emporiovivendadocamarao.com.br/',
                        ),
                      ),
                    );
                  },
                  child: HomeOption(
                    text: 'Delivery Vivenda',
                    imageAsset: AppImages.retireICon,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeOption extends StatelessWidget {
  const HomeOption({
    Key? key,
    required this.text,
    required this.imageAsset,
    this.onTap,
  }) : super(key: key);

  final String text;
  final String imageAsset;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageAsset),
          const SizedBox(width: 10),
          Text(
            text,
            style: AppTextStyles.homeButton,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
