import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

class LanguagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);

    return Container();
  }
}
