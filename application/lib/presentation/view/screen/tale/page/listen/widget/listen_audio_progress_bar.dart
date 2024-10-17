import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/resource/r.dart';
import 'package:mobile_app/presentation/widget/fade_animated_switcher.dart';
import 'package:mobile_app/presentation/widget/svg_widget.dart';

typedef OnPositionChanged = Function(Duration position);

class ListenAudioProgressBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Future<bool> isCached;
  final OnPositionChanged onPositionChanged;

  const ListenAudioProgressBar({
    super.key,
    required this.duration,
    required this.position,
    required this.isCached,
    required this.onPositionChanged,
  });

  @override
  State<ListenAudioProgressBar> createState() => _ListenAudioProgressBarState();
}

class _ListenAudioProgressBarState extends State<ListenAudioProgressBar> {
  Duration _currentValue = const Duration();
  bool _sliderTouched = false;

  double get _durationPadding => R.dimen.unit1_5;

  @override
  void didUpdateWidget(ListenAudioProgressBar oldWidget) {
    if (!_sliderTouched) {
      _currentValue = widget.position;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      _createPosition(),
      _createCached(),
      _createDuration(),
    ];
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
    final column = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        row,
        _createSlider(context),
      ],
    );
    final padding = R.device.isMobile ? 0.0 : R.dimen.screenPaddingSide;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: column,
    );
  }

  Widget _createSlider(BuildContext context) {
    final slider = Slider(
      value: _currentValue.inSeconds.toDouble(),
      min: 0,
      max: widget.duration.inSeconds.toDouble(),
      onChanged: _onSliderChanged,
      onChangeStart: _onSliderChangeStarted,
      onChangeEnd: _onSliderChangeEnded,
      activeColor: R.palette.accent,
      inactiveColor: R.palette.highlightColor,
    );
    return slider;
  }

  Widget _buildText(
    String text,
    TextAlign align, {
    bool secondary = false,
  }) =>
      Text(
        text,
        style: secondary ? R.styles.textBodySecondary : R.styles.textBody,
        textAlign: align,
      );

  Widget _buildTime(String time, TextAlign align) => SizedBox(
      width: R.dimen.taleAudioTimeWidth, child: _buildText(time, align));

  Widget _createPosition() {
    final positionText = _convertDurationToString(_currentValue);
    final text = _buildTime(positionText, TextAlign.start);
    return Padding(
      padding: EdgeInsets.only(left: _durationPadding),
      child: text,
    );
  }

  Widget _createDuration() {
    final durationText = _convertDurationToString(widget.duration);
    final text = _buildTime(durationText, TextAlign.end);
    return Padding(
      padding: EdgeInsets.only(right: _durationPadding),
      child: text,
    );
  }

  void _onSliderChanged(double newValue) {
    setState(() {
      _currentValue = Duration(seconds: newValue.abs().toInt());
    });
  }

  void _onSliderChangeStarted(double newValue) {
    _sliderTouched = true;
  }

  void _onSliderChangeEnded(double newValue) {
    _sliderTouched = false;
    final position = Duration(seconds: newValue.abs().toInt());
    widget.onPositionChanged(position);
  }

  String _convertDurationToString(Duration duration) {
    String twoDigits(num n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    final String min = twoDigits(duration.inMinutes.remainder(60));
    final String sec = twoDigits(duration.inSeconds.remainder(60));
    return "$min : $sec";
  }

  Widget _createCached() {
    Widget buildRow() => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgWidget.icon(R.assets.icons.save, height: R.dimen.unit1_5),
            R.spaces.horizontalUnit,
            _buildText(
              R.strings.tale.audioCached,
              TextAlign.center,
              secondary: true,
            ),
          ],
        );
    return FutureBuilder<bool>(
      future: widget.isCached,
      builder: (_, snapshot) {
        final result = snapshot.data == true ? buildRow() : R.spaces.empty;
        return FadeAnimatedSwitcher.short(child: result);
      },
    );
  }
}
