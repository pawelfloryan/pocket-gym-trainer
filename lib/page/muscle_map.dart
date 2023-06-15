import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MuscleMapPage extends StatelessWidget {
  const MuscleMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Muscle Map"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              //context.go('/sections');
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
    );
  }
}
