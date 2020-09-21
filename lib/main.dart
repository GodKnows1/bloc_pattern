import 'package:flutter/material.dart';
import 'package:blocpattern/counter_bloc.dart';

import 'counter_event.dart';

void main() {
  runApp(MyApp());
}
//          *** Explanation ***
/// Basic Counter App (Increase and Decrease the Counter) with BLoc Architecture
/// BLoC basically consist of 3 components -> Sink and Streams and a Black Box in which magic happens
/// In Sink we take Events that should be taken care of.
///
/// Here In this example We have taken the basic layout what Flutter give us
/// and just add one more FloatingAction Button for decrementing the counter.
///
/// Here we have two events -> **Increase the counter** and **Decrease the counter**
/// For that I have made a separate Dart file that will have our events.
///
/// And a Bloc dart file (counter_bloc.dart) to make sinks and streams and to
/// wire it up we use our constructor.
///
/// Go To counter_bloc.dart
///
/// After coming from counter_bloc.dart as we know when we click the floating action button
/// we want to cha and nge the value that's the reason we have applied the Sink operation at that
/// line (line no 85 and 93)
///
/// and where we want to listen the stream we apply the StreamBuilder (line no 65)
///
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter BLoc Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CounterBloc _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _counterBloc.valOfCounter, // stream we want to listen
          initialData: 0, // what you want as initial data
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),Text(
                        '${snapshot.data}', // we take here the data tat comes from stream
                        style: Theme.of(context).textTheme.headline4,
                      ),
              ],
            );
          }
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: ()=> _counterBloc.changeInCounter.add(IncreaseInEvent()),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: ()=> _counterBloc.changeInCounter.add(DecreaseInEvent()),
            child: Icon(Icons.remove),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
