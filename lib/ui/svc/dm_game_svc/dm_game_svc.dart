import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DmGameGridModel extends ChangeNotifier {
  void Function(int, int) exchangeTiles;

  static double small = 312;
  static double medium = 424;
  static double large = 500;

  int gridSize = 3;
  int totalImageCount = 0;
  int _player1MoveCount = 0;

  int emptyTileRow = 0;
  int emptyTileCol = 0;

  Size mediaSize = const Size(50, 50);
  //MediaQueryData? media;

  double boardWidth = 300;

  double tileWidth = 50;
  double tileHeight = 50;

  GameState gameStateCd = GameState.selectOptions;

  List<BoardModelRow> _boardModel = [];

  List<ImageType> _selImageType = [ImageType.kiwi];
  List<ImageColor> _selImageColor = [ImageColor.red];

  DmGameGridModel(this.exchangeTiles);

  void setGridSize(int pGridSize) {
    gridSize = pGridSize;
    if (pGridSize == 3) {
      totalImageCount = 4;

      boardWidth = 300;
    } else if (pGridSize == 4) {
      totalImageCount = 8;
      boardWidth = 400;
    } else if (pGridSize == 6) {
      totalImageCount = 18;
      boardWidth = 500;
    }
  }

  int getPlayer1MoveCount() {
    return _player1MoveCount;
  }

  // void resetPlayer1MoveCountxxxxx() {
  //   _player1MoveCount = 0;
  // }

  void addPlayer1MoveCount() {
    _player1MoveCount = _player1MoveCount + 1;
  }

  void clearSelImageType() {
    _selImageType = [];
  }

  void addSelImageType(ImageType pImageType) {
    _selImageType.add(pImageType);
  }

  void clearSelImageColor() {
    _selImageColor = [];
  }

  void addSelImageColor(ImageColor pImageColor) {
    _selImageColor.add(pImageColor);
  }

  List<BoardModelRow> getGameModel() {
    return _boardModel;
  }

  void setBoardModel() {
    bool _challengeCount = true;

    _boardModel = [];

    for (int i = 0; i < gridSize; i++) {
      BoardModelRow _boardModelRow = BoardModelRow();

      for (int j = 0; j < gridSize; j++) {
        _boardModelRow.tileModelList.add(TileModel());
      }
      _boardModel.add(_boardModelRow);
    }

    int _imageSetCount = 0;

    // Set answer set images
    while (_challengeCount) {
      int _answerRow = Random().nextInt(gridSize);
      int _answerCol = Random().nextInt(gridSize);

      int _imageColor = Random().nextInt(_selImageColor.length);
      int _imageType = Random().nextInt(_selImageType.length);

      if (!_boardModel[_answerRow].tileModelList[_answerCol].isAnswerImage) {
        _imageSetCount = _imageSetCount + 1;
        _boardModel[_answerRow].tileModelList[_answerCol].isAnswerImage = true;
        _boardModel[_answerRow].tileModelList[_answerCol].answerImageTypeCd =
            _selImageType[_imageType];
        _boardModel[_answerRow].tileModelList[_answerCol].answerImageColorCd =
            _selImageColor[_imageColor];
      }

      if (_imageSetCount >= totalImageCount) {
        _challengeCount = false;
        break; // stop loop immediately
      }
    }

    // shuffle answer set images
    _challengeCount = true;
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (_boardModel[i].tileModelList[j].isAnswerImage) {
          _challengeCount = true;
          while (_challengeCount) {
            int _shuffleRow = Random().nextInt(gridSize);
            int _shuffleCol = Random().nextInt(gridSize);
            if (!_boardModel[_shuffleRow]
                .tileModelList[_shuffleCol]
                .isPlayer1Image) {
              _boardModel[_shuffleRow]
                  .tileModelList[_shuffleCol]
                  .isPlayer1Image = true;
              _boardModel[_shuffleRow]
                      .tileModelList[_shuffleCol]
                      .player1ImageTypeCd =
                  _boardModel[i].tileModelList[j].answerImageTypeCd;
              _boardModel[_shuffleRow]
                      .tileModelList[_shuffleCol]
                      .player1ImageColorCd =
                  _boardModel[i].tileModelList[j].answerImageColorCd;
              _challengeCount = false;
            }
          }
        }
      }
    }

    // decide empty tile
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (!(_boardModel[i].tileModelList[j].isAnswerImage) &&
            !(_boardModel[i].tileModelList[j].isPlayer1Image)) {
          emptyTileRow = i;
          emptyTileCol = j;
        }
      }
    }
  }
}

