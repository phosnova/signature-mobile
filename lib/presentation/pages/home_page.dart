// lib/presentation/pages/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [IconButton(icon: Icon(Icons.person_2_rounded), onPressed: () => context.push('/profile'))],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Fitur"),
                SizedBox(height: 10),
                SizedBox(
                  height: 28,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      ElevatedButton(onPressed: () => goRouter.push('/signature'), child: Text('buat tanda tangan')),
                      SizedBox(width: 8),
                      ElevatedButton(onPressed: null, child: Text('Impor dan Edit PDF')),
                      SizedBox(width: 8),
                      ElevatedButton(onPressed: null, child: Text('Data Tanda Tangan')),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
