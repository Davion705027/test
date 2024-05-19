import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';

class MatchVideoPlaceholder extends StatelessWidget {
  const MatchVideoPlaceholder({
    super.key,
    required this.type,
  });

  final int type;

  @override
  Widget build(BuildContext context) {
    String imgSrc = 'assets/images/vr/vr_basketball_video_bg.png';
    switch (type) {
      case 1:
        imgSrc = 'assets/images/vr/vr_football_video_bg.png';
      case 2:
        imgSrc = 'assets/images/vr/vr_basketball_video_bg.png';
      case 3:
        imgSrc = 'assets/images/vr/vr_horse_video_bg_new.png';
      case 4:
        imgSrc = 'assets/images/vr/vr_dog_video_bg.png';
      case 5:
        imgSrc = 'assets/images/vr/vr_motorcycle_video_bg.png';
      case 6:
        imgSrc = 'assets/images/vr/vr_dirtbike_video_bg.png';
    }
    return ImageView(
      imgSrc,
      width: double.infinity,
      boxFit: BoxFit.cover,
    );
  }
}
