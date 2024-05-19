import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';

import '../global/custom_cache_manager.dart';
import '../utils/utils.dart';

class ImageView extends StatelessWidget {
  const ImageView(this._uri,
      {Key? key,
      required this.width,
      this.height,
      this.cornerRadius,
      this.borderWidth,
      this.borderColor,
      this.boxFit,
      this.onTap,
      this.svgColor,
      this.color,
      this.cdn,
      this.dj})
      : super(key: key);
  final String _uri;
  final double width;
  final double? height;
  final double? cornerRadius;
  final double? borderWidth;
  final Color? borderColor;
  final VoidCallback? onTap;
  final BoxFit? boxFit;
  final Color? svgColor;
  final bool? cdn;
  final bool? dj;

  // cdn = true 代表为 CDN 图片域名
  // dj = true 代表为 电竞图片域名
  /// If non-null, this color is blended with each image pixel using [colorBlendMode].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    try {
      if (_uri.isEmpty) {
        return SizedBox(
          width: width,
          height: width,
        );
      }
      return GestureDetector(
        onTap: onTap,
        child: _getImage(),
      );
    } catch (e) {
      return SizedBox(
        width: width,
      );
    }
  }

  Widget _getImage() {
    String uri = _uri;
    if (uri.startsWith("assets")) {
      //   uri = uri.replaceFirst('assets', 'assets-2024-03-27-19-00');
      uri = uri.replaceFirst('assets', 'assets-2024-04-05-12-00');
      uri = 'https://assets-image.oceasfe.com/public/upload/app/ty/$uri';

      // print("图片-------->  ${uri}");
    }
    if (uri.endsWith('.svg')) {
      if (uri.startsWith('http')) {
        return FutureBuilder<File>(
          future: CustomCacheManager().getSingleFile(uri),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return SvgPicture.file(
                snapshot.data!,
                width: width,
                height: height,
                color: svgColor,
                fit: boxFit ?? BoxFit.contain,
              );
            } else {
              return Container(
                width: width,
                height: width,
              );
              // DefaultCacheManager().downloadFile(uri,force: true);
              // return SvgPicture.network(
              //   uri,
              //   width: width,
              //   height: height,
              //   color: svgColor,
              //   fit: boxFit ?? BoxFit.contain,
              // );
            }
          },
        );
      } else {
        return SvgPicture.asset(
          uri,
          width: width,
          height: height,
          color: svgColor,
          fit: boxFit ?? BoxFit.fitWidth,
        );
      }
    } else if (uri.startsWith("http") || cdn == true || dj == true) {
      String u = uri;
      if (cdn == true) {
        String cdnImg = StringKV.imgUrl.get() ?? "";
        u = composeUrl(cdnImg, uri);
      } else if (dj == true) {
        String cdnImg = StringKV.eSportsImgDomain.get() ?? "";
        u = composeUrl(cdnImg, uri);
      }
      // 网络图片
      return ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius ?? 0),
        child: SizedBox(
          width: width,
          height: height ?? width,
          child: CachedNetworkImage(
            key: ValueKey(u),
            imageUrl: u,
            fit: boxFit ?? BoxFit.contain,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            color: color,
          ),
          // child: FutureBuilder<File>(
          //   future: CustomCacheManager().getSingleFile(u),
          //   builder: (_, snapshot) {
          //     if (snapshot.hasData) {
          //       return Image.file(
          //         snapshot.data!,
          //         fit: boxFit ?? BoxFit.contain,
          //         // placeholder: (context, url) => const CircularProgressIndicator(),
          //         errorBuilder: (context, url, error) =>
          //             const Icon(Icons.error),
          //         color: color,
          //       );
          //     } else {
          //       return CachedNetworkImage(
          //         imageUrl: u,
          //         fit: boxFit ?? BoxFit.contain,
          //         // placeholder: (context, url) => const CircularProgressIndicator(),
          //         errorWidget: (context, url, error) => const Icon(Icons.error),
          //         color: color,
          //       );
          //     }
          //   },
          // )

          // child: CachedNetworkImage(
          //   imageUrl: u,
          //   fit: boxFit ?? BoxFit.contain,
          //   cacheManager: CustomCacheManager(),
          //   // placeholder: (context, url) => const CircularProgressIndicator(),
          //   errorWidget: (context, url, error) => const Icon(Icons.error),
          //   color: color,
          // ),
        ),
      );
    } else if (uri.startsWith("assets")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius ?? 0),
        child: Image.asset(
          uri,
          width: width,
          height: height,
          fit: boxFit ?? BoxFit.contain,
          color: color,
        ),
      );
    } else {
      return Container();
    }
  }
}
