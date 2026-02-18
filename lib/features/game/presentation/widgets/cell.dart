import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:suuuperxo/features/game/domain/enums/player_enum.dart';
import 'package:suuuperxo/features/game/domain/models/cell_state.dart';
import 'package:suuuperxo/features/game/presentation/providers/game_controller.dart';

class CellWidget extends ConsumerWidget {
  final CellState cellState;
  final int boardIndex;
  final int cellIndex;
  const CellWidget({super.key, required this.cellState, required this.boardIndex, required this.cellIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final owner = cellState.owner;
    var text = '';
    if (owner == Player.playerOne) {
      text = 'X';
    } else if (owner == Player.playerTwo) {
      text = 'O';
    }
    final row = cellIndex ~/ 3;
    final col = cellIndex % 3;
    return GestureDetector(
      onTap: () {
        ref.read(gameControllerProvider.notifier).makeMove(boardIndex, cellIndex);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: row > 0 ? const BorderSide(color: Colors.black) : BorderSide.none,
            left: col > 0 ? const BorderSide(color: Colors.black) : BorderSide.none,
            right: col < 2 ? const BorderSide(color: Colors.black) : BorderSide.none,
            bottom: row < 2 ? const BorderSide(color: Colors.black) : BorderSide.none,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: owner == Player.playerOne ? Colors.blue : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
