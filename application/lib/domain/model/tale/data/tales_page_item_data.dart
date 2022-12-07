import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/rating/rating_data.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_name.dart';
import 'package:mobile_app/domain/model/tale_tag/tale_tag.dart';
import 'package:mobile_app/domain/value_objects/image_url.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

@immutable
class TalesPageItemData extends Equatable {
  final TaleId id;
  final TaleName name;
  final DateTime createDate;
  final DateTime updatedDate;
  final StringSingleLine provider;
  final ImageUrl imageUrl;
  final Iterable<TaleTag> tags;
  final bool isFav;
  final bool isHidden;
  final bool isWatched;
  final bool hasWriter;
  final Future<bool> isCached;
  final Option<RatingData> optionRating;

  const TalesPageItemData({
    required this.id,
    required this.name,
    required this.createDate,
    required this.updatedDate,
    required this.provider,
    required this.imageUrl,
    required this.tags,
    required this.isFav,
    required this.isHidden,
    required this.isWatched,
    required this.hasWriter,
    required this.isCached,
    required this.optionRating,
  }) : assert(tags.length > 0);

  bool get hasText => tags.contains(TaleTag.text);

  bool get hasAudio => tags.contains(TaleTag.audio);

  @override
  List<Object?> get props => [
        id,
        name,
        createDate,
        updatedDate,
        provider,
        imageUrl,
        tags,
        isFav,
        isHidden,
        isWatched,
        hasWriter,
        optionRating,
      ];
}
