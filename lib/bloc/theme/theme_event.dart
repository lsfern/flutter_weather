part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeColorChanged extends ThemeEvent {
  final bool dark;
  ThemeColorChanged(this.dark);
}
