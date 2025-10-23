abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final int currentIndex;
  
  HomeLoaded({required this.currentIndex});
}
