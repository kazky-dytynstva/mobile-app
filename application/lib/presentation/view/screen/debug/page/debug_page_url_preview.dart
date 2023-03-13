import 'package:flutter/foundation.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/data/di/dependency_injection.dart';
import 'package:mobile_app/presentation/navigation/dialog/dialog_controller.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/base_debug_page.dart';
import 'package:mobile_app/presentation/widget/url_preview.dart';

class DebugPageUrlPreview extends BaseDebugPage {
  const DebugPageUrlPreview({Key? key}) : super(key: key);

  @override
  BaseDebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends BaseDebugPageState<DebugPageUrlPreview> {
  final listOfUrls = [
    UrlString('https://pub.dev/packages/flutter_link_previewer/example'),
    UrlString('https://en.wikipedia.org/wiki/Lesya_Ukrainka'),
    UrlString('https://uk.wikipedia.org/wiki/Григорук_Анатолій_Іванович'),
  ];

  @override
  List<DebugPageSection> getSections() => [
        _buildBaseStyles(),
      ];

  DebugPageSection _buildBaseStyles() {
    final list = listOfUrls.map(_buildPreview).toList().withBottomPadding;
    return DebugPageSection(
      title: 'preview',
      children: list,
    );
  }

  UrlPreview _buildPreview(UrlString url) => UrlPreview(
        url: url,
        onPressed: getIt<DialogController>().showWIP,
      );
}
