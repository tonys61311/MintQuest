class CubeModel {
  int xLine;
  int yLine;
  bool isTap;
  bool hasFlag;
  bool hasBomb;
  int bombAround;

  CubeModel(
      {this.xLine,
        this.yLine,
        this.isTap,
        this.hasFlag,
        this.hasBomb,
        this.bombAround});

  CubeModel.fromJson(Map<String, dynamic> json) {
    xLine = json['xLine'];
    yLine = json['yLine'];
    isTap = json['isTap'];
    hasFlag = json['hasFlag'];
    hasBomb = json['hasBomb'];
    bombAround = json['bombAround'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xLine'] = this.xLine;
    data['yLine'] = this.yLine;
    data['isTap'] = this.isTap;
    data['hasFlag'] = this.hasFlag;
    data['hasBomb'] = this.hasBomb;
    data['bombAround'] = this.bombAround;
    return data;
  }
}
