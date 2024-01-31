import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_terms/modules/terms_listing/data/models/terms_n_conditions_model.dart';
import 'package:speech_to_terms/modules/terms_listing/presentation/bloc/terms_and_conditions_bloc.dart';
import 'package:speech_to_terms/modules/terms_listing/presentation/widgets/add_or_edit_terms_bottom_sheet.dart';
import 'package:speech_to_terms/modules/terms_listing/presentation/widgets/terms_and_conditions_card.dart';
import 'package:speech_to_terms/modules/terms_listing/presentation/widgets/terms_listing_screen_bottom_nav_bar.dart';
import 'package:speech_to_terms/utils/widgets/custom_progress_indicator.dart';

class TermsNConditionsListingScreen extends StatefulWidget {
  const TermsNConditionsListingScreen({Key? key}) : super(key: key);

  @override
  State<TermsNConditionsListingScreen> createState() => _TermsNConditionsListingScreenState();
}

class _TermsNConditionsListingScreenState extends State<TermsNConditionsListingScreen> {
  List<TermsAndCondition> termsNConditionsList = [];
  late bool screenLoading;
  late bool displayPaginationLoading;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    screenLoading = true;
    displayPaginationLoading = false;
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
          WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
            BlocProvider.of<TermsAndConditionsBloc>(context).add(ScrolledToPageEnd());
          });
        }
      });
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      BlocProvider.of<TermsAndConditionsBloc>(context).add(FetchInitialTermsAndConditions());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<TermsAndConditionsBloc, TermsAndConditionsState>(
        listener: (context, state) {
          if (state is DisplayLoading) {
            if (!state.initial) {
              CustomProgressIndicator(context).showLoadingIndicator();
            } else {
              screenLoading = true;
            }
          } else if (state is DisplayTermsAndConditionsList) {
            screenLoading = false;
            displayPaginationLoading = false;
            termsNConditionsList = state.termsAndConditionsList;
          } else if (state is DisplayPaginationLoading) {
            displayPaginationLoading = true;
          } else if (state is DeleteTermsSuccess) {
            CustomProgressIndicator(context).hideLoadingIndicator();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Terms deleted successfully"),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
            // Re Initializing the UI after Delete or Update is happened as Now it is not a Stream/Dynamic
            BlocProvider.of<TermsAndConditionsBloc>(context).add(FetchInitialTermsAndConditions());
          } else if (state is DisplayErrorMessage) {
            screenLoading = false;
            displayPaginationLoading = false;
            CustomProgressIndicator(context).hideLoadingIndicator();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMsg),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Terms and Conditions"),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.grey.shade400,
            centerTitle: true,
            elevation: 1,
          ),
          body: BlocBuilder<TermsAndConditionsBloc, TermsAndConditionsState>(
            builder: (context, state) {
              return screenLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : termsNConditionsList.isEmpty
                      ? const Center(
                          child: Text("No Terms and Conditions available"),
                        )
                      : Stack(
                          children: [
                            ListView.separated(
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                return TermsAndConditionsCard(
                                  termsAndCondition: termsNConditionsList[index],
                                  onDelete: (termsAndCondition) {
                                    BlocProvider.of<TermsAndConditionsBloc>(context).add(
                                      DeleteTermsBtnTapped(termsAndCondition.id!),
                                    );
                                  },
                                  onEdit: (termsAndCondition) {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          topRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      builder: (context) {
                                        return AddOrEditTermsBottomSheet(
                                          isEdit: true,
                                          termsAndCondition: termsAndCondition,
                                          onSubmitTapped: (String data) {
                                            BlocProvider.of<TermsAndConditionsBloc>(context).add(
                                              EditTermsBtnTapped(data, termsAndCondition.id!),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) => const SizedBox(height: 16.0),
                              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 50.0),
                              itemCount: termsNConditionsList.length,
                            ),
                            if (displayPaginationLoading)
                              const Align(
                                alignment: Alignment.bottomCenter,
                                child: CircularProgressIndicator(),
                              )
                          ],
                        );
            },
          ),
          bottomNavigationBar: const TermsListingScreenBottomNavBar(),
        ),
      ),
    );
  }
}
