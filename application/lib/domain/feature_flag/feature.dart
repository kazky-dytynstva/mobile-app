enum Feature {
  donation(
    'flag_donation_enabled',
    true,
    Owner.Andrii,
    desc:
        'Used to `hide` donation from the googlePlay/appStore during release ☺️.'
        '\nDO NOT DELETE!',
  ),
  homePage(
    'flag_home_page_enabled',
    true,
    Owner.Andrii,
    desc: 'Used to `show` home page on the home screen',
  );

  /// Used as keyID + in firebase remote configs
  final String key;
  final bool defaultValue;
  final Owner owner;
  final String? desc;

  const Feature(
    this.key,
    this.defaultValue,
    this.owner, {
    this.desc,
  });
}

// ignore_for_file: constant_identifier_names
enum Owner {
  Alina,
  Andrii,
  Yurii,
}

extension FeatureX on Feature {
  String get title =>
      key.replaceAll('flag_', '').replaceAll('_', ' ').toUpperCase();
}
