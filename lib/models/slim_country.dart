// NOTE: check correct type for corresponding props
class SlimCountry {
  final String commonName;
  final String officialName;
  final int population;
  final String flagUrl;
  final bool independent;
  final String status;
  final String capitalName;
  final String subregion;
  final double area; // sometimes use precise area -> double
  final String currencyName;

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
  });

  // TODO: implement toJson (and maybe fromMap, toMap ?)

  // NOTE: make sure to doublecheck prop name from BE correctly
  // use nullish coalescing ?? if not accessing 1 nested
  // use tenary ops ? : when > 1 nested
  factory SlimCountry.fromJson(Map<String, dynamic> rawJsonData) {
    return SlimCountry(
      commonName: rawJsonData['name']['common'],
      officialName: rawJsonData['name']['official'],
      population: rawJsonData['population'],
      flagUrl: rawJsonData['flags']['png'],
      independent: rawJsonData['independent'] ??
          false, // some don't have this (e.g. Kosovo)
      status: rawJsonData['status'],
      capitalName: (rawJsonData['capital'] != null &&
              rawJsonData['capital'][0] != null)
          ? rawJsonData['capital'][0]
          : 'No Info', // some don't have (e.g. Antarctica) + avoid runtime err if not existed
      subregion: rawJsonData['subregion'] ??
          rawJsonData['region'], // some only have regions
      area: rawJsonData['area'],
      // (rawJsonData['currencies'] as Map<String, dynamic>).keys.first === 'VND' | 'GBP' | 'EUR' | 'AUD' (based on each details card)
      // then wrap rawJsonData['currencies'][(rawJsonData['currencies'] as Map<String, dynamic>).keys.first] as A
      // finally currencyName: (A check not null) ? A : 'no data'
      currencyName: (rawJsonData['currencies'] != null &&
              rawJsonData['currencies'][
                      (rawJsonData['currencies'] as Map<String, dynamic>)
                          .keys
                          .first] !=
                  null)
          ? rawJsonData['currencies'][
              (rawJsonData['currencies'] as Map<String, dynamic>)
                  .keys
                  .first]['name']
          : 'No Info',
    );
  }
}
