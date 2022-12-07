import 'package:flutter/material.dart';
import 'package:mobile_app/domain/model/person/person.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/button/button_secondary.dart';
import 'package:mobile_app/presentation/widget/favorite.dart';
import 'package:mobile_app/presentation/widget/person_avatar.dart';

class PersonListItem extends StatelessWidget {
  final Person person;
  final VoidCallback onPressed;
  final VoidCallback onFavPressed;

  const PersonListItem({
    required this.person,
    required this.onPressed,
    required this.onFavPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PersonAvatar.squared(photoUrl: person.photoUrl),
        R.spaces.horizontalUnit2,
        _buildNameAndInfo(),
        _buildFavWidget(),
      ],
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: R.dimen.screenPaddingSide,
        vertical: R.dimen.unit0_5,
      ),
      child: ButtonSecondary(
        onPressed: onPressed,
        fixedMaxHeight: false,
        bgColor: R.palette.transparent,
        outlineColor: R.palette.divider,
        contentPadding: EdgeInsets.all(R.dimen.unit0_5),
        child: row,
      ),
    );
  }

  Widget _buildNameAndInfo() {
    final name = Text(
      person.name.get(),
      style: R.styles.textSubTitle,
    );
    final info = person.infoOption.fold(
        () => R.spaces.empty,
        (a) => Text(
              a.get(),
              style: R.styles.textCaption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ));

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        name,
        R.spaces.verticalUnit2,
        info,
      ],
    );
    return Expanded(child: column);
  }

  Widget _buildFavWidget() => Favorite(
        onPressed: onFavPressed,
        isFav: person.isFavorite,
        asFab: false,
      );
}
