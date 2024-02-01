import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:speech_to_terms/core/network/models/app_error_model.dart';
import 'package:speech_to_terms/modules/terms_listing/data/models/terms_n_conditions_model.dart';

abstract class ITermsNConditionsRepository {
  Future<Either<AppErrorModel, List<TermsModel>>> fetchInitialPageTerms();
  Future<Either<AppErrorModel, List<TermsAndCondition>>> fetchNextPageTerms(Timestamp lastDocId);
  Future<Either<AppErrorModel, bool>> addNewTerms(TermsAndCondition newTerm);
  Future<Either<AppErrorModel, bool>> editExistingTerms(String newData,String termsId);
  Future<Either<AppErrorModel, bool>> deleteTerms(String termsId);
}
