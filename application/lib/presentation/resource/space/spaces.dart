part of '../r.dart';

class Spaces {
  final Dimen _dimen;

  Spaces._(
    this._dimen,
  );

  Widget get expanded => const Spacer();

  Widget get empty => const SizedBox();

  // region horizontal
  Widget get horizontalUnit0_5 => SizedBox(width: _dimen.unit0_5);

  Widget get horizontalUnit => SizedBox(width: _dimen.unit);

  Widget get horizontalUnit2 => SizedBox(width: _dimen.unit2);

  Widget get horizontalUnit3 => SizedBox(width: _dimen.unit3);

  // endregion horizontal

  // region vertical
  Widget get verticalUnit0_5 => SizedBox(height: _dimen.unit0_5);

  Widget get verticalUnit => SizedBox(height: _dimen.unit);

  Widget get verticalUnit2 => SizedBox(height: _dimen.unit2);

  Widget get verticalUnit3 => SizedBox(height: _dimen.unit3);

  Widget get verticalUnit4 => SizedBox(height: _dimen.unit4);

  // endregion vertical

  Widget get verticalTopNotch => SizedBox(height: _dimen.notchHeight);

  Widget get verticalBottomNotch => SizedBox(height: _dimen.bottomNotchHeight);
}
