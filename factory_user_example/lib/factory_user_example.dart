int calculate() {
  return 6 * 7;
}

class Player {
  Player(this.firstName, this.lastName);

  static final _cacheService = _PlayerCacheService();

  final String firstName;
  final String lastName;

  factory Player.fromCache(String firstName, String lastName) {
    if (_cacheService.containsPlayer(firstName, lastName)) {
      return _cacheService.getPlayer(firstName, lastName);
    } else {
      return _cacheService.putPlayer(Player(firstName, lastName));
    }
  }
}

class _PlayerCacheService {
  final Map<String, Player> _players = <String, Player>{};

  bool containsPlayer(String firstName, String lastName) {
    return _players.containsKey(_key(firstName, lastName));
  }

  Player getPlayer(String firstName, String lastName) {
    return _players[_key(firstName, lastName)]!;
  }

  Player putPlayer(Player player) {
    _players[_key(player.firstName, player.lastName)] = player;
    return player;
  }

  String _key(String firstName, String lastName) => '$firstName::$lastName';
}
