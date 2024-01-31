part of 'terms_and_conditions_bloc.dart';

@immutable
abstract class TermsAndConditionsEvent {}

class FetchInitialTermsAndConditions extends TermsAndConditionsEvent {}

class ScrolledToPageEnd extends TermsAndConditionsEvent {}

class NewTermsSubmitBtnTapped extends TermsAndConditionsEvent {
  final TermsAndCondition newTerms;

  NewTermsSubmitBtnTapped(this.newTerms);
}

class EditTermsBtnTapped extends TermsAndConditionsEvent {
  final String newData;
  final String termsId;

  EditTermsBtnTapped(this.newData, this.termsId);
}

class DeleteTermsBtnTapped extends TermsAndConditionsEvent {
  final String termsId;

  DeleteTermsBtnTapped(this.termsId);
}
