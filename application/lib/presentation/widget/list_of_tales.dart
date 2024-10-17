import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/tale/data/tales_page_item_data.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/presentation/widget/empty_list_view.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/tales_list_item.dart';

typedef OnTalePressed = Function(TalesPageItemData);

class ListOfTales extends StatelessWidget {
  final List<TalesPageItemData> tales;
  final OnTalePressed onTalePressed;
  final OnTalePressed onTaleFavPressed;
  final OnRatingPressed onRatingPressed;
  final EdgeInsets? padding;
  final ScrollController? scrollController;
  final Option<StringSingleLine> searchPhraseOption;
  final bool isFavList;

  const ListOfTales({
    required this.tales,
    required this.onTalePressed,
    required this.onTaleFavPressed,
    required this.onRatingPressed,
    this.scrollController,
    this.padding,
    this.searchPhraseOption = const None(),
    this.isFavList = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final child = tales.isEmpty
        ? searchPhraseOption.isSome()
            ? const EmptyListView.search()
            : EmptyListView.filter(isFavTales: isFavList)
        : ListView.builder(
            controller: scrollController,
            itemBuilder: (_, int index) {
              final item = tales[index];
              return TalesListItem(
                data: item,
                searchPhraseOption: searchPhraseOption,
                onTalePressed: () => onTalePressed(item),
                onFavPressed: () => onTaleFavPressed(item),
                onRatingPressed: onRatingPressed,
              );
            },
            itemCount: tales.length,
            padding: padding ?? EdgeInsets.zero,
          );
    return FadeAnimatedSwitcher.middle(child: child);
  }
}
