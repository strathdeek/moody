part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final int selectedIndex;

  NavigationState(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
