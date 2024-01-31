import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:speech_to_terms/core/network/models/app_error_model.dart';
import 'package:speech_to_terms/modules/terms_listing/data/models/terms_n_conditions_model.dart';

const _kTermsAndConditionsCollection = "terms_and_conditions";
const _kId = "id";
const _kData = "data";
const _kCreatedAt = "created_at";

@injectable
class TermsAndConditionsAPI {
  final FirebaseFirestore _firestore;

  TermsAndConditionsAPI(this._firestore);

  Future<Either<AppErrorModel, List<TermsAndCondition>>> fetchInitialPageTerms() async {
    try {
      QuerySnapshot<Map<String, dynamic>> firstTenDocs = await _firestore.collection(_kTermsAndConditionsCollection).orderBy(_kCreatedAt).limit(10).get();
      List<TermsAndCondition> firstTenTerms = firstTenDocs.docs.map((terms) => TermsAndCondition.fromJson(terms.data())).toList();

      return Right(firstTenTerms);
    } catch (e) {
      return Left(AppErrorModel(e, e.toString()));
    }
  }

  Future<Either<AppErrorModel, List<TermsAndCondition>>> fetchNextPageTerms(Timestamp lastDocId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> nextTenDocs = await _firestore.collection(_kTermsAndConditionsCollection).orderBy(_kCreatedAt).startAfter([lastDocId]).limit(10).get();
      List<TermsAndCondition> firstTenTerms = nextTenDocs.docs.map((terms) => TermsAndCondition.fromJson(terms.data())).toList();

      return Right(firstTenTerms);
    } catch (e) {
      return Left(AppErrorModel(e, e.toString()));
    }
  }

  Future<Either<AppErrorModel, bool>> addNewTerms(TermsAndCondition newTerm) async {
    try {
      DocumentReference<Map<String, dynamic>> newItemRef = await _firestore.collection(_kTermsAndConditionsCollection).add(newTerm.toJson());
      await newItemRef.update({_kId: newItemRef.id});
      return const Right(true);
    } catch (e) {
      return Left(AppErrorModel(e, e.toString()));
    }
  }

  Future<Either<AppErrorModel, bool>> deleteTerms(String termsId) async {
    try {
      await _firestore.collection(_kTermsAndConditionsCollection).doc(termsId).delete();
      return const Right(true);
    } catch (e) {
      return Left(AppErrorModel(e, e.toString()));
    }
  }

  Future<Either<AppErrorModel, bool>> editExistingTerms(String newData, String termsId) async {
    try {
      var docRef = _firestore.collection(_kTermsAndConditionsCollection).doc(termsId);
      await docRef.update({_kData: newData});
      return const Right(true);
    } catch (e) {
      return Left(AppErrorModel(e, e.toString()));
    }
  }
}