class TileModel {
  bool isAnswerImage = false;
  ImageType answerImageTypeCd = ImageType.none;
  ImageColor answerImageColorCd = ImageColor.none;
  bool isPlayer1Image = false;
  ImageType player1ImageTypeCd = ImageType.none;
  ImageColor player1ImageColorCd = ImageColor.none;

  TileModel() {
    isAnswerImage = false;
    isPlayer1Image = false;
  }
}

class BoardModelRow {
  List<TileModel> tileModelList = [];
}

// Decides the size of the grid
// small = 3 X 3
// medium = 4 X 4
// large = 6 X 6
enum MemGridSize { small, medium, large }
enum ImageType { kiwi, dog, car, none }
enum ImageColor { red, green, blue, none }

enum GameState { selectOptions, playGame }
enum BoardType { answer, player }

class TileWidget extends StatefulWidget {
  @override
  _TileWidgetState createState() => _TileWidgetState();

  TileWidget({
    required Key key,
    required this.row,
    required this.col,
    required this.boardTypeCd,
  }) : super(key: key);

  int row = 0;
  int col = 0;
  BoardType boardTypeCd = BoardType.answer;

  double borderWidth = 1;

  Color answerStartColor = Colors.grey.shade200;

  Color answerEndColor = Colors.yellow;
}

class _TileWidgetState extends State<TileWidget> with TickerProviderStateMixin {
  late AnimationController _answerTileController;
  late Animation<Decoration> _answerTileDecorationTween;
  late AnimationController _answerEmptyTileController;
  late Animation<Decoration> _answerEmptyTileDecorationTween;

  late AnimationController _playerTileController;
  late Animation<Decoration> _playerTileDecorationTween;

  late AnimationController _playerEmptyTileController;
  late Animation<Decoration> _playerEmptyTileDecorationTween;

  void initState() {
    super.initState();

    _answerTileController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _answerTileController.repeat(reverse: true);

    _answerEmptyTileController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _answerEmptyTileController.repeat(reverse: true);

    _playerTileController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _playerTileController.repeat(reverse: true);

    _playerEmptyTileController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _playerEmptyTileController.repeat(reverse: true);

    _answerTileDecorationTween = DecorationTween(
            begin: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(
                    width: widget.borderWidth + 3, color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            end: BoxDecoration(
                color: Colors.grey.shade600,
                border: Border.all(
                    width: widget.borderWidth, color: Colors.greenAccent),
                borderRadius: BorderRadius.circular(10)))
        .animate(_answerTileController);

    _answerEmptyTileDecorationTween = DecorationTween(
            begin: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(
                    width: widget.borderWidth + 3, color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            end: BoxDecoration(
                color: Colors.yellow.shade200,
                border: Border.all(
                    width: widget.borderWidth, color: Colors.redAccent),
                borderRadius: BorderRadius.circular(10)))
        .animate(_answerEmptyTileController);

    _playerTileDecorationTween = DecorationTween(
            begin: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(
                    width: widget.borderWidth + 3, color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            end: BoxDecoration(
                color: Colors.pink.shade600,
                border: Border.all(
                    width: widget.borderWidth, color: Colors.greenAccent),
                borderRadius: BorderRadius.circular(10)))
        .animate(_playerTileController);

    _playerEmptyTileDecorationTween = DecorationTween(
            begin: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: widget.borderWidth + 3, color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            end: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: widget.borderWidth, color: Colors.redAccent),
                borderRadius: BorderRadius.circular(10)))
        .animate(_playerEmptyTileController);
  }

  void dispose() {
    _answerTileController.dispose();
    _answerEmptyTileController.dispose();

    _playerTileController.dispose();
    _playerEmptyTileController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.boardTypeCd == BoardType.answer)
        ? getAnswerTile(context)
        : getPlayerTile(context);
  }

