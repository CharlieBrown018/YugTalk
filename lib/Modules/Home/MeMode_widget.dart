import 'package:flutter/material.dart';
import 'package:gtext/gtext.dart';
import '/Widgets/ChildLock_Widget.dart';
import '/Widgets/LangToggle_Widget.dart';
import '/Widgets/ExploreToggle_Widget.dart';
import '/Modules/CommBoard/CommBoard_Mod.dart';

class MeMode_Widget extends StatefulWidget {
  const MeMode_Widget({super.key});

  @override
  State<MeMode_Widget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MeMode_Widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GText('Me Mode'),
        centerTitle: true,
        leading: const ChildLock_Widget(),
        actions: const [
          ExploreToggle_Widget(),
          Padding(padding: EdgeInsets.only(left: 10)),
          LangToggle_Widget(),
          Padding(padding: EdgeInsets.only(left: 10)),
        ],
      ),
      body: const CommBoard_Mod(),
    );
  }
}


