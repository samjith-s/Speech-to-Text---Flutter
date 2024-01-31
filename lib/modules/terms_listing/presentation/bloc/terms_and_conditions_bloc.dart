import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:speech_to_terms/core/network/models/app_error_model.dart';
import 'package:speech_to_terms/modules/terms_listing/data/models/terms_n_conditions_model.dart';
import 'package:speech_to_terms/modules/terms_listing/domain/repository/i_terms_n_contions_repo.dart';

part 'terms_and_conditions_event.dart';

part 'terms_and_conditions_state.dart';

@injectable
class TermsAndConditionsBloc extends Bloc<TermsAndConditionsEvent, TermsAndConditionsState> {
  final ITermsNConditionsRepository _termsNConditionsRepository;

  TermsAndConditionsBloc(this._termsNConditionsRepository) : super(TermsAndConditionsInitial()) {
    on<FetchInitialTermsAndConditions>(onFetchInitialTermsAndConditions);
    on<ScrolledToPageEnd>(onScrolledToPageEnd);
    on<NewTermsSubmitBtnTapped>(onNewTermsSubmitBtnTapped);
    on<EditTermsBtnTapped>(onEditTermsBtnTapped);
    on<DeleteTermsBtnTapped>(onDeleteTermsBtnTapped);
  }

  List<TermsAndCondition> termsAndConditionsList = [];
  bool paginationEventProcessing = false;

  FutureOr<void> onFetchInitialTermsAndConditions(FetchInitialTermsAndConditions event, Emitter<TermsAndConditionsState> emit) async {
    emit(DisplayLoading(initial: true));

    Either<AppErrorModel, List<TermsAndCondition>> result = await _termsNConditionsRepository.fetchInitialPageTerms();
    result.fold(
      (left) => emit(DisplayErrorMessage(left.message)),
      (right) {
        termsAndConditionsList = right;
        emit(DisplayTermsAndConditionsList(right));
      },
    );
  }

  FutureOr<void> onScrolledToPageEnd(ScrolledToPageEnd event, Emitter<TermsAndConditionsState> emit) async {
    if (!paginationEventProcessing) {
      paginationEventProcessing = true;
      emit(DisplayPaginationLoading());

      Either<AppErrorModel, List<TermsAndCondition>> result = await _termsNConditionsRepository.fetchNextPageTerms(termsAndConditionsList.last.createdAt);
      result.fold(
        (left) => emit(DisplayErrorMessage(left.message)),
        (right) {
          termsAndConditionsList += right;
          emit(DisplayTermsAndConditionsList(termsAndConditionsList));
        },
      );
      paginationEventProcessing = false;
    }
  }

  FutureOr<void> onNewTermsSubmitBtnTapped(NewTermsSubmitBtnTapped event, Emitter<TermsAndConditionsState> emit) async {
    emit(DisplayLoading());

    Either<AppErrorModel, bool> result = await _termsNConditionsRepository.addNewTerms(event.newTerms);
    result.fold(
      (left) => emit(DisplayErrorMessage(left.message)),
      (right) => emit(AddNewTermsSuccess()),
    );
  }

  FutureOr<void> onEditTermsBtnTapped(EditTermsBtnTapped event, Emitter<TermsAndConditionsState> emit) async {
    emit(DisplayLoading());

    Either<AppErrorModel, bool> result = await _termsNConditionsRepository.editExistingTerms(event.newData, event.termsId);
    result.fold(
      (left) => emit(DisplayErrorMessage(left.message)),
      (right) => emit(EditExistingTermsSuccess()),
    );
  }

  FutureOr<void> onDeleteTermsBtnTapped(DeleteTermsBtnTapped event, Emitter<TermsAndConditionsState> emit) async {
    emit(DisplayLoading());

    Either<AppErrorModel, bool> result = await _termsNConditionsRepository.deleteTerms(event.termsId);
    result.fold(
      (left) => emit(DisplayErrorMessage(left.message)),
      (right) => emit(DeleteTermsSuccess()),
    );
  }
}
