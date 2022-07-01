import 'package:flutter/material.dart';

import 'map.dart';


class Maps_File extends StatefulWidget {
  @override
  State<Maps_File> createState() => _Maps_FileState();
}

class _Maps_FileState extends State<Maps_File> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MAPS FILE SCREENS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => map_true())),
        child: const Icon(Icons.add_location_alt),
      ),
    );
  }
}
