class SlimCountry {
  final String commonName;
  final String officialName;
  final int population;
  final String flagPng;

  const SlimCountry({
    required this.commonName,
    required this.officialName,
    required this.population,
    required this.flagPng,
  });

  factory SlimCountry.fromJson(Map<String, dynamic> rawJsonData) {
    return SlimCountry(
        commonName: rawJsonData['name']['common'],
        officialName: rawJsonData['name']['official'],
        population: rawJsonData['population'],
        flagPng: rawJsonData['flags']['png']);
  }
}
