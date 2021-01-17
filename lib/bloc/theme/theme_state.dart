part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  final bool dark;
  ThemeState({this.dark = false});
}

class ThemeInitial extends ThemeState {}

class ThemeChange extends ThemeState {
  ThemeChange(bool dark) : super(dark: dark);
}
