import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  
  CategoriesBloc({
    required GetCategoriesUseCase getCategoriesUseCase,
  }) : _getCategoriesUseCase = getCategoriesUseCase,
       super(CategoriesInitial()) {
    
    on<GetCategoriesRequested>(_onGetCategoriesRequested);
    on<RefreshCategoriesRequested>(_onRefreshCategoriesRequested);
  }
  
  Future<void> _onGetCategoriesRequested(
    GetCategoriesRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());
    
    final result = await _getCategoriesUseCase();
    
    result.fold(
      (failure) => emit(CategoriesError(message: failure.message)),
      (categories) {
        if (categories.isEmpty) {
          emit(CategoriesEmpty(message: 'No categories found'));
        } else {
          emit(CategoriesLoaded(categories: categories));
        }
      },
    );
  }
  
  Future<void> _onRefreshCategoriesRequested(
    RefreshCategoriesRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());
    
    final result = await _getCategoriesUseCase();
    
    result.fold(
      (failure) => emit(CategoriesError(message: failure.message)),
      (categories) {
        if (categories.isEmpty) {
          emit(CategoriesEmpty(message: 'No categories found'));
        } else {
          emit(CategoriesLoaded(categories: categories));
        }
      },
    );
  }
}

