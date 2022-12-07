part of '../r.dart';

class Assets {
  final Icons _icons;
  final Graphics _graphics;

  Assets._()
      : _icons = const Icons._(),
        _graphics = const Graphics._();

  Icons get icons => _icons;

  Graphics get graphics => _graphics;
}

class Graphics {
  const Graphics._();

  List<SvgAssetGraphic> getAll() => [
        allTales,
        audio,
        author,
        error,
        faceAwesome,
        faceLike,
        faceModerate,
        faceDislike,
        faceAngry,
        favorite,
        lastAdded,
        lullaby,
        national,
        poem,
        unseen,
        upset,
        wip,
      ];

  SvgAssetGraphic get allTales => const SvgAssetGraphic(name: 'all_tales');

  SvgAssetGraphic get audio => const SvgAssetGraphic(name: 'audio');

  SvgAssetGraphic get author => const SvgAssetGraphic(name: 'author');

  SvgAssetGraphic get error => const SvgAssetGraphic(name: 'error');

  SvgAssetGraphic get faceAngry => const SvgAssetGraphic(name: 'face_angry');

  SvgAssetGraphic get faceAwesome =>
      const SvgAssetGraphic(name: 'face_awesome');

  SvgAssetGraphic get faceDislike =>
      const SvgAssetGraphic(name: 'face_dislike');

  SvgAssetGraphic get faceLike => const SvgAssetGraphic(name: 'face_like');

  SvgAssetGraphic get faceModerate =>
      const SvgAssetGraphic(name: 'face_moderate');

  SvgAssetGraphic get favorite => const SvgAssetGraphic(name: 'favorite');

  SvgAssetGraphic get lastAdded => const SvgAssetGraphic(name: 'last_added');

  SvgAssetGraphic get lullaby => const SvgAssetGraphic(name: 'lullaby');

  SvgAssetGraphic get national => const SvgAssetGraphic(name: 'national');

  SvgAssetGraphic get poem => const SvgAssetGraphic(name: 'poem');

  SvgAssetGraphic get unseen => const SvgAssetGraphic(name: 'unseen');

  SvgAssetGraphic get upset => const SvgAssetGraphic(name: 'upset');

  SvgAssetGraphic get wip => const SvgAssetGraphic(name: 'wip');
}

class Icons {
  const Icons._();

  List<SvgAssetIcon> getAll() => [
        addTale,
        arrowLeft,
        arrowRight,
        arrowUp,
        audio,
        audioNext,
        audioPause,
        audioPlay,
        audioPrev,
        audioStop,
        circleCross,
        devMode,
        download,
        filter,
        flag,
        heart,
        heartSolid,
        info,
        menu,
        menuSolid,
        more,
        palette,
        random,
        repeatAll,
        repeatOff,
        repeatOne,
        report,
        save,
        search,
        settings,
        share,
        sort,
        star,
        starSolid,
        stopwatch,
        support,
        talesCrew,
        talesCrewSolid,
        talesList,
        talesListSolid,
        text,
        trash,
        writeDev,
      ];

  SvgAssetIcon get addTale => const SvgAssetIcon(name: 'add_tale');

  SvgAssetIcon get arrowLeft => const SvgAssetIcon(name: 'arrow_left');

  SvgAssetIcon get arrowRight => const SvgAssetIcon(name: 'arrow_right');

  SvgAssetIcon get arrowUp => const SvgAssetIcon(name: 'arrow_up');

  SvgAssetIcon get audio => const SvgAssetIcon(name: 'audio');

  SvgAssetIcon get audioNext => const SvgAssetIcon(name: 'audio_next');

  SvgAssetIcon get audioPause => const SvgAssetIcon(name: 'audio_pause');

  SvgAssetIcon get audioPlay => const SvgAssetIcon(name: 'audio_play');

  SvgAssetIcon get audioPrev => const SvgAssetIcon(name: 'audio_previous');

  SvgAssetIcon get audioStop => const SvgAssetIcon(name: 'audio_stop');

  SvgAssetIcon get circleCross => const SvgAssetIcon(name: 'circle_cross');

  SvgAssetIcon get devMode => const SvgAssetIcon(name: 'dev_mode');

  SvgAssetIcon get download => const SvgAssetIcon(name: 'download');

  SvgAssetIcon get filter => const SvgAssetIcon(name: 'filter');

  SvgAssetIcon get flag => const SvgAssetIcon(name: 'flag');

  SvgAssetIcon get heart => const SvgAssetIcon(name: 'heart');

  SvgAssetIcon get heartSolid => const SvgAssetIcon(name: 'heart_solid');

  SvgAssetIcon get info => const SvgAssetIcon(name: 'info');

  SvgAssetIcon get menu => const SvgAssetIcon(name: 'menu');

  SvgAssetIcon get menuSolid => const SvgAssetIcon(name: 'menu_solid');

  SvgAssetIcon get more => const SvgAssetIcon(name: 'more');

  SvgAssetIcon get palette => const SvgAssetIcon(name: 'palette');

  SvgAssetIcon get random => const SvgAssetIcon(name: 'random');

  SvgAssetIcon get repeatAll => const SvgAssetIcon(name: 'repeat_all');

  SvgAssetIcon get repeatOff => const SvgAssetIcon(name: 'repeat_off');

  SvgAssetIcon get repeatOne => const SvgAssetIcon(name: 'repeat_one');

  SvgAssetIcon get report => const SvgAssetIcon(name: 'report');

  SvgAssetIcon get save => const SvgAssetIcon(name: 'save');

  SvgAssetIcon get search => const SvgAssetIcon(name: 'search');

  SvgAssetIcon get settings => const SvgAssetIcon(name: 'settings');

  SvgAssetIcon get share => const SvgAssetIcon(name: 'share');

  SvgAssetIcon get sort => const SvgAssetIcon(name: 'sort');

  SvgAssetIcon get star => const SvgAssetIcon(name: 'star');

  SvgAssetIcon get starSolid => const SvgAssetIcon(name: 'star_solid');

  SvgAssetIcon get stopwatch => const SvgAssetIcon(name: 'stopwatch');

  SvgAssetIcon get support => const SvgAssetIcon(name: 'support');

  SvgAssetIcon get talesCrew => const SvgAssetIcon(name: 'tales_crew');

  SvgAssetIcon get talesCrewSolid =>
      const SvgAssetIcon(name: 'tales_crew_solid');

  SvgAssetIcon get talesList => const SvgAssetIcon(name: 'tales_list');

  SvgAssetIcon get talesListSolid =>
      const SvgAssetIcon(name: 'tales_list_solid');

  SvgAssetIcon get text => const SvgAssetIcon(name: 'text');

  SvgAssetIcon get trash => const SvgAssetIcon(name: 'trash');

  SvgAssetIcon get writeDev => const SvgAssetIcon(name: 'write_dev');
}
