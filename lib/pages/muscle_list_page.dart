import 'package:PocketGymTrainer/components/exercise.dart';
import 'package:PocketGymTrainer/model/exercise.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../main.dart';
import '../services/exercise_service.dart';

class MuscleListPage extends StatefulWidget {
  const MuscleListPage({super.key});

  @override
  State<MuscleListPage> createState() => _MuscleListPageState();
}

class _MuscleListPageState extends State<MuscleListPage> {
  List<Exercise> exercises = <Exercise>[];

  String? jwtToken = RootPage.token;

  late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
  late String decodedUserId = decodedToken["id"];

  @override
  void initState() {
    super.initState();
    getAllExercises();
    print(exercises);
  }

  void getAllExercises() async {
    exercises = (await ExerciseService().getAllExercises(decodedUserId));
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Muscle List"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              //context.go('/sections');
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              ExerciseComponent(
                exercises: exercises,
                certainIndex: index,
              )
            ],
          );
        },
        itemCount: exercises.length,
      ),
    );
  }
}
