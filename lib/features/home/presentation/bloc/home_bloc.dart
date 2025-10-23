import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialized>(_onHomeInitialized);
    on<TabChanged>(_onTabChanged);
    on<RefreshHome>(_onRefreshHome);
  }
  
  void _onHomeInitialized(
    HomeInitialized event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeLoaded(currentIndex: 0));
  }
  
  void _onTabChanged(
    TabChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeLoaded(currentIndex: event.index));
  }
  
  void _onRefreshHome(
    RefreshHome event,
    Emitter<HomeState> emit,
  ) {
    // Refresh logic can be added here
    emit(HomeLoaded(currentIndex: 0));
  }
}
