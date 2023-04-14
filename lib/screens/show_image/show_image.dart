import 'package:flutter/material.dart';

import '../widgets/cache_network_image_widget.dart';


class ShowImage extends StatelessWidget {
  ShowImage({super.key, required this.imageUrl, required this.name});
  String imageUrl;
  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: CacheNetworkImageWidget(
            imageUrl: imageUrl,
          ),
        ),
      ),
    );
  }
}
