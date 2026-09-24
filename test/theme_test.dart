import 'package:aniflow/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dark theme keeps the AniFlow black canvas and blue accent', () {
    final theme = aniFlowDarkTheme();

    expect(theme.colorScheme.surface, const Color(0xFF000000));
    expect(theme.colorScheme.primary, const Color(0xFF1DA2E5));
    expect(
      theme.extension<AniFlowMediaColors>()?.accent,
      const Color(0xFF1DA2E5),
    );
  });

  test('public typography uses Be Vietnam Pro', () {
    expect(aniFlowTheme().textTheme.bodyMedium?.fontFamily, 'BeVietnamPro');
  });
}
