import 'package:linum/common/types/filter_function.dart';
import 'package:linum/core/categories/core/domain/types/category_map.dart';
import 'package:linum/core/repeating/constants/standard_repeat_configs.dart';
import 'package:linum/screens/enter_screen/domain/constants/parsable_date_map.dart';
import 'package:linum/screens/enter_screen/domain/enums/input_flag.dart';
import 'package:linum/screens/enter_screen/domain/models/suggestion.dart';
import 'package:linum/screens/enter_screen/domain/models/suggestion_filters.dart';


class SubSuggestionsGenerator {
  final CategoryMapIterable categories;
  SubSuggestionsGenerator({required this.categories});

  List<Suggestion> generate(InputFlag flag, {ParsingFilters? filters}) {
    switch (flag) {
      case InputFlag.category:
        return categories
            .where((e) => applyFilter(filters?.categoryFilter, e.value))
            .map((e) => Suggestion(label: e.value.label))
            .toList();
      case InputFlag.date:
        return parsableDateMap.entries
            .where((e) => applyFilter(filters?.dateFilter, e.key))
            .map((e) => Suggestion(label: e.value))
            .toList();
      case InputFlag.repeatInfo:
        return repeatConfigurations.entries
            .where((e) => applyFilter(filters?.repeatFilter, e.key))
            .map((e) => Suggestion(label: e.value.label))
            .toList();
      default:
        return [];
    }
  }
}