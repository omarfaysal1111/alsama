import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/category.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<HomeCategory>>> getCategories();
}

