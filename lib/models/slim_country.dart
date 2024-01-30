// NOTE: check correct type for corresponding props
class SlimCountry {
  final String commonName;
  final String officialName;
  final int population;
  final String flagUrl;
  final bool independent;
  final String status;
  final String capitalName;
  // TODO: viet not subregion va area vao day
  final String subregion;
  final int area;
  // TODO: cast the nao de loi ra duoc cai currencies
  final String currencyName;
  // final String currencySymbol;

  // https://dart.dev/language/constructors#super-parameters
  const SlimCountry({
    required this.commonName,
    required this.officialName,
    required this.population,
    required this.flagUrl,
    required this.independent,
    required this.status,
    required this.capitalName,
    // TODO:
    required this.subregion,
    required this.area,
    // TODO:
    required this.currencyName,
    // required this.currencySymbol,
  });

  // TODO: implement toJson (and maybe fromMap, toMap ?)

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
      subregion: rawJsonData['subregion'],
      area: rawJsonData['area'],
      // (rawJsonData['currencies'] as Map<String, dynamic>).keys.first === 'VND' | 'GBP' | 'EUR' | 'AUD' (based on each details card)
      currencyName: rawJsonData['currencies']
              [(rawJsonData['currencies'] as Map<String, dynamic>).keys.first]
          ['name'],
      // currencySymbol: rawJsonData['currencies']
      //         [(rawJsonData['currencies'] as Map<String, dynamic>).keys.first]
      //     ['symbol'],
    );
  }
}
