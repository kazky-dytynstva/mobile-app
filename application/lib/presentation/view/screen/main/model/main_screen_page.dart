enum MainScreenPage {
  home,
  tales,
  fav,
  people,
  menu,
}

extension MainScreenPageX on MainScreenPage {
  bool get isMenu => this == MainScreenPage.menu;

  T map<T>({
    required T Function() home,
    required T Function() tales,
    required T Function() fav,
    required T Function() people,
    required T Function() menu,
  }) {
    switch (this) {
      case MainScreenPage.home:
        return home();
      case MainScreenPage.tales:
        return tales();
      case MainScreenPage.fav:
        return fav();
      case MainScreenPage.people:
        return people();
      case MainScreenPage.menu:
        return menu();
    }
  }
}
