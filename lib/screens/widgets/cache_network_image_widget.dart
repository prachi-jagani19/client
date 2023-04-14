import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

import '../../utils/color_utils.dart';


class CacheNetworkImageWidget extends StatelessWidget {
  const CacheNetworkImageWidget({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    // return CachedNetworkImage(
    //   key: key,
    //   imageUrl: imageUrl,
    //   // filterQuality: FilterQuality.high,
    //   errorWidget: (context, url, error) {
    //     return Container(
    //       color: ColorUtils.primaryColor.withOpacity(0.8),
    //       child: Icon(
    //         Icons.person,
    //         color: ColorUtils.white,
    //       ),
    //     );
    //   },
    //   placeholder: (context, url) {
    //     return Container(
    //       color: ColorUtils.primaryColor.withOpacity(0.5),
    //       // child: const Center(child: CircularProgressIndicator()),
    //     );
    //   },
    //   fit: BoxFit.cover,
    // );
    return OctoImage(
      image: NetworkImage(
          imageUrl),
      placeholderBuilder: OctoPlaceholder.blurHash(
        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
      ),
      errorBuilder: 
      (context, error, stackTrace) {
        return Container(
          color: ColorUtils.primaryColor.withOpacity(0.8),
          child: const Icon(
            Icons.person,
            size: 34,
            color: ColorUtils.white,
          ),
        );
      },
      // width: 100.0,
      fit: BoxFit.cover,
    );
  }
}
