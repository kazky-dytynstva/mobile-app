enum HomePageType {
  tales,
  fav,
  people,
  menu,
}

extension HomePageTypeX on HomePageType {
  bool get isMenu => this == HomePageType.menu;

  T map<T>({
    required T Function() tales,
    required T Function() fav,
    required T Function() people,
    required T Function() menu,
  }) {
    switch (this) {
      case HomePageType.tales:
        return tales();
      case HomePageType.fav:
        return fav();
      case HomePageType.people:
        return people();
      case HomePageType.menu:
        return menu();
    }
  }
}
