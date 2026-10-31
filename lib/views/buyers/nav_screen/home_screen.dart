import 'package:bobde6_multi_store/views/buyers/nav_screen/widgets/banner_widget.dart';
import 'package:bobde6_multi_store/views/buyers/nav_screen/widgets/category_text.dart';
import 'package:bobde6_multi_store/views/buyers/nav_screen/widgets/home_product_widget.dart';
import 'package:bobde6_multi_store/views/buyers/nav_screen/widgets/search_input.dart';
import 'package:bobde6_multi_store/views/buyers/nav_screen/widgets/welcome_text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          WelcomeText(),
          SizedBox(height: 14),
          SearchInputWidget(),
          BannerWidget(),
          CategoryText(),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Popular Products',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          HomeProductWidget(),
        ],
      ),
    );
  }
}
