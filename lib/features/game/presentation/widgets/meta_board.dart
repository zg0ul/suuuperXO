import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:suuuperxo/features/game/domain/models/board_state.dart';
import 'package:suuuperxo/features/game/presentation/widgets/small_board.dart';

class MetaBoardWidget extends ConsumerWidget {
  final List<BoardState> boards;
  const MetaBoardWidget({super.key, required this.boards});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      shrinkWrap: true, // makes gridview size itself to its children instead of expanding
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: boards.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final row = index ~/ 3;
        final col = index % 3;
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: row > 0 ? const BorderSide(color: Colors.black) : BorderSide.none,
              left: col > 0 ? const BorderSide(color: Colors.black) : BorderSide.none,
              right: col < 2 ? const BorderSide(color: Colors.black) : BorderSide.none,
              bottom: row < 2 ? const BorderSide(color: Colors.black) : BorderSide.none,
            ),
          ),
          child: SmallBoardWidget(board: boards[index], boardIndex: index),
        );
      },
    );
  }
}
