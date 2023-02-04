class StringRes {
  late final general = _StringResGeneral();
  late final networkFailure = const _StringNetworkRequestFailure();
  late final splash = _StringResSplash(networkFailure);
  late final searchTale = _StringResSearchTale();
  late final main = _StringResMain();
  late final sortAndFilter = _StringResScreenSortAndFilter();
  late final tale = _StringResScreenTale();
  late final talesList = _StringResTalesList();
  late final settings = _StringResSettings();
  late final menuItem = _StringResMenuItem();
  late final languages = _StringLanguages();
  late final taleFilterType = _StringTaleFilterType();
  late final taleSortType = _StringTaleSortType();
  late final crewRoles = _StringResCrewRoles();
  late final dialog = _StringResDialog();
  late final email = _StringResEmail();
  late final whatsNew = _StringResWhatsNew();
  late final ratingNames = _StringResRatingNames();
}

class _StringResGeneral {
  String get authorNation => 'Народна';

  String get appName => 'Казки дитинства';

  String get oops => 'Отакої ...';

  String get retry => 'Повторити';

  String get close => 'Закрити';

  String get cancel => 'Скасувати';

  String get iItMightTakeFewSecPleaseWait =>
      '... це може зайняти кілька секунд,\nбудь ласка, зачекайте 🙏 ...';

  String get madeWithLove => 'Зроблено з ❤️\nдо України 🇺🇦';

  String get allPeople => 'Усі';

  String get shareApp =>
      'Спробуйте безкоштовний застосунок з казками в текстовому і аудіо форматах.\n\n'
      '"$appName"\n'
      '%s';

  String get updateAppBtn => 'Оновити застосунок';

  String get minutes => '%s хвилин';

  String get thankYou => 'Дякуємо 🙏';

  String get emptyList => 'Список порожній ...';

  String get emptyListFavTales => 'У Вас досі немає улюблених казок...\n'
      'Як так???\n\n'
      'Треба негайно виправляти!';

  String get emptyListFavPeople => 'У Вас досі немає улюблених творців...\n'
      'Чому???';
}

//region screen translations
class _StringResSplash {
  late final StringGetInitialContentFailed getInitialContentFailed;

  _StringResSplash(_StringNetworkRequestFailure networkRequestFailure) {
    getInitialContentFailed =
        StringGetInitialContentFailed._(networkRequestFailure);
  }

  String get initialisation => '... приготування ...';

  String get initAppFailedMsg => 'Під час ініціалізції сталась помилка...\n\n'
      'Будь ласка, перевірте наявність з\'вязку з мережею Інтернет та спробуйте ще раз 🙏';

  String getContentFailedMsg({required String reason}) =>
      'Невдалось завантажити контент з хмарного сховища: $reason';
}

class _StringResMain {
  String get pageNameHome => 'Головна';

  String get pageNameTalesList => 'Казки';

  String get pageNameCrewList => 'Творці';

  String get pageNameMenu => 'Меню';
}

class _StringResSearchTale {
  String get searchTitle => 'Пошук казок';

  String get searchHint => ' Почніть друкувати ...';

  String get searchExampleTaleName => 'Почніть вводити назку казки,\n'
      'наприклад:';

  String get searchExampleAuthorName => 'або ж імʼя автора';

  String get searchNoResults => 'Нажаль, за Вашим запитом\n'
      'ми нічого не знайшли...';
}

class _StringResScreenSortAndFilter {
  String get btnFilter => 'Фільтр';

  String get btnSort => 'Сортування';

  String get btnApply => 'Застосувати';
}

class _StringResTalesList {
  String get bringBackFavTaleMessage => 'Видалено зі списку улюблених.';

  String get bringBackFavPersonMessage => 'Видалено зі списку улюблених';
}

class _StringResScreenTale {
  String get scrollToStart => 'До початку';

  String get audioCached => 'Завантажено';

  String get thanksForRatingMsg =>
      'Ви щойно допомогли нам, та іншим батькам, отримувати кращий контент 😊';
}

class _StringResSettings {
  String get pageNameGeneral => 'Основні';

  String get pageNameText => 'Текст';

  String get pageNameAudio => 'Аудіо';

  String get sectionLabelAppTheme => 'Тема застосунку';