  Widget getAnswerTile(BuildContext context) {
    Icon _tileIcon = const Icon(null);
    Color _iconColor = Colors.black87;

    ImageColor _tileImageColorCd = ImageColor.none;
    ImageType _tileImageTypeCd = ImageType.none;
    bool isAnswerTile = false;

    if (Provider.of<DmGameGridModel>(context, listen: false)
        .getGameModel()[widget.row]
        .tileModelList[widget.col]
        .isAnswerImage) {
      widget.borderWidth = 10.0;
      isAnswerTile = true;
    } else {
      widget.borderWidth = 2.0;
      isAnswerTile = false;
    }

    _tileImageColorCd = Provider.of<DmGameGridModel>(context, listen: false)
        .getGameModel()[widget.row]
        .tileModelList[widget.col]
        .answerImageColorCd;

    _tileImageTypeCd = Provider.of<DmGameGridModel>(context, listen: false)
        .getGameModel()[widget.row]
        .tileModelList[widget.col]
        .answerImageTypeCd;

    if (_tileImageColorCd == ImageColor.red) {
      _iconColor = Colors.red;
    }

    if (_tileImageColorCd == ImageColor.green) {
      _iconColor = Colors.green;
    }

    if (_tileImageColorCd == ImageColor.blue) {
      _iconColor = Colors.blue;
    }

    if (_tileImageTypeCd == ImageType.car) {
      _tileIcon = Icon(FontAwesomeIcons.car, color: _iconColor);
    }
    if (_tileImageTypeCd == ImageType.dog) {
      _tileIcon = Icon(FontAwesomeIcons.dog, color: _iconColor);
    }
    if (_tileImageTypeCd == ImageType.kiwi) {
      _tileIcon = Icon(FontAwesomeIcons.kiwiBird, color: _iconColor);
    }

    return DecoratedBoxTransition(
      decoration: isAnswerTile
          ? _answerTileDecorationTween
          : _answerEmptyTileDecorationTween,
      child: Container(
        height: Provider.of<DmGameGridModel>(context, listen: false).tileHeight,
        width: Provider.of<DmGameGridModel>(context, listen: false).tileWidth,
        margin: const EdgeInsets.all(10),
        child: IconButton(
          icon: _tileIcon,
          onPressed: () {},
        ),
      ),
    );
  }

