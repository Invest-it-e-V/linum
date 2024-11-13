import 'dart:math';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linum/features/currencies/core/utils/currency_formatter.dart';
import 'package:linum/features/currencies/settings/presentation/currency_settings_service.dart';
import 'package:linum/generated/translation_keys.g.dart';
import 'package:linum/screens/budget_screen/pages/budget_view_screen/utils/budget_colors.dart';
import 'package:provider/provider.dart';

class GradientInfo {
  final List<double> stops;
  final List<ui.Color> colors;

  GradientInfo({required this.stops, required this.colors});
}

class RadialProgressPainter extends CustomPainter {
  final Color? progressColor;
  final GradientInfo? progressGradientInfo;
  final startAngle = 4 / 5 * pi;
  final maxSweepAngle = 7 / 5 * pi;
  final TextStyle? labelStyle;
  final double progress; // 0.0 -> 1.0
  final String labelLeft;
  final String labelRight;
  final String center;
  final TextStyle? centerStyle;
  final String centerSub;
  final TextStyle? centerSubStyle;
  final String? progressLabel;

  RadialProgressPainter({
    this.progressColor,
    this.progressGradientInfo,
    required this.progress,
    this.progressLabel,
    required this.labelStyle,
    required this.labelLeft,
    required this.labelRight,
    required this.center,
    required this.centerStyle,
    required this.centerSub,
    required this.centerSubStyle,
  }) : assert(progressColor != null || progressGradientInfo != null);

  Paint _createBasePaint() {
    return Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
  }

  double _calculateProgressSweepAngle() {
    final angle = maxSweepAngle * progress;
    if (angle > maxSweepAngle) {
      return maxSweepAngle;
    }
    return angle;
  }

  ui.Paragraph _buildParagraph(
    Size size,
    String content,
    TextAlign align,
    TextStyle? style, {
    ui.TextDirection? direction = ui.TextDirection.ltr,
  }) {
    final paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontSize: style?.fontSize,
        fontFamily: style?.fontFamily,
        fontStyle: style?.fontStyle,
        fontWeight: style?.fontWeight,
        textAlign: align,
        textDirection: direction,
      ),
    );
    if (style != null) {
      paragraphBuilder.pushStyle(style.getTextStyle());
    }

    paragraphBuilder.addText(content);
    return paragraphBuilder.build();
  }

  ui.Paragraph _buildLabelParagraph(
      Size size, String content, TextAlign align,) {
    final paragraph = _buildParagraph(size, content, align, labelStyle);

    paragraph.layout(ui.ParagraphConstraints(width: size.width / 2));

    return paragraph;
  }

  ui.Paragraph _buildCenterParagraph(Size size, String content) {
    final paragraph =
        _buildParagraph(size, content, TextAlign.center, centerStyle);

    paragraph.layout(ui.ParagraphConstraints(width: size.width));

    return paragraph;
  }

  Size _calculateTextSize(
    String text,
    TextStyle? style, {
    ui.TextDirection? direction = ui.TextDirection.ltr,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: direction,
    )..layout();
    return textPainter.size;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final boundingRect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final diagonal = size.width;
    final radius = size.width / 2;

    final backgroundPaint = _createBasePaint()..color = Colors.black12;

    // TODO: add gradient

    const paragraphMarginTop = 8.0;

    final progressSweepAngle = _calculateProgressSweepAngle();
    final progressPaint = _createBasePaint();

    if (progressColor != null) {
      progressPaint.color = progressColor!;
    }

    if (progressGradientInfo != null) {
      progressPaint.shader = SweepGradient(
        startAngle: startAngle,
        endAngle: maxSweepAngle,
        colors: progressGradientInfo!.colors,
        stops: progressGradientInfo!.stops,
        transform: const GradientRotation(pi / 2),
      ).createShader(boundingRect);
    }

    canvas.drawArc(
        boundingRect, startAngle, maxSweepAngle, false, backgroundPaint,);
    canvas.drawArc(
        boundingRect, startAngle, progressSweepAngle, false, progressPaint,);
    canvas.drawParagraph(
      _buildLabelParagraph(size, labelLeft, TextAlign.start),
      Offset(0, 4 / 5 * diagonal + paragraphMarginTop),
    );
    canvas.drawParagraph(
      _buildLabelParagraph(size, labelRight, TextAlign.end),
      Offset(radius, 4 / 5 * diagonal + paragraphMarginTop),
    );
    canvas.drawParagraph(
      _buildCenterParagraph(size, center),
      Offset(0.0, radius - _calculateTextSize(center, centerStyle).height / 2),
    );

    if (progressLabel != null) {
      // TODO: This is not ready set, but will probably be removed anyways
      final r = radius + 6.0;
      final labelSize = _calculateTextSize(progressLabel!, labelStyle,
          direction: ui.TextDirection.rtl,);
      canvas.drawParagraph(
        _buildParagraph(size, progressLabel!, TextAlign.end, labelStyle,
            direction: ui.TextDirection.rtl,)
          ..layout(ui.ParagraphConstraints(width: labelSize.width)),
        Offset(r + r * cos(progressSweepAngle + startAngle) - labelSize.width,
            r + r * sin(progressSweepAngle + startAngle) - labelSize.height,),
      );
    }

    canvas.drawParagraph(
      _buildParagraph(
          size, centerSub.toUpperCase(), TextAlign.center, centerSubStyle,)
        ..layout(ui.ParagraphConstraints(width: diagonal)),
      Offset(
        0.0,
        radius + _calculateTextSize(center, centerStyle).height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

typedef MainBudgetChartData = ({
  double maxBudget,
  double currentExpenses,
  bool isGenerated
});

class MainBudgetChart extends StatelessWidget {
  final MainBudgetChartData data;

  const MainBudgetChart({super.key, required this.data});
  // TODO: add support for percentages

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter = CurrencyFormatter(
      context.locale,
      symbol: context
          .watch<ICurrencySettingsService>()
          .getStandardCurrency()
          .symbol,
    );
    final remaining = data.maxBudget - data.currentExpenses;
    final value = data.currentExpenses /
        (data.maxBudget == 0 ? 1 : data.maxBudget);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxWidth,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: CustomPaint(
              painter: RadialProgressPainter(
                progressColor: theme.primaryColor,
                progressGradientInfo: GradientInfo(
                  colors: [
                    getBudgetProgressColorState(theme, value),
                  ],
                  stops: [
                    1.0,
                  ],
                ),
                progress: data.currentExpenses / data.maxBudget,
                labelStyle:
                    theme.textTheme.labelMedium?.copyWith(color: Colors.black),
                labelRight: formatter.format(data.maxBudget),
                labelLeft: formatter.format(0.0),
                centerStyle: theme.textTheme.headlineLarge
                    ?.copyWith(color: Colors.black),
                center: formatter.format(remaining),
                centerSub: remaining < 0
                    ? tr(translationKeys.budgetScreen.common.labelExceeded)
                    : tr(translationKeys.budgetScreen.common.labelRemaining),
                centerSubStyle:
                    theme.textTheme.labelMedium?.copyWith(color: Colors.black),
              ),
              size: Size(
                  constraints.maxWidth * 2 / 3, constraints.maxWidth * 2 / 3,),
            ),
          ),
        );
      },
    );
  }
}
