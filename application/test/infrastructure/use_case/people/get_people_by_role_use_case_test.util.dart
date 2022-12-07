part of 'get_people_by_role_use_case_test.dart';

const maxPersonIdCount = 10;
const unknownPersonId0 = 666;
const unknownPersonId1 = 777;

void setupPeopleRepositoryWhenMocking(
  MockPeopleRepository repository, [
  size = maxPersonIdCount,
]) {
  for (int i = 0; i < size; i++) {
    when(() => repository.find(PersonId(i))).thenReturn(Some(getPerson(id: i)));
  }
  when(() => repository.find(PersonId(unknownPersonId0))).thenReturn(
    const None(),
  );
  when(() => repository.find(PersonId(unknownPersonId1))).thenReturn(
    const None(),
  );
}

Map<TaleCrewRole, Set<int>> getIncrementalPersonIdByRoleForAllRoles() {
  var i = 0;
  final map = <TaleCrewRole, Set<int>>{};
  Set<int> getSet(TaleCrewRole role) => map.putIfAbsent(role, () => {});
  for (var role in TaleCrewRole.values) {
    final set = getSet(role);
    set.add(i++);
    set.add(i++);
  }
  return map;
}

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