  String get themeNameDark => 'Темна 🌚';

  String get themeNameLight => 'Світла 🌞';

  String get themeNameSystem => 'Системна 🔧';

  String get sectionLabelAllAudio => 'Все аудіо';

  String get cachedAudioTales => 'Завантажені аудіо казки';

  String get cacheAllAudioTales => 'Завантажити всі аудіо';

  String get cachingAllAudioTales => 'Аудіо завантажується ...';

  String get fileSizeGb => 'Гб';

  String get fileSizeMb => 'Мб';

  String get canNotCacheAudioCheckNetwork =>
      'Під час завантаження аудіо сталась помилка.\n'
      'Перевірте інтернет з\'єднання та спробуйте ще раз 🙏';

  String get sectionLabelUserData => 'Користувацькі дані';

  String get crashLoggingEnabledTitle => 'Звітування про помилки';

  String get crashLoggingEnabledSubTitle =>
      'Дані для відслідковування та виправлення помилок';

  String get deleteUserDataTitle => 'Видалити дані';

  String get deleteUserDataSubTitle =>
      'Всі Ваші дані буде видалено, а їх збір - припинено';

  String get trackingEnabledTitle => 'Відслідковування поведінки';

  String get trackingEnabledSubTitle =>
      'Дані для перевірки корисності та успішності функціоналу';

  String get userDataInfo =>
      'Для того аби застосунок активно розвивався, нам потрібно збирати певні аналітичні дані.\n\n'
      'Усі дані, які збираються - АНОНІМІЗОВАНІ!\n'
      'Тобто ми знаємо про Вас - рівно НІЧОГО!\n\n'
      'Але звісно, ми даємо Вам можливість контролювати навіть ці дані та їх збір 😊️';

  String get privacyPolicyTitle => 'Політика конфіденційності';

  String get termsAndConditionsTitle => 'Умови та положення';

  String get sectionLabelTextScaleFactor => 'Розмір тексту казки';

  String get textScaleFactorTitleS => 'Маленький';

  String get textScaleFactorTitleM => 'Звичайний';

  String get textScaleFactorTitleL => 'Трошки більший';

  String get textScaleFactorTitleXL => 'Величезний';

  String get textScaleFactorExample => 'Це приклад тексту казки';
}

//endregion screen translations

//region failures
class _StringNetworkRequestFailure {
  const _StringNetworkRequestFailure();

  String get noInternet =>
      'Відсутнє (або ж дуже погане) з\'єднання з мережею Інтернет';

  String get notAuthorized => 'Застосунок не авторизований';

  String get responseParseError => 'Помилка під розшифровування даних';

  String get serverError => 'Помилка сервера';

  String get unknownError => 'Невідома помилка';
}
//endregion failures

//region others

class _StringResMenuItem {
  String get donate => 'Підтримати проєкт';

  String get addTale => 'Додати казку';

  String get writeDevelopers => 'Написати розробникам';

  String get shareApp => 'Поділитись застосунком';

  String get itemSettings => 'Налаштування';

  String get itemAppVersion => 'версія: %s';

  String get whatsNew => 'Що нового?';
}

class _StringTaleFilterType {
  String get all => 'Усі';

  String get unwatched => 'Непроглянуті';

  String get national => 'Народні';

  String get author => 'Авторські';

  String get audio => 'Аудіо';

  String get lullaby => 'Колискові';

  String get poem => 'Вірші';

  String get lastAdded => 'Останні додані';

  String get favorite => 'Улюблені';

  String get hidden => 'Приховані';
}

class _StringTaleSortType {
  String get random => 'Випадково';

  String get byName => 'За назвою';

  String get byAuthor => 'За автором';

  String get byRating => 'За рейтингом';

  String get byRatingAmount => 'За кількістю оцінок';
}

class _StringLanguages {
  String get english => 'Англійська';

  String get ukrainian => 'Українська';
}

class _StringResDialog {
  String get wipTitle => 'Вибачайте, проте ...';

  String get wipMsg => '... проте ця функція ще не готова.\n'
      'Покищо вона знаходиться в стадії розробки ...';

  String get taleMoreBtnHide => 'Приховати казку';

