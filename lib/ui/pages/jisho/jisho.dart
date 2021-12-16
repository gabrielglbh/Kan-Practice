import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/ui/pages/jisho/bloc/jisho_bloc.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/ExamplePhrases.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/SingleKanjiResult.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/WordResult.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/TTSIconButton.dart';

class JishoPage extends StatelessWidget {
  final String? kanji;

  const JishoPage({required this.kanji});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomSizes.appBarHeight,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text(kanji ?? "?")),
        centerTitle: true,
        actions: [
          TTSIconButton(kanji: kanji)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocProvider<JishoBloc>(
              create: (_) => JishoBloc()..add(JishoLoadingEvent(kanji: kanji ?? "")),
              child: BlocBuilder<JishoBloc, JishoState>(
                builder: (context, state) {
                  if (state is JishoStateLoading)
                    return CustomProgressIndicator();
                  else if (state is JishoStateFailure)
                    return _nothingFound();
                  else if (state is JishoStateLoaded) {
                    return _content(context, state);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
          _poweredByJisho(),
        ],
      )
    );
  }

  Widget _content(BuildContext context, JishoStateLoaded state) {
    if (state.data.resultData == null && state.data.example.isEmpty) {
      return _nothingFound();
    }
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Visibility(
                visible: state.data.resultData != null,
                child: SingleKanjiResult(
                  data: state.data.resultData,
                  phrase: state.data.resultPhrase,
                )
              ),
              Visibility(
                visible: state.data.resultPhrase.isNotEmpty,
                child: WordResult(
                  kanji: kanji,
                  data: state.data.resultData,
                  phrase: state.data.resultPhrase
                )
              ),
              Visibility(
                visible: state.data.example.isNotEmpty,
                child: ExamplePhrases(data: state.data.example)
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _nothingFound() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
        child: Text("jisho_no_match".tr())
      ));
  }

  Widget _poweredByJisho() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Margins.margin8),
      child: Chip(
        backgroundColor: Colors.green,
        label: Text("jisho_resultData_powered_by".tr()),
      ),
    );
  }
}