  Widget getPlayerTile(BuildContext context) {
    Icon _tileIcon = const Icon(null);
    Icon _tileIconNone = const Icon(null);
    bool isAnswerTile = false;
    bool isEmptyTile = false;

    Color _iconColor = Colors.black87;
    Color _tileColor = Colors.grey.shade400;

    ImageColor _tileImageColorCd = ImageColor.none;
    ImageType _tileImageTypeCd = ImageType.none;
    bool imageFound = false;
    double _borderWidth = 1.0;
    if (Provider.of<DmGameGridModel>(context, listen: false).emptyTileRow ==
            widget.row &&
        Provider.of<DmGameGridModel>(context, listen: false).emptyTileCol ==
            widget.col) {
      _tileColor = Colors.white;
      isEmptyTile = true;
    } else {
      _tileColor = Colors.grey.shade400;
      isEmptyTile = false;
    }

    if (Provider.of<DmGameGridModel>(context, listen: false)
            .getGameModel()[widget.row]
            .tileModelList[widget.col]
            .isAnswerImage &&
        Provider.of<DmGameGridModel>(context, listen: false)
                .getGameModel()[widget.row]
                .tileModelList[widget.col]
                .isAnswerImage ==
            Provider.of<DmGameGridModel>(context, listen: false)
                .getGameModel()[widget.row]
                .tileModelList[widget.col]
                .isPlayer1Image &&
        Provider.of<DmGameGridModel>(context, listen: false)
                .getGameModel()[widget.row]
                .tileModelList[widget.col]
                .answerImageTypeCd ==
            Provider.of<DmGameGridModel>(context, listen: false)
                .getGameModel()[widget.row]
                .tileModelList[widget.col]
                .player1ImageTypeCd &&
        Provider.of<DmGameGridModel>(context, listen: false)
                .getGameModel()[widget.row]
                .tileModelList[widget.col]
                .answerImageColorCd ==
            Provider.of<DmGameGridModel>(context, listen: false)
                .getGameModel()[widget.row]
                .tileModelList[widget.col]
                .player1ImageColorCd) {
      _borderWidth = 3.0;
    } else {
      _borderWidth = 2.0;
    }

    if (Provider.of<DmGameGridModel>(context, listen: false).gameStateCd ==
        GameState.playGame) {
      _tileImageColorCd = Provider.of<DmGameGridModel>(context, listen: false)
          .getGameModel()[widget.row]
          .tileModelList[widget.col]
          .player1ImageColorCd;
    } else {
      _tileImageColorCd = Provider.of<DmGameGridModel>(context, listen: false)
          .getGameModel()[widget.row]
          .tileModelList[widget.col]
          .answerImageColorCd;
    }

    if (Provider.of<DmGameGridModel>(context, listen: false).gameStateCd ==
        GameState.playGame) {
      _tileImageTypeCd = Provider.of<DmGameGridModel>(context, listen: false)
          .getGameModel()[widget.row]
          .tileModelList[widget.col]
          .player1ImageTypeCd;
    } else {
      _tileImageTypeCd = Provider.of<DmGameGridModel>(context, listen: false)
          .getGameModel()[widget.row]
          .tileModelList[widget.col]
          .answerImageTypeCd;
    }

    if (Provider.of<DmGameGridModel>(context, listen: false).gameStateCd ==
        GameState.playGame) {
      imageFound = Provider.of<DmGameGridModel>(context, listen: false)
          .getGameModel()[widget.row]
          .tileModelList[widget.col]
          .isPlayer1Image;
    } else {
      imageFound = Provider.of<DmGameGridModel>(context, listen: false)
          .getGameModel()[widget.row]
          .tileModelList[widget.col]
          .isAnswerImage;
    }

    if (_tileImageColorCd == ImageColor.red) {
      _iconColor = Colors.red;
    }

    if (_tileImageColorCd == ImageColor.green) {
      _iconColor = Colors.green;
    }

    if (_tileImageColorCd == ImageColor.blue) {
      _iconColor = Colors.blue;
    }

    if (_tileImageTypeCd == ImageType.car) {
      _tileIcon = Icon(FontAwesomeIcons.car, color: _iconColor);
    }
    if (_tileImageTypeCd == ImageType.dog) {
      _tileIcon = Icon(FontAwesomeIcons.dog, color: _iconColor);
    }
    if (_tileImageTypeCd == ImageType.kiwi) {
      _tileIcon = Icon(FontAwesomeIcons.kiwiBird, color: _iconColor);
    }

    return DecoratedBoxTransition(
      decoration: isEmptyTile
          ? _playerEmptyTileDecorationTween
          : isAnswerTile
              ? _answerTileDecorationTween
              : _playerTileDecorationTween,
      child: Container(
        height: Provider.of<DmGameGridModel>(context, listen: false).tileHeight,
        width: Provider.of<DmGameGridModel>(context, listen: false).tileWidth,
        margin: const EdgeInsets.all(10),
        child: IconButton(
          icon: _tileIcon,
          onPressed: () {
            Provider.of<DmGameGridModel>(context, listen: false)
                .exchangeTiles(widget.row, widget.col);
          },
        ),
      ),
    );
  }
}

class BoardWidgetRow {
  List<TileWidget> tileWidgetList = <TileWidget>[];
}
