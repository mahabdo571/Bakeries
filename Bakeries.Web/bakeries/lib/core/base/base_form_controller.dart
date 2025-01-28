import 'package:flutter/material.dart';
import 'dart:async';

abstract class BaseFormController {
  final formKey = GlobalKey<FormState>();
  Timer? _debounceTimer;

  void debounce(VoidCallback callback) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), callback);
  }

  void dispose() {
    _debounceTimer?.cancel();
  }
}
