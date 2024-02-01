import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:speech_to_terms/core/network/models/app_error_model.dart';
import 'package:speech_to_terms/modules/terms_listing/data/models/terms_n_conditions_model.dart';
import 'package:speech_to_terms/modules/terms_listing/data/network/terms_n_conditions_api.dart';
import 'package:speech_to_terms/modules/terms_listing/domain/repository/i_terms_n_contions_repo.dart';

@Injectable(as: ITermsNConditionsRepository)
class TermsNConditionsRepository extends ITermsNConditionsRepository {
  final TermsAndConditionsAPI _termsAndConditionsAPI;

  TermsNConditionsRepository(this._termsAndConditionsAPI);

  @override
  Future<Either<AppErrorModel, List<TermsModel>>> fetchInitialPageTerms() {
    return _termsAndConditionsAPI.fetchInitialPageTerms();
  }

  @override
  Future<Either<AppErrorModel, List<TermsAndCondition>>> fetchNextPageTerms(Timestamp lastDocId) {
    return _termsAndConditionsAPI.fetchNextPageTerms(lastDocId);
  }

  @override
  Future<Either<AppErrorModel, bool>> addNewTerms(TermsAndCondition newTerm) {
    return _termsAndConditionsAPI.addNewTerms(newTerm);
  }

  @override
  Future<Either<AppErrorModel, bool>> deleteTerms(String termsId) {
    return _termsAndConditionsAPI.deleteTerms(termsId);
  }

  @override
  Future<Either<AppErrorModel, bool>> editExistingTerms(String newData, String termsId) {
    return _termsAndConditionsAPI.editExistingTerms(newData, termsId);
  }
}
