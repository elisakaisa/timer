import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'home page',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 60;
  final int _maxSeconds = 60;
  Timer? timer;
  bool isStartTimer = true;
  bool isRunning = false;

  void _resetTimer() {
    setState(() {
      timer?.cancel();
      _counter = 60;
      isStartTimer = true;
    });
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (_counter == 0) {
          _counter = 60; // loop to beginning again
          }
        _counter--;
      });
  });
  }
  void _pauseTimer(){
    setState(() { timer?.cancel(); });
  }

  Widget setButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
      ? TextButton(
      style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.black), ),
      onPressed: () { _pauseTimer(); },
      child: const Text('Pause', style: TextStyle(fontSize: 20, color: Colors.pink),))
      : TextButton(
      style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.black), ),
      onPressed: () {_startTimer();},
      child: const Text('Start', style: TextStyle(fontSize: 20, color: Colors.pink),));
  }


  Widget startTimer(){
    return Text(
      '$_counter',
      style: const TextStyle(
        fontSize: 80,
        color: Colors.black,),
    );
  }

  Widget buildTimer() => SizedBox(
    width: 200,
    height: 200,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CircularProgressIndicator(
          value: _counter/_maxSeconds,
          valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
          strokeWidth: 14,
          backgroundColor: Colors.pinkAccent,
        ),
        Center(child: startTimer()),
      ]
    )
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.pink, Colors.blue])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildTimer(),
                  const SizedBox(height: 50),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      setButtons(),
                      const SizedBox(width: 50),
                      TextButton(
                        style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.black), ),
                        onPressed: () { _resetTimer(); },
                        child: const Text('Reset', style: TextStyle(fontSize: 20, color: Colors.pink),))
                    ]
                  )
                ],
              ),
            )) //);
    );
  }
}
