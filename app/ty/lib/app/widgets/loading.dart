import 'package:flutter/material.dart';

import 'image_view.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const ImageView(
        'assets/images/detail/odds-info-loading.webp',
        width: 70,
      ),
    );
  }
}
