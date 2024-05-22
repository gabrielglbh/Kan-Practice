import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/list_details_types.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_switch.dart';

class KPGrammarSwitch extends StatefulWidget {
  final bool isActionChip;
  final bool usesService;
  final Function(bool value) onChanged;
  const KPGrammarSwitch({
    super.key,
    required this.onChanged,
    this.usesService = true,
    this.isActionChip = false,
  });

  @override
  State<KPGrammarSwitch> createState() => _KPGrammarSwitchState();
}

class _KPGrammarSwitchState extends State<KPGrammarSwitch> {
  bool _showGrammarGraphs = false;

  _toggleGraphs(bool value) {
    if (widget.usesService) {
      getIt<PreferencesService>().saveData(SharedKeys.showGrammarGraphs, value);
    }
    setState(() => _showGrammarGraphs = value);
    widget.onChanged(_showGrammarGraphs);
  }

  @override
  void initState() {
    if (widget.usesService) {
      _showGrammarGraphs =
          getIt<PreferencesService>().readData(SharedKeys.showGrammarGraphs) ??
              false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isActionChip) {
      return ActionChip(
        label: Text(
          _showGrammarGraphs
              ? 'word_change_graphs'.tr()
              : 'grammar_change_graphs'.tr(),
          style: TextStyle(color: Theme.of(context).colorScheme.surface),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        avatar: Icon(
          _showGrammarGraphs
              ? ListDetailsType.words.icon
              : ListDetailsType.grammar.icon,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin4),
        onPressed: () => _toggleGraphs(!_showGrammarGraphs),
      );
    }
    return ListTile(
      title: Text(
        'grammar_change_graphs'.tr(),
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      trailing: KPSwitch(
        onChanged: (value) {
          _toggleGraphs(!_showGrammarGraphs);
        },
        value: _showGrammarGraphs,
      ),
      visualDensity: const VisualDensity(vertical: -4),
      onTap: () {
        _toggleGraphs(!_showGrammarGraphs);
      },
    );
  }
}
