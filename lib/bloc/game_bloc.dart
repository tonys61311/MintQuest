import 'dart:async';

import 'package:Game/model/CubeModel.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:math';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {

  @override
  Stream<GameState> mapEventToState(GameEvent event,) async* {
    // TODO: implement mapEventToState
    if (event is GameInit) {
      yield* _mapGameInitToState(event.xy, event.bomb);
    } else if (event is TapCube) {
      yield* _mapTapCubeToState(event.model,event.allModel);
    } else if (event is LongPress) {
      yield* _mapLongPressToState(event.model);
    }
  }

  @override
  // TODO: implement initialState
  GameState get initialState => GameInitial();


  Stream<GameState> _mapGameInitToState(int xy, int bomb) async* {
    List rowList = setNumber(xy); //[1,2,3,4,5,6,7,8,9,10]
    List colList = setNumber(xy); //[1,2,3,4,5,6,7,8,9,10]
    List<List<CubeModel>> all = [];
    List bombList = setBomb(1, xy, bomb);
    //print(bombList);

    rowList.forEach((x) {
      List<CubeModel> cube = [];
      colList.forEach((y) {
        CubeModel data = CubeModel();
        data.isTap = false;
        data.hasFlag = false;
        data.xLine = x;
        data.yLine = y;
        String cubeXY = '$x-$y';
        data.hasBomb = bombList.contains(cubeXY) ? true : false;
        data.bombAround = getBombAround(bombList, x, y);
        cube.add(data);
        //print(data.toJson());
      });
      all.add(cube);
    });
    yield Init(data: all,gaming:true);
  }

  Stream<GameState> _mapTapCubeToState(CubeModel model,List<List<CubeModel>> allModel) async* {
    bool gaming = true;
    bool win = true;
    if(model.hasBomb){
      model.isTap = true;
      gaming = false;
    }else{
      CheckModel(model, allModel);
      //判斷是否除了有炸彈的方格，其餘方格皆打開(即獲勝)
      allModel.forEach((element) {
        element.forEach((cube) {
          if(!cube.hasBomb && !cube.isTap){
            win = false;
          }
        });
      });
    }
    yield ReBuildCube(gaming: gaming,win: win);
    //抽出為function 若cube本身的bombAround是0則要再做一次找九宮格跟打開格子的此function
  }

  bool CheckModel(CubeModel model, List<List<CubeModel>> allModel) {
    model.isTap = true;
    int x = model.xLine;
    int y = model.yLine;
    List coordinate = GetCoordinate(x,y);
    //print(coordinate);
    if (!model.hasFlag) {
      if(model.bombAround==0){
        allModel.forEach((element) {
          element.forEach((cube) {
            if(coordinate.contains('${cube.xLine}-${cube.yLine}')){
              if(cube.bombAround==0 && !cube.isTap){
                CheckModel(cube,allModel);
              }
              cube.isTap = true;
            }
          });
        });
      }
    }
  }


  Stream<GameState> _mapLongPressToState(CubeModel model) async* {
    model.hasFlag = !model.hasFlag;
    yield ReBuildCube(gaming: true);
  }


  List setNumber(int count) {
    return List.generate(count, (index) => (index + 1));
  }

  int random(int min, int max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  List setBomb(int min, int max, int number) {
    List bomb = [];
    while (bomb.length < number) {
      int x = random(min, max);
      int y = random(min, max);
      if (!bomb.contains("$x-$y")) {
        bomb.add("$x-$y");
      }
    }
    return bomb;
  }

  int getBombAround(List bombList, int x, int y) {
    int bombAround = 0;
    List coordinate = GetCoordinate(x,y);
    bombList.forEach((element) {
      if (coordinate.contains(element)) {
        bombAround += 1;
      }
    });
    return bombAround;
  }

  List GetCoordinate(int x, int y){
    List coordinate = [
      '$x-$y',
      '${x - 1}-$y',
      '${x + 1}-$y',
      '$x-${y - 1}',
      '$x-${y + 1}',
      '${x - 1}-${y - 1}',
      '${x - 1}-${y + 1}',
      '${x + 1}-${y - 1}',
      '${x + 1}-${y + 1}'
    ];
    return coordinate;
  }


}