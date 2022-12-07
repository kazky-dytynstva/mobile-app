part of 'tale_sorter_test.dart';

final List<TaleId> orderedIdList = [
  TaleId(0),
  TaleId(1),
  TaleId(2),
];
final Map<TaleId, TalesPageItemData> orderedIdMap = {
  TaleId(0): createItem(id: 0),
  TaleId(1): createItem(id: 1),
  TaleId(2): createItem(id: 2),
};

var _orderedByIdCounter = 0;
final List<TalesPageItemData> orderedById = alphabetUA
    .map((e) => createItem(id: _orderedByIdCounter++))
    .toList(growable: false);

List<TalesPageItemData> idListOrderedByHashCode() {
  final sorted = List<TalesPageItemData>.from(orderedById);
  sorted.sort((a, b) => a.hashCode.compareTo(b.hashCode));
  return sorted;
}

final List<TalesPageItemData> orderedByName =
    alphabetUA.map((e) => createItem(name: e + e + e)).toList(growable: false);

List<TalesPageItemData> orderedByNameRandom() {
  final random = List<TalesPageItemData>.from(orderedByName);
  random.shuffle();
  return random;
}

final List<TalesPageItemData> orderedByProvider = alphabetUA
    .map((e) => createItem(provider: e + e + e))
    .toList(growable: false);

List<TalesPageItemData> orderedByProviderRandom() {
  final random = List<TalesPageItemData>.from(orderedByProvider);
  random.shuffle();
  return random;
}

final _defaultDate = DateTime(1970);

TalesPageItemData createItem({
  int? id,
  String? name,
  DateTime? createDate,
  DateTime? updateDate,
  String? provider,
  List<TaleTag>? tags,
  bool isFav = false,
  bool isHidden = false,
  bool isWatched = false,
  bool hasWriter = false,
  Future<bool>? isCached,
  Option<RatingData> optionRating = const None(),
}) =>
    TalesPageItemData(
      id: id != null ? TaleId(id) : TaleId(0),
      name: name != null ? TaleName(name) : TaleName('name'),
      createDate: createDate ?? _defaultDate,
      updatedDate: updateDate ?? _defaultDate,
      provider: provider != null
          ? StringSingleLine(provider)
          : StringSingleLine('provider'),
      imageUrl: ImageUrl('imageUrl'),
      tags: tags ?? TaleTag.values,
      isFav: isFav,
      isHidden: isHidden,
      isWatched: isWatched,
      hasWriter: hasWriter,
      isCached: isCached ?? Future.value(false),
      optionRating: optionRating,
    );
