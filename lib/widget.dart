import 'package:Game/model/CubeModel.dart';
import 'package:flutter/material.dart';


class Cube extends StatefulWidget {
  final Function onTap;
  final Function onLongPress;
  final CubeModel data;
  final bool tap;
  final bool showFlag;
  final bool hasBomb;
  final int bombAround;

  const Cube(
      {Key key,
        this.onTap,
        this.onLongPress,
        this.data,
        this.tap = false,
        this.showFlag,
        this.hasBomb,
        this.bombAround = 0,
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return CubeState();
  }
}

class CubeState extends State<Cube> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Expanded(
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child:Container(
          alignment: Alignment.center,
          decoration: widget.tap ? BoxDecoration(
            border: Border.all(width: 2,color:Colors.black26),
          ) : BoxDecoration(
            border: Border(
              top: BorderSide(width: 5,color: Colors.white),
              left:BorderSide(width: 5,color:Colors.white),
              right:BorderSide(width: 5,color:Colors.black38),
              bottom:BorderSide(width: 5,color:Colors.black38),
            ),
          ),
          child:widget.tap ? widget.hasBomb ? Icon(Icons.support,size: 28,color: Colors.black87,) : Text(widget.bombAround.toString(),style: TextStyle(color: Colors.black54,fontSize: 24)) : widget.showFlag ? Icon(Icons.flag,size: 26,color: Colors.red[700],) : Container(),
        ),
      ),);
  }
}




class AppDialog extends StatefulWidget {
  final String title; //彈窗標題
  final double reduceWidth; //彈窗寬，須減少多少，預設80
  final double width; //彈窗寬，必須設定
  final double height; //彈窗高，必須設定
  final List<Widget> actionButtons; //動作按鈕
  final Widget child; //彈窗內容
  final bool closeIcon; //是否顯示關閉按鈕
  final AlignmentGeometry contentAlignment; //內容Container對齊方式，預設centerLeft
  final bool scrollable;

  final double paddingTop; //padding 上
  final double paddingBottom; //padding 下
  final double paddingLeft; //padding 左
  final double paddingRight; //padding 右
  final Function onClose; //彈窗關閉鈕

  const AppDialog({
    Key key,
    this.title,
    this.width,
    this.height,
    this.actionButtons,
    this.child,
    this.closeIcon = true,
    this.contentAlignment = Alignment.centerLeft,
    this.scrollable = false,
    this.reduceWidth = 80,
    this.paddingTop = 10,
    this.paddingBottom = 20,
    this.paddingLeft = 20,
    this.paddingRight = 20,
    this.onClose,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return AppDialogState();
  }
}

class AppDialogState extends State<AppDialog> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    var titleHeight = 50.0;

    return AlertDialog(
      actionsOverflowButtonSpacing: 0,
      scrollable: widget.scrollable,
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      elevation: 0,
      content: Container(
        width: (this.widget.width - widget.reduceWidth),
        height: this.widget.height,
        decoration: BoxDecoration(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Color(0x7f000000),
                offset: Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 0)
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
                right: 4,
                child: Visibility(
                  visible: this.widget.closeIcon,
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      Icons.highlight_off,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: widget.onClose != null ? widget.onClose : () {
                      Navigator.of(context).pop();
                    },
                  ),
                )),
            Positioned(
              bottom: 40,
              child: this.widget.actionButtons != null
                  ? Container(
                width: this.widget.width - widget.reduceWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: this.widget.actionButtons,
                ),
              )
                  : SizedBox(),
            ),
            Container(
              alignment: this.widget.contentAlignment,
              padding: EdgeInsets.only(
                  top: titleHeight + widget.paddingTop,
                  left: widget.paddingLeft,
                  right: widget.paddingRight,
                  bottom: this.widget.actionButtons != null ? 90 : widget.paddingBottom),
              child: this.widget.child,
            ),
          ],
        ),
      ),
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


//按鈕-----------
class PrimaryButton extends StatefulWidget {
  final String label; //按鈕文字
  final VoidCallback onPressed; //按鈕動作
  final EdgeInsetsGeometry margin; //按鈕外間距
  final Color color; //按鈕顏色
  final EdgeInsetsGeometry padding; //按鈕內間距

  const PrimaryButton(
      {Key key,
        this.label,
        this.onPressed,
        this.margin,
        this.color,
        this.padding =
        const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8)})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return PrimaryButtonState();
  }
}

class PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      margin: this.widget.margin,
      child: ButtonTheme(
        minWidth: 160,
        child: RaisedButton(
          child: Text(this.widget.label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              )),
          onPressed: this.widget.onPressed,
          textColor: Color(0xffffffff),
          padding: widget.padding,
          color: this.widget.color,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }
}




//立體按鈕-----------
class Button3D extends StatefulWidget {
  final String label; //按鈕文字


  const Button3D(
      {Key key,
        this.label,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return Button3DState();
  }
}

class Button3DState extends State<Button3D> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(top: 8,bottom: 8,left: 20,right: 20),
          constraints:BoxConstraints(
            minWidth: 160,
          ),
          decoration:BoxDecoration(
            border: Border(
              top: BorderSide(width: 6,color: Colors.grey),
              left:BorderSide(width: 6,color:Colors.grey),
              right:BorderSide(width: 6,color:Colors.white24),
              bottom:BorderSide(width: 6,color:Colors.white24),
            )
          )
        ),
      )
    );
  }
}