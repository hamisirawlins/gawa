import 'package:flutter/material.dart';
import 'package:gawa/core/utils/get_screen_size.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.4,
          ),
          LoadingAnimationWidget.staggeredDotsWave(
            size: SizeConfig.screenHeight * 0.05,
            color: Colors.blue[300]!,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.4,
          )
        ],
      ),
    );
  }
}
