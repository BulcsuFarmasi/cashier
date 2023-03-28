enum Currency {
  huf('Forint'),
  eur('Euró');

  const Currency(this.name);

  final String name;

  @override
  String toString() {
    switch(this) {
      case Currency.huf:
        return "huf";
      case Currency.eur:
        return "eur";
    }
  }
}
