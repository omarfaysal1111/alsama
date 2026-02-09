abstract class CategoriesEvent {}

class GetCategoriesRequested extends CategoriesEvent {
  GetCategoriesRequested();
}

class RefreshCategoriesRequested extends CategoriesEvent {
  RefreshCategoriesRequested();
}
