import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'counter_event.dart';

/// Here we have _counterC var that will determine our counter in our Home Screen
/// Check that in the main.dart we don't have any counter variable to show in Home Screen
/// The var (_counterC) in bloc file only determines the counter in home Screen of our App.
///
/// So As I told you earlier we have our Sink here (changeInCounter) and
/// A stream (valOfCounter) to show the values we want to emit out.
///
/// And for each of them we have StreamController , I have used BehaviourSubject for Stream here
/// because BehaviourSubject is a special StreamController that captures the latest item
/// that has been added to the controller, and emits that as the first item to any new listener.
///

class CounterBloc{
  int _counterC=0;

  // Here in Sink as you can see the Sink is having a CounterEvent data-type or Event-type
  // In counter_event.dart you can see put the events you want to dump in the sink
  Sink<CounterEvent> get changeInCounter=>_changeController.sink;
  final _changeController = StreamController<CounterEvent>();

  // We want to send the updated counter variable to the HomeScreen that's why the Stream is having a int data-type
  Stream<int> get valOfCounter => _incCounterSubject.stream;
  final _incCounterSubject = BehaviorSubject<int>();

  // In this Constructor we wire all the things we listen to the Sink and send the value what we want.
  CounterBloc(){
    _changeController.stream.listen(_handle);
  }

  void _handle(CounterEvent event) {
    if(event is IncreaseInEvent)
      _counterC++;
    else
      _counterC--;

    _incCounterSubject.add(_counterC); // In last we put the value in the stream.
  }
}