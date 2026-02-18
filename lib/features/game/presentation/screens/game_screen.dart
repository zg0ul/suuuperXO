import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:suuuperxo/features/game/domain/enums/player_enum.dart';
import 'package:suuuperxo/features/game/domain/models/game_state.dart';
import 'package:suuuperxo/features/game/presentation/providers/game_controller.dart';
import 'package:suuuperxo/features/game/presentation/widgets/meta_board.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('SuuuperXO')),
      body: Column(
        children: [
          // In GameScreen
          Text('Current Player: ${gameState.currentPlayer == Player.playerOne ? "X" : "O"}'),

          if (gameState.result != GameResult.inProgress) ...[
            Text('Winner: ${gameState.result}', style: const TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () {
                ref.read(gameControllerProvider.notifier).resetGame();
              },
              child: const Text('Reset Game'),
            ),
          ],

          Expanded(
            child: Center(child: MetaBoardWidget(boards: gameState.boards)),
          ),
        ],
      ),
    );
  }
}
