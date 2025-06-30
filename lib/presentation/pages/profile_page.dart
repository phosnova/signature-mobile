import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'components/custom_avatar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
        child: SizedBox(
          width: double.infinity,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomAvatar(
                      size: 100,
                      username: 'Kaesa Lyrih',
                      imageUrl:
                          'https://static.vecteezy.com/system/resources/thumbnails/036/324/708/small/ai-generated-picture-of-a-tiger-walking-in-the-forest-photo.jpg',
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kaesa Lyrih',
                            overflow: TextOverflow.clip,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Admin • Charapon • Programmer',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Pengaturan',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: const Color.fromARGB(175, 0, 0, 0)),
                  ),
                ),
                ProfileListItem(title: 'Ubah Password', onTap: () {}),
                ProfileListItem(title: 'Bahasa / Language', subtitle: 'Indonesia', onTap: () {}),
                ProfileListItem(title: 'Kebijakan Privasi', onTap: () {}),
                ProfileListItem(title: 'Keluar', onTap: () => context.go('/login')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final void Function()? onTap;
  const ProfileListItem({required this.title, this.subtitle, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.titleSmall),
      subtitle:
          subtitle != null
              ? Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color.fromARGB(175, 0, 0, 0)),
              )
              : null,
      trailing: Icon(Icons.chevron_right_rounded),
      onTap: onTap,
      shape: Border(top: BorderSide(color: const Color.fromARGB(50, 0, 0, 0), width: 0.5)),
      dense: subtitle != null,
    );
  }
}
