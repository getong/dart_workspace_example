import 'package:factory_user_example/factory_user_example.dart';

void main(List<String> arguments) {
  final player1 = Player.fromCache('Ada', 'Lovelace');
  final player2 = Player.fromCache('Ada', 'Lovelace');
  final player3 = Player.fromCache('Grace', 'Hopper');

  print('calculate(): ${calculate()}');
  print(
    'player1 and player2 are same instance: ${identical(player1, player2)}',
  );
  print('player3: ${player3.firstName} ${player3.lastName}');
}
