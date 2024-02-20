import 'dart:async';
import 'dart:math';

import 'package:Game/bloc/game_bloc.dart';
import 'package:Game/bloc/game_bloc.dart';
import 'package:Game/model/CubeModel.dart';
import 'package:Game/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'bloc/game_bloc.dart';
import 'bloc/game_bloc.dart';

void main() {
  runApp(GamePage());
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MintQuest',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BlocProvider(
          create: (BuildContext context) => GameBloc(),
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GameBloc _gameBloc;
  //踩炸彈相關
  bool gaming = true; //是否遊戲中
  List<List<CubeModel>> cubeModel = [];
  int bomb = 8; //幾乘幾的遊戲方格
  int xy = 9; //炸彈數

  //動畫相關
  // Map width = {
  //   1:100,
  //   2:200,
  //   3:300,
  //   4:40,
  //   5:80,
  // };
  // Map height = {
  //   1:80,
  //   2:100,
  //   3:150,
  //   4:300,
  //   5:20,
  // };
  // List color = [
  //   Colors.pink,
  //   Colors.blueAccent,
  //   Colors.amber,
  //   Colors.deepPurple,
  //   Colors.green,
  // ];
  //
  // List align = [
  //   Alignment.topLeft,
  //   Alignment.center,
  //   Alignment.topRight,
  //   Alignment.bottomLeft,
  //   Alignment.bottomRight,
  // ];
  //
  // int heightNum;
  // int widthNum;
  // int colorNum;
  // int posNum;

  void initState() {
    _gameBloc = BlocProvider.of<GameBloc>(context);
    _gameBloc.add(GameInit(xy:xy,bomb:bomb));
    // heightNum = 1;
    // widthNum = 1;
    // colorNum = 1;
    // posNum = 1;

    // Future.delayed(Duration(milliseconds: 50),(){
    //   Timer.periodic(Duration(milliseconds: 3000), (timer) {
    //     setState(() {
    //       var newNum;
    //       int random(int min, int max) {
    //         var rn = new Random();
    //         if(num == min + rn.nextInt(max - min)){
    //           random(1,5);
    //         }else{
    //           newNum = min + rn.nextInt(max - min);
    //         }
    //         return newNum;
    //       }
    //       heightNum = random(1,5);
    //       widthNum = random(1,5);
    //       colorNum = random(1,5);
    //       posNum = random(1,5);
    //     });
    //   });
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cWidth = size.width;
    final cHeight = size.height;
    var alertWeight = cWidth * 0.8;
    var alertHeight = cHeight * 0.5;

    return BlocListener<GameBloc,GameState>(
      listener: (BuildContext context, GameState state){
        if(state is Init){
          cubeModel = state.data;
          gaming = state.gaming;
        }else if(state is ReBuildCube){
          if(!state.gaming){
            showAppDialog(context,AppDialog(
              title: '提示訊息',
              width: alertWeight,
              height: alertHeight,
              closeIcon: false,
              actionButtons: <Widget>[
                PrimaryButton(
                  label: '關閉',
                  color: Color(0xFF26ACA9),
                  onPressed: () {
                    gaming = false;
                    Navigator.of(context).pop();
                  },
                )
              ],
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10),
                child: Text('Bomb！踩到炸彈了！',
                    style: TextStyle(
                      color: Color(0xff373a3c),
                      fontSize: 30 ,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    )),
              ),
            ));
          }else if(state.win){
            showAppDialog(context,AppDialog(
              title: '提示訊息',
              width: alertWeight,
              height: alertHeight,
              closeIcon: false,
              actionButtons: <Widget>[
                PrimaryButton(
                  label: '關閉',
                  color: Color(0xFF26ACA9),
                  onPressed: () {
                    gaming = false;
                    Navigator.of(context).pop();
                  },
                )
              ],
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10),
                child: Text('Congratulations！You Ｗin！',
                    style: TextStyle(
                      color: Color(0xff373a3c),
                      fontSize: 30 ,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    )),
              ),
            ));
          }
        }
      },
      child: BlocBuilder<GameBloc,GameState>(
        builder: (BuildContext context, GameState state){
           return
           //動畫
           //   Center(
           //   child: Container(
           //     width: 600,
           //     height: 600,
           //     decoration: BoxDecoration(
           //         border: Border.all(color: Colors.black,width: 10)
           //     ),
           //     child: AnimatedContainer(
           //       alignment: align[posNum-1],
           //       curve: Curves.easeIn,	// 设置插值属性
           //       duration: Duration(milliseconds: 2000), // 设置
           //       child: AnimatedContainer(
           //         width: width[widthNum].toDouble(),
           //         height: height[heightNum].toDouble(),
           //         color: color[colorNum-1],
           //         curve: Curves.easeIn,	// 设置插值属性
           //         duration: Duration(milliseconds: 2000), // 设置时间
           //       ),
           //     ),
           //   ),
           // );


           //瀑布流
           //   StaggeredGridView.countBuilder(
           //   crossAxisCount: 4,
           //   itemCount: 12,
           //   itemBuilder: (BuildContext context, int index) => new Container(
           //       color: Colors.black,
           //       child: Container(
           //         child: Image.asset(
           //           'assets/img/$index.jpg',fit: BoxFit.cover,),
           //       ),),
           //   staggeredTileBuilder: (int index) =>
           //   new StaggeredTile.count(2, index.isEven ? 2 : 1),
           //   mainAxisSpacing: 20.0,
           //   crossAxisSpacing: 20.0,
           // );

           //踩炸彈遊戲
           Container(
             color: Colors.black,
             child:Column(
               children: [
                 Expanded(
                   child: ListView(
                     children: [
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           GestureDetector(
                             onTap: (){
                               _gameBloc.add(GameInit(xy:xy,bomb:bomb));
                             },
                             child:Container(
                               width: 150,
                               margin: EdgeInsets.all(30),
                               padding: EdgeInsets.all(5),
                               alignment: Alignment.center,
                               decoration:BoxDecoration(
                                 color: Colors.grey[350],
                                 border: Border(
                                   top: BorderSide(width: 8,color: Colors.white),
                                   left:BorderSide(width: 8,color:Colors.white),
                                   right:BorderSide(width: 8,color:Colors.black38),
                                   bottom:BorderSide(width: 8,color:Colors.black38),
                                 ),
                               ),
                               child:Text('Restart'.toString(),style: TextStyle(color: Colors.black,fontSize: 24)),
                             ),
                           ),
                           Container(
                             width: 500,
                             height:500,
                             margin: EdgeInsets.only(bottom: 50),
                             decoration: BoxDecoration(
                               border: Border(
                                 top: BorderSide(width: 6,color: Colors.grey),
                                 left:BorderSide(width: 6,color:Colors.grey),
                                 right:BorderSide(width: 6,color:Colors.white24),
                                 bottom:BorderSide(width: 6,color:Colors.white24),
                               ),
                             ),
                             child: Container(
                               decoration: BoxDecoration(
                                 border: Border(
                                   top: BorderSide(width: 16,color: Colors.white),
                                   left:BorderSide(width: 16,color:Colors.white),
                                   right:BorderSide(width: 16,color:Colors.white54),
                                   bottom:BorderSide(width: 16,color:Colors.white54),
                                 ),
                               ),
                               child: Container(
                                 padding: EdgeInsets.all(10),
                                 width: 500,
                                 height: 500,
                                 color:Colors.white70,
                                 child:
                                 Row(
                                   children: [
                                     for(var data in cubeModel)
                                       Expanded(
                                         child: Column(
                                           children: [
                                             for(var model in data)
                                               Cube(
                                                 data:model,
                                                 showFlag: model.hasFlag,
                                                 tap:model.isTap,
                                                 hasBomb: model.hasBomb,
                                                 bombAround: model.bombAround,
                                                 onTap: (){
                                                   if(!model.hasFlag && gaming){
                                                     _gameBloc.add(TapCube(model:model,allModel:cubeModel));
                                                   }
                                                 },
                                                 onLongPress: (){
                                                   _gameBloc.add(LongPress(model:model));
                                                 },
                                               ),
                                           ],
                                         ),
                                       ),
                                   ],
                                 ),
                               ),
                             ),
                           ),

                         ],
                       ),
                     ],
                   ),
                 )
               ],
             ),
           );
        }
      )
    );
  }
}





void showAppDialog(BuildContext context, Widget dialog,
    {bool barrierDismissible = false}) {
  showDialog(
      barrierDismissible: barrierDismissible, //点击遮罩不关闭对话框
      context: context,
      builder: (context) {
        return dialog;
      });
}