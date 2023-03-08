part of 'whats_new_screen_manager.dart';

VersionChanges _get5_6_0({required bool isHomePageEnabled}) => VersionChanges(
      _version('5.6.0'),
      [
        if (isHomePageEnabled)
          _item(
            '🏡 ${R.strings.whatsNew.homePage}',
            desc: R.strings.whatsNew.homePageDesc,
          ),
        _item('🛠 ${R.strings.whatsNew.bugfixAndImprovements}'),
      ],
    );

VersionChanges _get5_5_4() => VersionChanges(
      _version('5.5.4'),
      [
        _item('🛠 ${R.strings.whatsNew.bugfixAndImprovements}'),
      ],
    );

VersionChanges _get5_5_0() => VersionChanges(
      _version('5.5.0'),
      [
        _item(
          '📖 ${R.strings.whatsNew.restoreLastRead}',
          desc: R.strings.whatsNew.restoreLastReadDesc,
        ),
        _item(
          '🎨💅 ${R.strings.whatsNew.uiUpdates}',
          desc: R.strings.whatsNew.uiUpdatesDesc,
        ),
        _item('🛠 ${R.strings.whatsNew.bugfixAndImprovements}'),
      ],
    );

VersionChanges _get5_4_2() => VersionChanges(
      _version('5.4.2'),
      [
        _item('🛠 ${R.strings.whatsNew.bugfixAndImprovements}'),
      ],
    );

VersionChanges _get5_4_0() => VersionChanges(
      _version('5.4.0'),
      [
        _item(
          '📢⁉️ ${R.strings.whatsNew.dynamicItem}',
          desc: R.strings.whatsNew.dynamicItemDesc,
        ),
        _item(
          '❤️🙋🏼‍♀🙋🏻️${R.strings.whatsNew.favPeople}',
          desc: R.strings.whatsNew.favPeopleDesc,
        ),
        _item(
          '🎨💅 ${R.strings.whatsNew.uiUpdates}',
          desc: R.strings.whatsNew.uiUpdatesDesc,
        ),
        _item('🛠 ${R.strings.whatsNew.bugfixAndImprovements}'),
      ],
    );

VersionChanges _get5_3_0() => VersionChanges(
      _version('5.3.1'),
      [
        _item(
          '🎵▶️ ${R.strings.whatsNew.advancedPlaylist}',
          desc: R.strings.whatsNew.advancedPlaylistDesc,
        ),
        _item(
          '🔔🎨️ ${R.strings.whatsNew.notificationArtwork}',
          desc: R.strings.whatsNew.notificationArtworkDesc,
        ),
        _item(
          '👨‍🎓📄 ${R.strings.whatsNew.userData}',
          desc: R.strings.whatsNew.userDataDesc,
        ),
        _item(
          '🔁‍ ${R.strings.whatsNew.reEnableLoopMode}',
          desc: R.strings.whatsNew.reEnableLoopModeDesc,
        ),
      ],
    );

VersionChanges _get5_2_1() => VersionChanges(
      _version('5.2.2'),
      [
        _item(
          '🤦‍ ${R.strings.whatsNew.disableLoopMode}',
          desc: R.strings.whatsNew.disableLoopModeDesc,
        ),
      ],
    );

VersionChanges _get5_2_0() => VersionChanges(
      _version('5.2.0'),
      [
        _item(
          '😍😡️ ${R.strings.whatsNew.taleRating}',
          desc: R.strings.whatsNew.taleRatingDesc,
        ),
        _item(
          '❤️️ ${R.strings.whatsNew.favTalePage}',
          desc: R.strings.whatsNew.favTalePageDesc,
        ),
        _item('🛠 ${R.strings.whatsNew.bugfixAndImprovements}'),
      ],
    );

VersionChanges _get5_1_0() => VersionChanges(
      _version('5.1.0'),
      [
        _item(
          '🔊🔁️️ ${R.strings.whatsNew.audioLoopMode}',
          desc: R.strings.whatsNew.audioLoopModeDesc,
        ),
        _item(
          '⏳ ${R.strings.whatsNew.audioCountdownTimer}',
          desc: R.strings.whatsNew.audioCountdownTimerDesc,
        ),
        _item(
          '🎉 ${R.strings.whatsNew.whatsNew}',
          desc: R.strings.whatsNew.whatsNewDesc,
        ),
        _item('🛠 ${R.strings.whatsNew.bugfixAndImprovements}'),
      ],
    );

//////

AppVersion _version(String name) => AppVersion(
      name: StringSingleLine(name),
      code: IntPositive(0),
      staging: StringSingleLine(Stagings.prod),
    );

VersionChangeItem _item(String title, {String? desc}) => VersionChangeItem(
      title: StringNonEmpty(title),
      description: desc == null ? null : StringNonEmpty(desc),
    );