  String get taleMoreBtnReport => 'Проблема з казкою?';

  String get taleMoreBtnSettings => 'Налаштування';

  String get confirmDeleteAllAudioPos => 'Так, видалити';

  String get confirmDeleteAllAudioTitle =>
      'Ви дійсно бажаєте видалити всі завантажені аудіо казки?';

  String get switchToWiFiMsg => 'У Вас увімкнений мобільний інтернет,\n'
      'тобто завантаження аудіоказок займе багато часу і буде використано багато інтернет трафіку!'
      '\n\n'
      'Невеличка порада:\n'
      '- підключіться до мережі WiFi\n'
      '- повторіть завантаження\n'
      '\n\n'
      'Це буде і швидше і дешевше 🙏\n'
      'Але вирішувати звісно Вам!';

  String get switchToWiFiNeg => 'Продовжити';

  String get switchToWiFiPos => 'Скасувати';

  String get switchToWiFiTitle => 'Увага !!!';

  String get randomTaleTitle => 'Випадкова казка';

  String get randomTaleNext => 'Наступна';

  String get reportTaleTitle => 'Щось не так з казкою?';

  String get reportTaleMsg => 'Знайшли помилку?\n'
      'Чи можливо є якісь інші проблеми з цим твором?\n\n'
      'Будь ласка, опишіть проблему максимально детально (можливо додайте скріншот) 🙏';

  String get reportTalePos => 'Надіслати звіт';

  String get audioCountdownTitleActive => 'Аудіо зупиниться через';

  String get audioCountdownTitleInActive => 'Автоматично зупинити аудіо через';

  String get ratingExplanationsTitle => 'Система оцінки казок';

  String get ratingExplanationsMsg =>
      'Кожен користувач може оцінити будь-який твір.\nДалі ми сумуємо оцінки, округляємо та на їх основі показуємо вам "рейтинг" казки у форматі смайликів.\nЯкщо ж Ви бачите твір без смайлика - це означає, що в нього поки недостатньо оцінок.\n\nДолучайтесь та залишайте Ваші оцінки творам 🙏';

  String get taleRatingMsg => '%s+ людей саме так і оцінили\nтвір "%s"';

  String get taleRatingBtnPos => 'Як це працює?';

  String get confirmTaleRatingMessage =>
      'Будь ласка, підтвердіть Ваш намір оцінити цей твір.';

  String get confirmTaleRatingPos => 'Оцінити';

  String get confirmDeleteUserDataTitle =>
      'Ви дійсно бажаєте видалити всі дані?';

  String get confirmDeleteUserDataMsg => 'Всі Ваші дані - АНОНІМІЗОВАНО!\n'
      'Ми про Вас знаємо - рівно НІЧОГО.\n\n'
      'Дані, які ми збираємо, допомагають нам робити застосунок кращим і стабільнішим...\n\n'
      'Проте, вибір звісно за Вами 😉\n\n'
      'Разом з видаленням даних автоматично буде скасований будь який збір нових даних.';

  String get confirmDeleteUserDataPos => 'Так, видалити';
}

class _StringResCrewRoles {
  String get authors => 'Автори 🖋️';

  String get author => 'Автор 🖋️';

  String get readers => 'Читці 🎤';

  String get reader => 'Читець 🎤';

  String get translators => 'Перекладачі 📚';

  String get translator => 'Перекладач 📚';

  String get musicians => 'Музики 🎷';

  String get musician => 'Музика 🎷';

  String get graphics => 'Художники 🎨';

  String get graphic => 'Художник 🎨';

  String get taleCrewForTale => 'Казкова команда казки';
}

class _StringResEmail {
  String get writeDevSubject => ' (Повідомлення розробникам)';

  String get writeDevBodyDraft => '// Будь ласка, опишіть ваше:\n'
      '//    - питання\n'
      '//    - пропозицію\n'
      '//    - повідомлення про помилку\n\n'
      '// (чим детальніше, тим краще 🙏)';

  String get addTaleSubject => ' (Додати казку)';

  String get addTaleBodyDraft => '// Будь ласка, опишіть:\n'
      '//    - автора\n'
      '//    - текст казки\n'
      '//    - картинку\n'
      '//    - посилання на казку\n\n'
      '// (чим детальніше, тим краще 🙏)';

