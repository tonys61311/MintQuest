part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class Init extends GameState{
  List<List<CubeModel>> data;
  bool gaming;
  Init({this.data,this.gaming});
}

class ReBuildCube extends GameState{
  bool gaming;
  bool win;
  ReBuildCube({this.gaming = true,this.win = false});
}

class GameOver extends GameState{}
