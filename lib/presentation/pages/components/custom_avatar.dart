import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String? imageUrl;
  final String username;
  final double? size;
  final bool? isBorder;
  final double? borderThick;
  const CustomAvatar({
    this.imageUrl,
    required this.username,
    this.size = 100,
    this.isBorder = false,
    this.borderThick,
    super.key,
  });

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.length == 1) return words[0][0].toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(username);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade100,
        border: isBorder! ? Border.all(color: Theme.of(context).colorScheme.primary, width: borderThick ?? 1) : null,
        image:
            imageUrl != null && imageUrl!.isNotEmpty
                ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
                : null,
      ),
      alignment: Alignment.center,
      child:
          imageUrl == null || imageUrl!.isEmpty
              ? Text(
                initials,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
              : null,
    );
  }
}
