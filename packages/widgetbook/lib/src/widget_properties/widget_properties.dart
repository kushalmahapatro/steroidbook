import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/repositories/selected_use_case_repository.dart';

import '../../widgetbook.dart';

extension WidgetProperties on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  WidgetPropertiesBuilder get widgetProperties =>
      Provider.of<WidgetPropertiesNotifier>(this, listen: false);
}

abstract class WidgetPropertiesBuilder {
  WidgetPropertiesBuilder();

  String text({required String properties});
}

class WidgetPropertiesNotifier extends ChangeNotifier
    implements WidgetPropertiesBuilder {
  WidgetPropertiesNotifier(this._selectedStoryRepository) {
    _selectedStoryRepository.getStream().listen((event) => notifyListeners());
  }

  final SelectedUseCaseRepository _selectedStoryRepository;

  final Map<WidgetbookUseCaseData, Map<String, Properties>> _properties =
      <WidgetbookUseCaseData, Map<String, Properties>>{};

  List<Properties> all() {
    if (!_selectedStoryRepository.isSet()) {
      return [];
    }
    final story = _selectedStoryRepository.item;
    return _properties[story]?.values.toList() ?? [];
  }

  void update<T>(String label, String? value) {
    if (!_selectedStoryRepository.isSet()) {
      return;
    }
    _properties[_selectedStoryRepository.item]![label]!.property = value ?? '';
    notifyListeners();
  }

  @override
  String text({required String properties}) {
    final val = NullableTextProperties(property: properties);
    final story = _selectedStoryRepository.item!;
    _properties.clear();
    final knobs = _properties.putIfAbsent(story, () => <String, Properties>{});
    return (knobs.putIfAbsent(properties, () {
      Future.microtask(notifyListeners);
      return val;
    })).property;
  }
}

abstract class Properties<T> {
  Properties({
    required this.property,
  });

  /// This is the current value the knob is set to
  T property;

  @override
  bool operator ==(Object other) {
    return other is Properties<String> && other.property == property;
  }

  @override
  int get hashCode => property.hashCode;

  Widget build(BuildContext context);
}

class NullableTextProperties extends Properties<String?> {
  NullableTextProperties({required super.property});

  @override
  Widget build(BuildContext context) {
    if (property == null /* || (property ?? '').isEmpty */) {
      return SizedBox.shrink();
    }

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4)),
      child: Text(property ?? ''),
    );
  }
}
