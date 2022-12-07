import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/helper/share_helper.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:share_plus/share_plus.dart';

@LazySingleton(as: ShareHelper)
class ShareHelperImpl implements ShareHelper {
  @override
  Future<void> text({
    required StringNonEmpty text,
  }) async {
    await Share.share(
      text.get(),
      sharePositionOrigin: const Rect.fromLTWH(0, 0, 100, 100),
    );
  }
}
