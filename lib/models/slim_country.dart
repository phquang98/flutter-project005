class SlimCountry {
  final String commonName;
  final String officialName;
  final int population;
  final String flagUrl;
  final bool independent;
  final String status;
  final String capitalName;

  // https://dart.dev/language/constructors#super-parameters
  const SlimCountry({
    required this.commonName,
    required this.officialName,
    required this.population,
    required this.flagUrl,
    required this.independent,
    required this.status,
    required this.capitalName,
  });

  // NOTE: make sure to doublecheck prop name from BE correctly
  factory SlimCountry.fromJson(Map<String, dynamic> rawJsonData) {
    return SlimCountry(
      commonName: rawJsonData['name']['common'],
      officialName: rawJsonData['name']['official'],
      population: rawJsonData['population'],
      flagUrl: rawJsonData['flags']['png'],
      independent: rawJsonData['independent'],
      status: rawJsonData['status'],
      capitalName: rawJsonData['capital'][0],
    );
  }
}
