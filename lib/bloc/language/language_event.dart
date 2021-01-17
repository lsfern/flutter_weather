part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent {}

class LanguageChanged extends LanguageEvent {
  final Locale locale;
  LanguageChanged({this.locale});
}
