abstract class HomeEvent {}

class HomeInitialized extends HomeEvent {}

class TabChanged extends HomeEvent {
  final int index;
  
  TabChanged({required this.index});
}

class RefreshHome extends HomeEvent {}
