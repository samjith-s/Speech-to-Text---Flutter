import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:speech_to_terms/modules/terms_listing/data/models/terms_n_conditions_model.dart';
import 'package:speech_to_terms/utils/widgets/custom_progress_indicator.dart';

class TermsAndConditionsCard extends StatefulWidget {
  final TermsAndCondition termsAndCondition;
  final ValueChanged<TermsAndCondition> onEdit;
  final ValueChanged<TermsAndCondition> onDelete;

  const TermsAndConditionsCard({
    super.key,
    required this.termsAndCondition,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<TermsAndConditionsCard> createState() => _TermsAndConditionsCardState();
}

class _TermsAndConditionsCardState extends State<TermsAndConditionsCard> {
  bool hindiDisplayed = false;
  String hindiText = "";
  late TranslateLanguage sourceLanguage;
  late TranslateLanguage targetLanguage;
  late OnDeviceTranslator onDeviceTranslator;

  @override
  void initState() {
    super.initState();
    sourceLanguage = TranslateLanguage.english;
    targetLanguage = TranslateLanguage.hindi;
    onDeviceTranslator = OnDeviceTranslator(sourceLanguage: sourceLanguage, targetLanguage: targetLanguage);
  }

  @override
  void dispose() {
    onDeviceTranslator.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 4.0,
              spreadRadius: 2.0,
            )
          ]),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16.0,
                16.0,
                16.0,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.termsAndCondition.data,
                  ),
                  if (hindiText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        hindiText,
                      ),
                    ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () async {
                        if (hindiDisplayed) {
                          hindiText = "";
                        } else {
                          //Todo: Initially this will take a while to download the model, This has to be managed
                          CustomProgressIndicator(context).showLoadingIndicator();
                          hindiText = await onDeviceTranslator.translateText(widget.termsAndCondition.data);
                          if (mounted) {
                            CustomProgressIndicator(context).hideLoadingIndicator();
                          }
                        }
                        if (mounted) {
                          setState(() {
                            hindiDisplayed = !hindiDisplayed;
                          });
                        }
                      },
                      child: Text(
                        hindiDisplayed ? "Read in English" : "Read In Hindi",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 44.0,
                  height: 44.0,
                  child: IconButton(
                    onPressed: () {
                      widget.onEdit(widget.termsAndCondition);
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Colors.cyan,
                    ),
                  ),
                ),
                SizedBox(
                  width: 44.0,
                  height: 44.0,
                  child: IconButton(
                    onPressed: () {
                      widget.onDelete(widget.termsAndCondition);
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
