import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_terms/modules/terms_listing/data/models/terms_n_conditions_model.dart';
import 'package:speech_to_terms/modules/terms_listing/presentation/bloc/terms_and_conditions_bloc.dart';
import 'package:speech_to_terms/utils/widgets/custom_progress_indicator.dart';

import 'display_speech_dialog.dart';

class AddOrEditTermsBottomSheet extends StatefulWidget {
  final ValueChanged<String> onSubmitTapped;
  final TermsAndCondition? termsAndCondition;
  final bool isEdit;

  const AddOrEditTermsBottomSheet({
    super.key,
    required this.onSubmitTapped,
    this.termsAndCondition,
    this.isEdit = false,
  }) : assert(
          (isEdit && termsAndCondition != null) || (!isEdit && termsAndCondition == null),
          "termsAndCondition should be passed only if isEdit is true",
        );

  @override
  State<AddOrEditTermsBottomSheet> createState() => _AddOrEditTermsBottomSheetState();
}

class _AddOrEditTermsBottomSheetState extends State<AddOrEditTermsBottomSheet> {
  late TextEditingController _termsController;
  bool submitBtnEnabled = false;

  @override
  void initState() {
    super.initState();
    _termsController = TextEditingController()
      ..addListener(() {
        if ((widget.isEdit && _termsController.text.trim() != widget.termsAndCondition!.data) || (!widget.isEdit && _termsController.text.isNotEmpty)) {
          // This setState will only called once while the status is changed.
          if (!submitBtnEnabled) {
            if (mounted) {
              setState(() {
                submitBtnEnabled = true;
              });
            }
          }
        } else if (submitBtnEnabled) {
          if (mounted) {
            setState(() {
              submitBtnEnabled = false;
            });
          }
        }
      });
    if (widget.isEdit) {
      _termsController.text = widget.termsAndCondition!.data;
    }
  }

  @override
  void dispose() {
    _termsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TermsAndConditionsBloc, TermsAndConditionsState>(
      listener: (context, state) {
        if (state is DisplayLoading) {
          if (!state.initial) {
            CustomProgressIndicator(context).showLoadingIndicator();
          }
        } else if (state is AddNewTermsSuccess) {
          CustomProgressIndicator(context).hideLoadingIndicator();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("New Terms added successfully"),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
            ),
          );
          // Re Initializing the UI after Delete or Update is happened as Now it is not a Stream/Dynamic
          BlocProvider.of<TermsAndConditionsBloc>(context).add(FetchInitialTermsAndConditions());
          Navigator.of(context).pop();
        } else if (state is EditExistingTermsSuccess) {
          CustomProgressIndicator(context).hideLoadingIndicator();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Terms Edited successfully"),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
            ),
          );
          // Re Initializing the UI after Delete or Update is happened as Now it is not a Stream/Dynamic
          BlocProvider.of<TermsAndConditionsBloc>(context).add(FetchInitialTermsAndConditions());
          Navigator.of(context).pop();
        } else if (state is DisplayErrorMessage) {
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
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _termsController,
                  onChanged: (value) {},
                  minLines: 5,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Type terms here..",
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Or user microphone?"),
                    SizedBox(
                      width: 44.0,
                      height: 44.0,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return DisplaySpeechDialog(
                                onTextConfirmed: (input) {
                                  _termsController.text = input;
                                },
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.settings_voice_rounded,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: submitBtnEnabled
                      ? () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          widget.onSubmitTapped(_termsController.text);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(),
                  child: const Center(
                    child: Text(
                      "Submit",
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
