import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/tale_tag/tale_tag.dart';
import 'package:mobile_app/domain/model/tale_crew/tale_crew.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

import 'tale_audio.dart';
import 'tale_text_item.dart';
import 'value_object/tale_id.dart';
import 'value_object/tale_name.dart';

@immutable
class Tale {
  final TaleId id;
  final TaleName name;
  final bool isFavorite;
  final bool isHidden;
  final bool isRated;
  final List<TaleTag> tags;
  final List<TaleChapter> chapters;
  final Option<TaleCrew> crewOption;
  final Option<RatingData> ratingOption;

  final int lastReadChapter;
  final int lastReadPosition;

  const Tale({
    required this.id,
    required this.name,
    required this.chapters,
    required this.tags,
    required this.crewOption,
    required this.isFavorite,
    required this.isHidden,
    required this.isRated,
    required this.lastReadChapter,
    required this.lastReadPosition,
    required this.ratingOption,
  })  : assert(lastReadPosition >= 0 && lastReadChapter >= 0),
        assert(tags.length > 0),
        assert(chapters.length > 0);

  bool get hasText => tags.contains(TaleTag.text);

  bool get hasAudio => tags.contains(TaleTag.audio);

  bool get isMultiChapter => chapters.length > 1;
}

@immutable
class TaleChapter {
  final IntPositive index;
  final Option<StringSingleLine> titleOption;
  final Option<List<TaleTextItem>> textOption;
  final Option<TaleAudio> audioOption;

  const TaleChapter(
    this.index,
    this.titleOption,
    this.textOption,
    this.audioOption,
  );

  Iterable<TaleTextItem> get text =>
      (textOption as Some<Iterable<TaleTextItem>>).value;

  TaleAudio get audio => (audioOption as Some<TaleAudio>).value;
}
