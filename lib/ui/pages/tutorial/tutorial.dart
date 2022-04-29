import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/types/tutorial_view.dart';
import 'package:kanpractice/ui/pages/tutorial/bloc/tutorial_bloc.dart';
import 'package:kanpractice/ui/pages/tutorial/widgets/bullet_page_view.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kp_cached_network_image.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class TutorialPage extends StatefulWidget {
  final bool? alreadyShown;
  const TutorialPage({
    Key? key,
    this.alreadyShown
  }) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final TutorialBloc _bloc = TutorialBloc();
  bool _showSkip = true;

  Future<void> _onEnd(BuildContext bloc) async {
    if (widget.alreadyShown == null) {
      bloc.read<TutorialBloc>().add(TutorialEventLoading(bloc));
    } else {
      Navigator.of(bloc).pop();
    }
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TutorialBloc>(
      create: (context) => _bloc..add(TutorialEventIdle()),
      child: BlocListener<TutorialBloc, TutorialState>(
        listener: (context, state) {
          if (state is TutorialStateLoaded || state is TutorialStateFailure) {
            Navigator.of(context).pushReplacementNamed(KanPracticePages.kanjiListPage);
          }
        },
        child: BlocBuilder<TutorialBloc, TutorialState>(
          builder: (context, state) {
            if (state is TutorialStateIdle) {
              return KPScaffold(
                appBarActions: [
                  TextButton(
                    onPressed: () async => await _onEnd(context),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Text(_showSkip ? "tutorial_skip".tr() : "tutorial_done".tr(),
                      style: const TextStyle(color: CustomColors.secondaryColor),
                    )
                  )
                ],
                appBarTitle: null,
                child: BulletPageView(
                  bullets: TutorialView.values.length,
                  onChanged: (newPage) => setState(() => _showSkip = newPage != TutorialView.values.length - 1),
                  pageViewChildren: List.generate(TutorialView.values.length, (view) =>
                      _tutorialPage(context, TutorialView.values[view])
                  ),
                )
              );
            } else {
              return const KPScaffold(
                appBarTitle: null,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(Margins.margin16),
                    child: KPProgressIndicator(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Column _tutorialPage(BuildContext context, TutorialView view) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(Margins.margin8),
            child: SingleChildScrollView(
                child: Text(
                    view.tutorial, textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2
                )),
          )
        ),
        Expanded(
          flex: 3,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(Margins.margin8),
            margin: const EdgeInsets.symmetric(horizontal: Margins.margin8),
            child: KPCachedNetworkImage(
              url: view.asset(lightMode: Theme.of(context).brightness == Brightness.light),
              errorMessage: "image_not_loaded".tr(),
            ),
          ),
        ),
      ],
    );
  }
}
