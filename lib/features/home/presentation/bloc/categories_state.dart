import '../../domain/entities/category.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<HomeCategory> categories;
  
  CategoriesLoaded({required this.categories});
}

class CategoriesError extends CategoriesState {
  final String message;
  
  CategoriesError({required this.message});
}

class CategoriesEmpty extends CategoriesState {
  final String message;
  
  CategoriesEmpty({required this.message});
}

