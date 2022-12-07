import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/widget/loading_bar.dart';

mixin ManagerViewMixin<T extends StatefulWidget> on State<T> {
  Widget buildInitialState(_) => const Center(
        child: LoadingBar(),
      );
}