  String get reportTale => ' (Проблема з казкою)';

  String get reportTaleDraft => '// id: %s\n'
      '// Будь ласка опишіть проблему під цими рядками 🙏';
}

class _StringResWhatsNew {
  String get bugfixAndImprovements => 'Виправили дрібні помилки';

  String get audioCountdownTimer => 'Автоматична зупинка аудіо';

  String get audioCountdownTimerDesc =>
      'Додали можливість обирати час, через який має зупинитись програвання аудіо';

  String get audioLoopMode => 'Функція повтору аудіо';

  String get audioLoopModeDesc =>
      'Програвати аудіо тепер можна в режимі "без повтору", "повторювати усі" та "повторювати одну"';

  String get whatsNew => 'Екран "Що нового?"';

  String get whatsNewDesc =>
      'Тепер буде ще простіше відслідковувати зміни в застосунку';

  String get taleRating => 'Оцінки для казок';

  String get taleRatingDesc =>
      'Ми відновили (і спростили) систему оцінок для казок.\n'
      'Тепер це принцип світлофора. Зелений - неймовірна казка, люди в захваті. Червоний - погана казка, біда-бідоля (але таких казок в нас нема 😊).';

  String get favTalePage => 'Улюблені казки';

  String get favTalePageDesc =>
      'Тепер розділ з улюбленими творами ще ближче до Вас та Ваших малюків 😉';

  String get disableLoopMode => 'Тимчасово вимкнена функція повтору аудіо';

  String get disableLoopModeDesc =>
      'Ми помітили критичну помилку в цій функції і вирішили тимчасово її вимкнути, аби не створювати неприємний досвід...\nСкоро все повернемо!\nПросимо вибачення за незручності!';

  String get advancedPlaylist => 'Покращений аудіо-плейлист';

  String get advancedPlaylistDesc =>
      'Тепер відкриваючи аудіо-казку, Ви створюєте плейлист з казок за вашим фільтром та сортуванням: усі, улюблені, колискові і тд';

  String get notificationArtwork => 'Зображення в панелі сповіщень';

  String get notificationArtworkDesc =>
      'Всі казки мають картинку. Ця картинка буде і в панелі сповіщень під час програвання аудіо.';

  String get reEnableLoopMode => 'Повторне програвання';

  String get reEnableLoopModeDesc =>
      'Знову доступне. І працює без проблем. Наче 😂';

  String get userData => 'Користувацькі дані';

  String get userDataDesc =>
      'В налаштуваннях Ви маєте можливість контролювати дані, які збирає застосунок. Також там присутні пояснення як ці дані нами використовуються.';

  String get favPeople => 'Улюблені творці';

  String get favPeopleDesc =>
      'Розділ "Улюблені" на головному екрані тепер містить не лише казки, а ще й творців, яких Ви вподобали.';

  String get dynamicItem => 'Соц опитування';

  String get dynamicItemDesc =>
      'В меню, що на головному екрані, Вам може бути доступний новий розділ із опитуванням.\nБудь ласка, прийміть в ньому участь, це важливо.\nДякуємо 🙏🏼';

  String get uiUpdates => 'Користувацький інтерфейс';

  String get uiUpdatesDesc =>
      'Ми внесли певні зміни в користувацький інтерфейс. Все для того, аби ваш досвід користування був ще приємнішим ☺️';

  String get restoreLastRead => 'Закладки';

  String get restoreLastReadDesc =>
      'Продовжуйте читати казки з того місця, де Ви зупинились минулого разу.';
}

class _StringResRatingNames {
  String get awesome => 'Неймовірно';

  String get like => 'Подобається';

  String get moderate => 'Середнячок';

  String get dislike => 'Не подобається';

  String get terrible => 'Жахливо';
}

class StringGetInitialContentFailed {
  final _StringNetworkRequestFailure _networkRequestFailure;

  StringGetInitialContentFailed._(this._networkRequestFailure);

  String get noInternet => _networkRequestFailure.noInternet;

  String get parsingError => _networkRequestFailure.responseParseError;

  String get serverError => _networkRequestFailure.serverError;

  String get unknownError => _networkRequestFailure.unknownError;
}
//endregion others
