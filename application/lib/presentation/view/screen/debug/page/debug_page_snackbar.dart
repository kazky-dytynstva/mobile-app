import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/domain/navigation/snackbar_controller.dart';
import 'package:mobile_app/infrastructure/di/dependency_injection.dart';
import 'package:mobile_app/presentation/view/screen/debug/page/base_debug_page.dart';
import 'package:mobile_app/presentation/widget/button/button_secondary.dart';

class DebugPageSnackbar extends BaseDebugPage {
  const DebugPageSnackbar({Key? key}) : super(key: key);

  @override
  BaseDebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends BaseDebugPageState<DebugPageSnackbar> {
  late final SnackbarController _controller = getIt();

  @override
  List<DebugPageSection> getSections() => [
        _buildErrorSnackbar(),
        _buildUndo(),
        _buildInfo(),
      ];

  DebugPageSection _buildErrorSnackbar() {
    final list = <Widget>[
      _buildErrorMessage(),
      _buildErrorMessageAndTitle(),
      _buildNetworkError(),
      _buildCacheAudioFailedBtn(),
    ];
    return DebugPageSection(
      title: 'Error Snackbar',
      children: list,
    );
  }

  DebugPageSection _buildUndo() {
    final btn = ButtonSecondary.text(
      'undo',
      onPressed: () => _controller.showUndo(
          title: 'title (optional)',
          message: 'custom message',
          onUndoPressed: () {
            _log('undo pressed');
          }),
    );

    return DebugPageSection(
      title: 'undo snackbar',
      children: [btn],
    );
  }

  DebugPageSection _buildInfo() {
    final info = ButtonSecondary.text(
      'Show info snackbar',
      onPressed: () => _controller.showInfo(
          message: 'info message here',
          title: 'title (optional)',
          onDismiss: () => _log('info snackbar dismissed')),
    );
    final thanks = ButtonSecondary.text(
      'thanks for rating',
      onPressed: () => _controller.showThanksForRating(),
    );

    return DebugPageSection(
      title: 'Info snackbar',
      children: [info, thanks],
    );
  }

  Widget _buildNetworkError() => ButtonSecondary.text(
        'network error',
        onPressed: () => _controller.showNetworkError(),
      );

  Widget _buildCacheAudioFailedBtn() => ButtonSecondary.text(
        'cache audio failed',
        onPressed: () => _controller.showCacheAudioFailed(),
      );

  Widget _buildErrorMessage() => ButtonSecondary.text(
        'just message',
        onPressed: () => _controller.showError(message: 'Simple error'),
      );

  Widget _buildErrorMessageAndTitle() => ButtonSecondary.text(
        'message and title',
        onPressed: () => _controller.showError(
          message: 'Simple error',
          title: 'Error title',
        ),
      );

  void _log(String text) {
    if (kDebugMode) print(text);
  }
}
