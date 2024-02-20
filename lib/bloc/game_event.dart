part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GameInit extends GameEvent{
  int xy;
  int bomb;
  GameInit({this.xy,this.bomb});
}

class TapCube extends GameEvent{
  CubeModel model;
  List<List<CubeModel>> allModel;
  TapCube({this.model,this.allModel});
}

class LongPress extends GameEvent{
  CubeModel model;
  LongPress({this.model});
}
