class PokemonApiResponse {
  final List<PokemonCard> data;
  final int page;
  final int pageSize;
  final int count;
  final int totalCount;

  PokemonApiResponse({required this.data, required this.page, required this.pageSize, required this.count, required this.totalCount});

  factory PokemonApiResponse.fromJson(Map<String, dynamic> json) {
    return PokemonApiResponse(
      data: List<PokemonCard>.from(json['data'].map((x) => PokemonCard.fromJson(x))),
      page: json['page'],
      pageSize: json['pageSize'],
      count: json['count'],
      totalCount: json['totalCount'],
    );
  }
}

class PokemonCard {
  final String id;
  final String name;
  final String supertype;
  final List<String> subtypes;
  final String hp;
  final List<String> types;
  final String? level;
  final String? evolvesFrom;
  final List<String>? evolvesTo;
  final List<Ability>? abilities;
  final List<Attack> attacks;
  final List<Weakness> weaknesses;
  final List<String>? retreatCost;
  final List<Resistances>? resistances;
  final int? convertedRetreatCost;
  final SetInfo set;
  final String number;
  final String artist;
  String? rarity;
  final String? flavorText;
  final List<int> nationalPokedexNumbers;
  final Map<String, String> legalities;
  final Map<String, String> images;
  final TCGPlayer? tcgplayer;
  final CardMarket? cardmarket;

  PokemonCard({
    required this.id,
    required this.name,
    required this.supertype,
    required this.subtypes,
    required this.hp,
    required this.types,
    this.level,
    this.evolvesFrom,
    this.evolvesTo,
    this.abilities,
    required this.attacks,
    required this.weaknesses,
    this.retreatCost,
    this.resistances,
    this.convertedRetreatCost,
    required this.set,
    required this.number,
    required this.artist,
    this.rarity,
    this.flavorText,
    required this.nationalPokedexNumbers,
    required this.legalities,
    required this.images,
    this.tcgplayer,
    this.cardmarket,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'],
      name: json['name'],
      supertype: json['supertype'],
      subtypes: List<String>.from(json['subtypes']),
      hp: json['hp'],
      types: List<String>.from(json['types']),
      level: json['level'],
      evolvesFrom: json['evolvesFrom'],
      evolvesTo: json['evolvesTo'] != null ? List<String>.from(json['evolvesTo']) : null,
      abilities: json['abilities'] != null ? List<Ability>.from(json['abilities'].map((x) => Ability.fromJson(x))) : null,
      attacks: List<Attack>.from(json['attacks'].map((x) => Attack.fromJson(x))),
      weaknesses: List<Weakness>.from(json['weaknesses'].map((x) => Weakness.fromJson(x))),
      retreatCost: json['retreatCost'] != null ? List<String>.from(json['retreatCost']) : null,
      resistances: json['resistances'] != null ? List<Resistances>.from(json['resistances'].map((x) => Resistances.fromJson(x))) : null,
      convertedRetreatCost: json['resistances'] != null ? json['convertedRetreatCost'] : null,
      set: SetInfo.fromJson(json['set']),
      number: json['number'],
      artist: json['artist'],
      rarity: json['rarity'] != "" ? json['rarity'] : null,
      flavorText: json['flavorText'],
      nationalPokedexNumbers: List<int>.from(json['nationalPokedexNumbers']),
      legalities: Map<String, String>.from(json['legalities']),
      images: Map<String, String>.from(json['images']),
      tcgplayer: json['tcgplayer'] != null ? TCGPlayer.fromJson(json['tcgplayer']) : null,
      cardmarket: json['cardmarket'] != null ? CardMarket.fromJson(json['cardmarket']) : null,
    );
  }
}

class Ability {
  final String name;
  final String text;
  final String type;

  Ability({required this.name, required this.text, required this.type});

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(name: json['name'], text: json['text'], type: json['type']);
  }
}

class Attack {
  final String name;
  final List<String> cost;
  final int convertedEnergyCost;
  final String damage;
  final String text;

  Attack({required this.name, required this.cost, required this.convertedEnergyCost, required this.damage, required this.text});

  factory Attack.fromJson(Map<String, dynamic> json) {
    return Attack(
      name: json['name'],
      cost: List<String>.from(json['cost']),
      convertedEnergyCost: json['convertedEnergyCost'],
      damage: json['damage'],
      text: json['text'],
    );
  }
}

class Weakness {
  final String type;
  final String value;

  Weakness({required this.type, required this.value});

  factory Weakness.fromJson(Map<String, dynamic> json) {
    return Weakness(type: json['type'], value: json['value']);
  }
}

class Resistances {
  final String type;
  final String value;

  Resistances({required this.type, required this.value});

  factory Resistances.fromJson(Map<String, dynamic> json) {
    return Resistances(type: json['type'], value: json['value']);
  }
}

class SetInfo {
  final String id;
  final String name;
  final String series;
  final int printedTotal;
  final int total;
  final Map<String, String> legalities;
  String? ptcgoCode;
  final String releaseDate;
  final String updatedAt;
  final Map<String, String> images;

  SetInfo({
    required this.id,
    required this.name,
    required this.series,
    required this.printedTotal,
    required this.total,
    required this.legalities,
    this.ptcgoCode,
    required this.releaseDate,
    required this.updatedAt,
    required this.images,
  });

  factory SetInfo.fromJson(Map<String, dynamic> json) {
    return SetInfo(
      id: json['id'],
      name: json['name'],
      series: json['series'],
      printedTotal: json['printedTotal'],
      total: json['total'],
      legalities: Map<String, String>.from(json['legalities']),
      ptcgoCode: json['ptcgoCode'] != "" ? json['ptcgoCode'] : null,
      releaseDate: json['releaseDate'],
      updatedAt: json['updatedAt'],
      images: Map<String, String>.from(json['images']),
    );
  }
}

class TCGPlayer {
  final String url;
  final String updatedAt;
  final Map<String, dynamic> prices;

  TCGPlayer({required this.url, required this.updatedAt, required this.prices});

  factory TCGPlayer.fromJson(Map<String, dynamic> json) {
    return TCGPlayer(url: json['url'], updatedAt: json['updatedAt'], prices: Map<String, dynamic>.from(json['prices']));
  }
}

class CardMarket {
  final String url;
  final String updatedAt;
  final Map<String, dynamic> prices;

  CardMarket({required this.url, required this.updatedAt, required this.prices});

  factory CardMarket.fromJson(Map<String, dynamic> json) {
    return CardMarket(url: json['url'], updatedAt: json['updatedAt'], prices: Map<String, dynamic>.from(json['prices']));
  }
}
