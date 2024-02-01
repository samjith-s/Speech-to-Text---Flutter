part of 'terms_and_conditions_bloc.dart';

@immutable
abstract class TermsAndConditionsState {}

class TermsAndConditionsInitial extends TermsAndConditionsState {}

class DisplayTermsAndConditionsList extends TermsAndConditionsState {
  final List<TermsModel> termsAndConditionsList;

  DisplayTermsAndConditionsList(this.termsAndConditionsList);
}

class AddNewTermsSuccess extends TermsAndConditionsState {}

class EditExistingTermsSuccess extends TermsAndConditionsState {}

class DeleteTermsSuccess extends TermsAndConditionsState {}

class DisplayErrorMessage extends TermsAndConditionsState {
  final String errorMsg;

  DisplayErrorMessage(this.errorMsg);
}

class DisplayLoading extends TermsAndConditionsState {
  // [initial] is used to distinguish between weather the screen should be reloaded or just need show progress indicator.
  final bool initial;

  DisplayLoading({this.initial = false});
}

class DisplayPaginationLoading extends TermsAndConditionsState {}
