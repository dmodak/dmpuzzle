import 'package:dmpuzzle/ui/svc/dm_game_svc/dm_game_svc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DmGameGridPage extends StatefulWidget {
  DmGameGridPage({Key? key}) : super(key: key);

  @override
  _DmGameGridPageState createState() => _DmGameGridPageState();
}

class _DmGameGridPageState extends State<DmGameGridPage>
    with SingleTickerProviderStateMixin {
  DmGameGridModel? _memGrid;

  List<BoardWidgetRow> answerBoardWidget = [];
  List<BoardWidgetRow> playerBoardWidget = [];

  List<bool> selGridSizeButtonList = [true, false, false];
  List<bool> selImageTypeButtonList = [true, false, false];
  List<bool> selImageColorButtonList = [true, false, false];

  Duration _elapsed = Duration.zero;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _memGrid = DmGameGridModel(exchangeTiles);

    _ticker = createTicker((elapsed) {
      setState(() {
        _elapsed = elapsed;
      });
    });

    //_memGrid!.media = MediaQuery.of(context);
    // _memGrid!.mediaSize = MediaQuery.of(context).size;

    _memGrid!.setGridSize(3);
    _memGrid!.clearSelImageType();
    _memGrid!.addSelImageType(ImageType.kiwi);
    _memGrid!.clearSelImageColor();
    _memGrid!.addSelImageColor(ImageColor.red);

    // Set up  answer model and shuffle images.
    _memGrid!.setBoardModel();

    refreshAnswerBoardWidget();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _memGrid!.mediaSize = MediaQuery.of(context).size;

    // print(MediaQuery.of(context).size.height.toString);
    //  print(MediaQuery.of(context).size.width.toString);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DmGameGridModel>(create: (context) => _memGrid!),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("DM Puzzle Game"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                showGameOptionContainer(),
                showGameBoardContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showGameOptionContainer() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 15.0,
        runSpacing: 15.0,
        children: <Widget>[
          Container(
            height: 100,
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              children: [
                const Text("Select Grid Size",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16)),
                const SizedBox(height: 5.0),
                ToggleButtons(
                  children: const <Widget>[
                    Icon(Icons.grid_view, size: 15.0),
                    Icon(Icons.grid_view, size: 25.0),
                    Icon(Icons.grid_view, size: 40.0),
                  ],
                  onPressed: (_memGrid!.gameStateCd == GameState.selectOptions)
                      ? (int index) {
                          setState(() {
                            setGridSize(index);
                            // Set up  answer model and shuffle images.
                            _memGrid!.setBoardModel();
                            refreshAnswerBoardWidget();
                          });
                        }
                      : null,
                  isSelected: selGridSizeButtonList,
                ),
                // SizedBox(height: 10.0),
              ],
            ),
          ),
          Container(
            height: 100,
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              children: [
                const Text("Select Icon Type",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16)),
                const SizedBox(height: 5.0),
                ToggleButtons(
                  children: const <Widget>[
                    Icon(FontAwesomeIcons.kiwiBird),
                    Icon(FontAwesomeIcons.dog),
                    Icon(FontAwesomeIcons.car),
                  ],
                  onPressed: (_memGrid!.gameStateCd == GameState.selectOptions)
                      ? (int index) {
                          setState(() {
                            setGridIconType(index);
                            // Set up  answer model and shuffle images.
                            _memGrid!.setBoardModel();

                            refreshAnswerBoardWidget();
                          });
                        }
                      : null,
                  isSelected: selImageTypeButtonList,
                ),
                // SizedBox(height: 10.0),
              ],
            ),
          ),
          Container(
            height: 100,
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              children: [
                const Text("Select Icon Color",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16)),
                const SizedBox(height: 5.0),
                ToggleButtons(
                  children: const <Widget>[
                    Icon(FontAwesomeIcons.solidCircle,
                        size: 30.0, color: Colors.red),
                    Icon(FontAwesomeIcons.solidCircle,
                        size: 30.0, color: Colors.green),
                    Icon(FontAwesomeIcons.solidCircle,
                        size: 30.0, color: Colors.blue),
                  ],
                  onPressed: (_memGrid!.gameStateCd == GameState.selectOptions)
                      ? (int index) {
                          setState(() {
                            setGridIconColor(index);
                            // Set up  answer model and shuffle images.
                            _memGrid!.setBoardModel();

                            refreshAnswerBoardWidget();
                          });
                        }
                      : null,
                  isSelected: selImageColorButtonList,
                ),
                // SizedBox(height: 10.0),
              ],
            ),
          ),
          if ((_memGrid!.gameStateCd == GameState.selectOptions))
            Container(
              height: 100,
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  OutlinedButton.icon(
                      label: Text('How to Play'),
                      icon: Icon(Icons.play_circle_outline),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Instructions"),
                                titleTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                                backgroundColor: Colors.grey.shade200,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Got It'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                                content: const Text(
                                    "This is a slider puzzle game. This game places different color images randomly in a grid. User can select grid size, image types and image colors from selection menu. The puzzle board is dynamically generated based on user selection. The generated game board is shown on left hand side on the web page. Once the user selects the ‘Play Game' button it will generate a play board and show it on the right side of the web page.",
                                    style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12)),
                              );
                            });
                      }),
                  Spacer(),
                  OutlinedButton.icon(
                      label: Text('Start Game'),
                      icon: Icon(Icons.play_circle_outline),
                      onPressed: () {
                        setState(() {
                          // Set up  answer model and shuffle images.
                          _memGrid!.setBoardModel();
                          refreshAnswerBoardWidget();
                          refreshPlayerBoardWidget();

                          if (_ticker.isActive) {
                            _ticker.stop(canceled: false);
                          }
                          _ticker.start();
                          _memGrid!.gameStateCd = GameState.playGame;
                        });
                      }),
                ],
              ),
            ),
          if (_memGrid!.gameStateCd == GameState.playGame)
            Container(
              height: 100,
              width: 150,
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                              _elapsed.inHours.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20)),
                        ),
                        const SizedBox(width: 2),
                        Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                              _elapsed.inMinutes.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20)),
                        ),
                        const SizedBox(width: 2),
                        Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                              _elapsed.inSeconds
                                  .remainder(60)
                                  .toString()
                                  .padLeft(2, '0'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20)),
                        ),
                      ]),
                  // Spacer(),
                  Text('Moves - ' +
                      _memGrid!
                          .getPlayer1MoveCount()
                          .toString()
                          .padLeft(3, '0')),
                  //Spacer(),
                  OutlinedButton.icon(
                      icon: Icon(Icons.stop_circle_outlined),
                      label: Text('Stop Game'),
                      onPressed: () {
                        setState(() {
                          _memGrid!.gameStateCd = GameState.selectOptions;
                          if (_ticker.isActive) {
                            _ticker.stop(canceled: false);
                          }
                        });
                      }),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Container showGameBoardContainer() {
    return Container(
      //height: 500,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 15.0,
        runSpacing: 15.0,
        children: <Widget>[
          AbsorbPointer(
            absorbing: true,
            child: Column(
              children: [
                const Text("Board Puzzle",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16)),
                const SizedBox(height: 5.0),
                Container(
                  // margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: _memGrid!.boardWidth,
                  padding: const EdgeInsets.all(20.0),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: getAnswerBoardWidget(),
                ),
              ],
            ),
          ),
          if (_memGrid!.gameStateCd == GameState.playGame)
            Column(
              children: [
                const Text("Player Board",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16)),
                const SizedBox(height: 5.0),
                Container(
                  //margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: _memGrid!.boardWidth,
                  padding: const EdgeInsets.all(20.0),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: getPlayerBoardWidget(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Container showGameBoardContainerxxx() {
    return Container(
      height: 500,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AbsorbPointer(
                absorbing: true,
                child: Container(
                  // margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: const EdgeInsets.all(20.0),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: getAnswerBoardWidget(),
                ),
              ),
              Spacer(flex: 2),
              if (_memGrid!.gameStateCd == GameState.playGame)
                AbsorbPointer(
                  absorbing: !(_memGrid!.gameStateCd == GameState.playGame),
                  child: Container(
                    //margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    padding: const EdgeInsets.all(20.0),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: getPlayerBoardWidget(),
                  ),
                ),
              Spacer(flex: 10),
            ],
          ),
        ],
      ),
    );
  }

  Column getAnswerBoardWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              for (var _widgetTile in answerBoardWidget[0].tileWidgetList)
                _widgetTile
            ],
          ),
          Row(
            children: [
              for (var _widgetTile in answerBoardWidget[1].tileWidgetList)
                _widgetTile
            ],
          ),
          Row(
            children: [
              for (var _widgetTile in answerBoardWidget[2].tileWidgetList)
                _widgetTile
            ],
          ),
          if (_memGrid!.gridSize >= 4) ...[
            Row(
              children: [
                for (var _widgetTile in answerBoardWidget[3].tileWidgetList)
                  _widgetTile
              ],
            ),
          ],
          if (_memGrid!.gridSize >= 5) ...[
            Row(
              children: [
                for (var _widgetTile in answerBoardWidget[4].tileWidgetList)
                  _widgetTile
              ],
            ),
          ],
          if (_memGrid!.gridSize >= 6) ...[
            Row(
              children: [
                for (var _widgetTile in answerBoardWidget[5].tileWidgetList)
                  _widgetTile
              ],
            ),
          ]
        ]);
  }

  Column getPlayerBoardWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              for (var _widgetTile in playerBoardWidget[0].tileWidgetList)
                _widgetTile
            ],
          ),
          Row(
            children: [
              for (var _widgetTile in playerBoardWidget[1].tileWidgetList)
                _widgetTile
            ],
          ),
          Row(
            children: [
              for (var _widgetTile in playerBoardWidget[2].tileWidgetList)
                _widgetTile
            ],
          ),
          if (_memGrid!.gridSize >= 4) ...[
            Row(
              children: [
                for (var _widgetTile in playerBoardWidget[3].tileWidgetList)
                  _widgetTile
              ],
            ),
          ],
          if (_memGrid!.gridSize >= 5) ...[
            Row(
              children: [
                for (var _widgetTile in playerBoardWidget[4].tileWidgetList)
                  _widgetTile
              ],
            ),
          ],
          if (_memGrid!.gridSize >= 6) ...[
            Row(
              children: [
                for (var _widgetTile in playerBoardWidget[5].tileWidgetList)
                  _widgetTile
              ],
            ),
          ]
        ]);
  }

  setGridSize(int index) {
    for (int i = 0; i < selGridSizeButtonList.length; i++) {
      if (i == index) {
        selGridSizeButtonList[i] = true;
      } else {
        selGridSizeButtonList[i] = false;
      }
    }
    // Get grid size
    if (selGridSizeButtonList[0]) {
      _memGrid!.setGridSize(3);
    } else if (selGridSizeButtonList[1]) {
      _memGrid!.setGridSize(4);
    } else if (selGridSizeButtonList[2]) {
      _memGrid!.setGridSize(6);
    }
  }

  setGridIconType(int index) {
    selImageTypeButtonList[index]
        ? selImageTypeButtonList[index] = false
        : selImageTypeButtonList[index] = true;

    //if none is selected the undo last one
    int trueCount = 0;
    for (int i = 0; i < selImageTypeButtonList.length; i++) {
      if (selImageTypeButtonList[i] == true) {
        trueCount = trueCount + 1;
      }
    }
    if (trueCount == 0) {
      selImageTypeButtonList[index] = true;
    }

    // Set image type
    _memGrid!.clearSelImageType();

    if (selImageTypeButtonList[0]) {
      _memGrid!.addSelImageType(ImageType.kiwi);
    }
    if (selImageTypeButtonList[1]) {
      _memGrid!.addSelImageType(ImageType.dog);
    }
    if (selImageTypeButtonList[2]) {
      _memGrid!.addSelImageType(ImageType.car);
    }
  }

  setGridIconColor(int index) {
    selImageColorButtonList[index]
        ? selImageColorButtonList[index] = false
        : selImageColorButtonList[index] = true;

    //if none is selected the undo last one
    int trueCount = 0;
    for (int i = 0; i < selImageColorButtonList.length; i++) {
      if (selImageColorButtonList[i] == true) {
        trueCount = trueCount + 1;
      }
    }
    if (trueCount == 0) {
      selImageColorButtonList[index] = true;
    }

    // Set image type
    _memGrid!.clearSelImageColor();

    if (selImageColorButtonList[0]) {
      _memGrid!.addSelImageColor(ImageColor.red);
    }
    if (selImageColorButtonList[1]) {
      _memGrid!.addSelImageColor(ImageColor.green);
    }
    if (selImageColorButtonList[2]) {
      _memGrid!.addSelImageColor(ImageColor.blue);
    }
  }

  refreshPlayerBoardWidget() {
    playerBoardWidget = [];

    for (int i = 0; i < _memGrid!.gridSize; i++) {
      BoardWidgetRow _boardWidgetRow = BoardWidgetRow();
      for (int j = 0; j < _memGrid!.gridSize; j++) {
        _boardWidgetRow.tileWidgetList.add(
          TileWidget(
            key: UniqueKey(),
            row: i,
            col: j,
            boardTypeCd: BoardType.player,
          ),
        );
      }
      playerBoardWidget.add(_boardWidgetRow);
    }
  }

  refreshAnswerBoardWidget() {
    answerBoardWidget = [];

    for (int i = 0; i < _memGrid!.gridSize; i++) {
      BoardWidgetRow _boardWidgetRow = BoardWidgetRow();
      for (int j = 0; j < _memGrid!.gridSize; j++) {
        _boardWidgetRow.tileWidgetList.add(
          TileWidget(
            key: UniqueKey(),
            row: i,
            col: j,
            boardTypeCd: BoardType.answer,
          ),
        );
      }
      answerBoardWidget.add(_boardWidgetRow);
    }
  }

  exchangeTiles(int sourceRow, int sourceCol) {
    int oldEmptyRow = _memGrid!.emptyTileRow;
    int oldEmptyCol = _memGrid!.emptyTileCol;

    int newEmptyRow = sourceRow;
    int newEmptyCol = sourceCol;

    if (oldEmptyRow == sourceRow && oldEmptyCol == sourceCol) {
      //do nothing
    } else if (oldEmptyRow == sourceRow) {
      _memGrid!.emptyTileRow = -1;
      _memGrid!.emptyTileCol = -1;
      // Set empty row.
      playerBoardWidget[sourceRow].tileWidgetList[sourceCol] = TileWidget(
        key: UniqueKey(),
        row: oldEmptyRow,
        col: oldEmptyCol,
        boardTypeCd: BoardType.player,
      );

      //If rows are matching then shift column cells
      if (oldEmptyCol > sourceCol) {
        //Shift cell from left to right
        for (int i = oldEmptyCol; i > sourceCol; i--) {
          shiftTiles(sourceRow, i - 1, sourceRow, i);
        }
      } else {
        //Shift cell from right to left
        for (int i = oldEmptyCol; i < sourceCol; i++) {
          shiftTiles(sourceRow, i + 1, sourceRow, i);
        }
      }

      //
      // Set empty row.
      _memGrid!.emptyTileRow = newEmptyRow;
      _memGrid!.emptyTileCol = newEmptyCol;

      playerBoardWidget[sourceRow].tileWidgetList[sourceCol] = TileWidget(
        key: UniqueKey(),
        row: newEmptyRow,
        col: newEmptyCol,
        boardTypeCd: BoardType.player,
      );
    } else if (oldEmptyCol == sourceCol) {
      _memGrid!.emptyTileRow = -1;
      _memGrid!.emptyTileCol = -1;
      // Set empty row.
      playerBoardWidget[sourceRow].tileWidgetList[sourceCol] = TileWidget(
        key: UniqueKey(),
        row: oldEmptyRow,
        col: oldEmptyCol,
        boardTypeCd: BoardType.player,
      );

      //If columns are matching then shift row cells
      if (oldEmptyRow > sourceRow) {
        //Shift cell from left to right
        for (int i = oldEmptyRow; i > sourceRow; i--) {
          shiftTiles(i - 1, sourceCol, i, sourceCol);
        }
      } else {
        //Shift cell from right to left
        for (int i = oldEmptyRow; i < sourceRow; i++) {
          shiftTiles(i + 1, sourceCol, i, sourceCol);
        }
      }

      // Set empty row.
      _memGrid!.emptyTileRow = newEmptyRow;
      _memGrid!.emptyTileCol = newEmptyCol;

      playerBoardWidget[sourceRow].tileWidgetList[sourceCol] = TileWidget(
        key: UniqueKey(),
        row: newEmptyRow,
        col: newEmptyCol,
        boardTypeCd: BoardType.player,
      );
    } else {
      //do nothing
    }

    // check for game is over
    bool _gameOver = true;
    for (int i = 0; i < _memGrid!.gridSize; i++) {
      for (int j = 0; j < _memGrid!.gridSize; j++) {
        if (_memGrid!.getGameModel()[i].tileModelList[j].isAnswerImage !=
                _memGrid!.getGameModel()[i].tileModelList[j].isPlayer1Image ||
            _memGrid!.getGameModel()[i].tileModelList[j].answerImageTypeCd !=
                _memGrid!
                    .getGameModel()[i]
                    .tileModelList[j]
                    .player1ImageTypeCd ||
            _memGrid!.getGameModel()[i].tileModelList[j].answerImageColorCd !=
                _memGrid!
                    .getGameModel()[i]
                    .tileModelList[j]
                    .player1ImageColorCd) {
          _gameOver = false;
        }
      }
    }

    // printBoardImage();

    if (_gameOver) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Congratulation!"),
              titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
              backgroundColor: Colors.greenAccent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
              content: const Text("You solved the game successfully.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16)),
            );
          });

      _memGrid!.gameStateCd = GameState.selectOptions;
    }

    setState(() {});
  }

  setEmptyTylexxxxxx(int row, int col) {
    playerBoardWidget[row].tileWidgetList[col] = TileWidget(
      key: UniqueKey(),
      row: row,
      col: col,
      boardTypeCd: BoardType.player,
    );
  }

  shiftTiles(int sourceRow, int sourceCol, int targetRow, int targetCol) {
    ImageType sourcePlayer1ImageTypeCd = _memGrid!
        .getGameModel()[sourceRow]
        .tileModelList[sourceCol]
        .player1ImageTypeCd;
    ImageColor sourcePlayer1ImageColorCd = _memGrid!
        .getGameModel()[sourceRow]
        .tileModelList[sourceCol]
        .player1ImageColorCd;
    bool isPlayer1SourceImage = _memGrid!
        .getGameModel()[sourceRow]
        .tileModelList[sourceCol]
        .isPlayer1Image;

    ImageType targetPlayer1ImageTypeCd = _memGrid!
        .getGameModel()[targetRow]
        .tileModelList[targetCol]
        .player1ImageTypeCd;
    ImageColor targetPlayer1ImageColorCd = _memGrid!
        .getGameModel()[targetRow]
        .tileModelList[targetCol]
        .player1ImageColorCd;
    bool isPlayer1TargetImage = _memGrid!
        .getGameModel()[targetRow]
        .tileModelList[targetCol]
        .isPlayer1Image;

    _memGrid!
        .getGameModel()[sourceRow]
        .tileModelList[sourceCol]
        .player1ImageTypeCd = targetPlayer1ImageTypeCd;
    _memGrid!
        .getGameModel()[sourceRow]
        .tileModelList[sourceCol]
        .player1ImageColorCd = targetPlayer1ImageColorCd;
    _memGrid!
        .getGameModel()[sourceRow]
        .tileModelList[sourceCol]
        .isPlayer1Image = isPlayer1TargetImage;

    _memGrid!
        .getGameModel()[targetRow]
        .tileModelList[targetCol]
        .player1ImageTypeCd = sourcePlayer1ImageTypeCd;
    _memGrid!
        .getGameModel()[targetRow]
        .tileModelList[targetCol]
        .player1ImageColorCd = sourcePlayer1ImageColorCd;
    _memGrid!
        .getGameModel()[targetRow]
        .tileModelList[targetCol]
        .isPlayer1Image = isPlayer1SourceImage;

    playerBoardWidget[sourceRow].tileWidgetList[sourceCol] = TileWidget(
      key: UniqueKey(),
      row: sourceRow,
      col: sourceCol,
      boardTypeCd: BoardType.player,
    );

    playerBoardWidget[targetRow].tileWidgetList[targetCol] = TileWidget(
      key: UniqueKey(),
      row: targetRow,
      col: targetCol,
      boardTypeCd: BoardType.player,
    );

    // Increment move count.
    _memGrid!.addPlayer1MoveCount();
  }
}
