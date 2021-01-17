part of 'language_bloc.dart';

@immutable
abstract class LanguageState {
  final Locale locale;
  LanguageState({this.locale});
}

class LanguageInitial extends LanguageState {}

class LanguageChange extends LanguageState {
  LanguageChange({Locale locale}) : super(locale: locale);
}
