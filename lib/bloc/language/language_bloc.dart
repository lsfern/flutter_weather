import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial());

  @override
  Stream<LanguageState> mapEventToState(
    LanguageEvent event,
  ) async* {
    if (event is LanguageChanged) {
      yield* mapEventToChangeLanguageState(event);
    }
  }

  /// 切换系统语言
  Stream<LanguageState> mapEventToChangeLanguageState(
      LanguageChanged event) async* {
    Locale locale;
    // 应用内切换
    if (event.locale == null) {
      String languageCode = state.locale?.languageCode;
      if (languageCode == "zh") {
        locale = Locale("en", "");
      }
      if (languageCode == "en") {
        locale = Locale("zh", "CN");
      }
    }
    yield LanguageChange(locale: locale ?? event.locale);
  }
}
