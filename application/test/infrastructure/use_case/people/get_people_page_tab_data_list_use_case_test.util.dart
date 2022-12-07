part of 'get_people_page_tab_data_list_use_case_test.dart';

// Person createPerson({
//   required int id,
// }) =>
//     Person(
//       PersonId(id),
//       PersonName('name$id'),
//       ImageUrl('imageUrl'),
//       const None(),
//       const None(),
//       false,
//     );

Map<TaleCrewRole, Set<Person>> getIncrementalPersonByRoleForAllRoles() {
  var i = 0;
  final map = <TaleCrewRole, Set<Person>>{};
  Set<Person> getSet(TaleCrewRole role) => map.putIfAbsent(role, () => {});
  for (var role in TaleCrewRole.values) {
    final set = getSet(role);
    set.add(getPerson(id: i++));
    set.add(getPerson(id: i++));
  }
  return map;
}

List<List<Person>> getExpectedPersonList() {
  final all = [
    getPerson(id: 0),
    getPerson(id: 1),
    getPerson(id: 2),
    getPerson(id: 3),
    getPerson(id: 4),
    getPerson(id: 5),
    getPerson(id: 6),
    getPerson(id: 7),
    getPerson(id: 8),
    getPerson(id: 9),
  ];
  final list = [
    all,
    [all[0], all[1]],
    [all[2], all[3]],
    [all[4], all[5]],
    [all[6], all[7]],
    [all[8], all[9]],
  ];

  return list;
}
