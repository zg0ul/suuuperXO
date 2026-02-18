import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:suuuperxo/features/game/domain/models/board_state.dart';
import 'package:suuuperxo/features/game/presentation/widgets/cell.dart';

class SmallBoardWidget extends StatelessWidget {
  final BoardState board;
  final int boardIndex;
  const SmallBoardWidget({super.key, required this.board, required this.boardIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: board.cells.length,
          padding: const EdgeInsets.all(16),

          itemBuilder: (context, index) {
            return CellWidget(cellState: board.cells[index], boardIndex: boardIndex, cellIndex: index);
          },
        ),
        if (board.status != BoardStatus.active)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.7)),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  board.status == BoardStatus.wonByPlayerOne
                      ? 'X'
                      : board.status == BoardStatus.wonByPlayerTwo
                      ? 'O'
                      : '-',
                  style: const TextStyle(fontSize: 64, color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
