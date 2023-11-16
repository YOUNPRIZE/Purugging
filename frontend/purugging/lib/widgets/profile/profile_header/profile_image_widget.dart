import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget(
      {super.key, required this.photoUrl, required this.handleEditImage});

  final String photoUrl;
  final Function() handleEditImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 60,
          height: 60,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(2, 2), blurRadius: 3)
          ]),
          child: Image.network(
            photoUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 30,
          right: 25,
          child: IconButton(
            onPressed: handleEditImage,
            icon: const Icon(Icons.edit_square),
            iconSize: 20,
          ),
        )
      ],
    );
  }
}
