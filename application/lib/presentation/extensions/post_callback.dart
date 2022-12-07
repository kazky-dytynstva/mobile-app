import 'package:flutter/material.dart';

void postFrame(Function action) => WidgetsBinding.instance.addPostFrameCallback(
      (_) => action(),
    );
