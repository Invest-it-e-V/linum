import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linum/core/categories/models/category.dart';
import 'package:linum/core/repeating/enums/repeat_interval.dart';
import 'package:linum/screens/enter_screen/models/enter_screen_input.dart';
import 'package:linum/screens/enter_screen/models/suggestion.dart';
import 'package:linum/screens/enter_screen/models/suggestion_filters.dart';
import 'package:linum/screens/enter_screen/utils/example_string_builder.dart';
import 'package:linum/screens/enter_screen/utils/input_parser.dart';
import 'package:linum/screens/enter_screen/utils/suggestions/make_suggestions.dart';

const exampleStringStyle = TextStyle(
  fontSize: 16,
  color: Colors.black26,
);

class EnterScreenTextEditingController extends TextEditingController {
  final ExampleStringBuilder exampleStringBuilder;

  final SuggestionFilters? suggestionFilters;

  EnterScreenTextEditingController({
    super.text,
    required this.exampleStringBuilder,
    this.suggestionFilters,
  });

  /// This property can be set from a listener added to this
  /// [TextEditingController]; however, one should not also set [selection]
  /// in a separate statement. To change both the [text] and the [selection]
  /// change the controller's [value].
  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: const TextSelection.collapsed(offset: -1),
      composing: TextRange.empty,
    );

  }

  Map<String, Suggestion> _suggestions = {};
  Map<String, Suggestion> get suggestions => _suggestions;

  EnterScreenInput? _parsed;
  EnterScreenInput? get parsed => _parsed;

  void _onChange(String text, int cursor) {
    final parsed  = parse(text);
    exampleStringBuilder.rebuild(parsed);
    _parsed = parsed;
    _suggestions = makeSuggestions(
      text,
      cursor, // Cursor position
      categoryFilter: suggestionFilters?.categoryFilter,
      repeatFilter: suggestionFilters?.repeatFilter,
      dateFilter: suggestionFilters?.dateFilter,
    );
  }


  @override
  set value(TextEditingValue newValue) {
    assert(
    !newValue.composing.isValid || newValue.isComposingRangeValid,
    'New TextEditingValue $newValue has an invalid non-empty composing range '
        '${newValue.composing}. It is recommended to use a valid composing range, '
        'even for readonly text fields',
    );
    if (value.text != newValue.text) {
      _onChange(newValue.text, newValue.selection.base.offset);
    }
    super.value = newValue;
  }

  /// If the new selection is of non-zero length, or is outside the composing
  /// range, the composing range is cleared.
  @override
  set selection(TextSelection newSelection) {
    if (!isSelectionWithinTextBounds(newSelection)) {
      throw FlutterError('invalid text selection: $newSelection');
    }
    final TextRange newComposing =
    newSelection.isCollapsed && _isSelectionWithinComposingRange(newSelection)
        ? value.composing
        : TextRange.empty;
    value = value.copyWith(selection: newSelection, composing: newComposing);
  }

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style , required bool withComposing}) {
    assert(!value.composing.isValid || !withComposing || value.isComposingRangeValid);


    return TextSpan(
      children: [
        TextSpan(style: style, text: text),
        TextSpan(style: exampleStringStyle, text: exampleStringBuilder.value.item2),
      ],
    );
    // TODO: Might not need composing in this way
    /*
    // If the composing range is out of range for the current text, ignore it to
    // preserve the tree integrity, otherwise in release mode a RangeError will
    // be thrown and this EditableText will be built with a broken subtree.
    final bool composingRegionOutOfRange = !value.isComposingRangeValid || !withComposing;

    if (composingRegionOutOfRange) {
      return TextSpan(style: style, text: text);
    }

    final TextStyle composingStyle = style?.merge(
        const TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.red,
        ),
    ) ?? const TextStyle(decoration: TextDecoration.underline);

    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: value.composing.textBefore(value.text)),
        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(value.text),
        ),
        TextSpan(text: value.composing.textAfter(value.text)),
      ],
    );
    */
  }

  /// Check that the [selection] is inside of the composing range.
  bool _isSelectionWithinComposingRange(TextSelection selection) {
    return selection.start >= value.composing.start && selection.end <= value.composing.end;
  }
}
