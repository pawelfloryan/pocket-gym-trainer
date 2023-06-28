import 'package:PocketGymTrainer/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

enum TimerStatus { running, paused, stopped }

class WorkoutTimer extends StatefulWidget {
  const WorkoutTimer({super.key});
  static late int elapsedTime = 0;
  static TimerStatus status = TimerStatus.stopped;
  static late var finishedTime;

  static final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    onChange: (value) => print('onChange $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStopped: () {
      print('onStopped');
    },
    onEnded: () {
      print('onEnded');
    },
  );
  static void startTimer(){
    _stopWatchTimer.onStartTimer();
    status = TimerStatus.running;
  }

  static void stopTimer(){
    _stopWatchTimer.onStopTimer();
    _stopWatchTimer.onResetTimer();
    finishedTime = _stopWatchTimer.rawTime.value;
    print(finishedTime);
  }

  static void pauseTimer(){
    if(status == TimerStatus.running){
      _stopWatchTimer.onStopTimer();
      elapsedTime = _stopWatchTimer.rawTime.value;
      status = TimerStatus.paused;
    }else if(status == TimerStatus.paused){
      _stopWatchTimer.onStartTimer();
      status = TimerStatus.running;
    }
  }

  @override
  State<WorkoutTimer> createState() => _WorkoutTimerState();
}



class _WorkoutTimerState extends State<WorkoutTimer> {
  @override
  void initState() {
    super.initState();
    WorkoutTimer._stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    WorkoutTimer._stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    WorkoutTimer._stopWatchTimer.records.listen((value) => print('records $value'));
    WorkoutTimer._stopWatchTimer.fetchStopped
        .listen((value) => print('stopped from stream'));
    WorkoutTimer._stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      //visible: DashboardPage.workoutStart,
      visible: true,
      child: Container(
        margin: EdgeInsets.only(right: 20, top: 17),
        child: StreamBuilder<int>(
          stream: WorkoutTimer._stopWatchTimer.rawTime,
          initialData: WorkoutTimer._stopWatchTimer.rawTime.value,
          builder: (context, snapshot) {
            final value = snapshot.data!;
            final displayTime = StopWatchTimer.getDisplayTime(value, hours: true);
            return Column(
              children: [
                Text(
                  displayTime,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "DigitalDisplay",
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
