import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_terms/modules/terms_listing/data/models/terms_n_conditions_model.dart';
import 'package:speech_to_terms/modules/terms_listing/presentation/bloc/terms_and_conditions_bloc.dart';

import 'add_or_edit_terms_bottom_sheet.dart';

class TermsListingScreenBottomNavBar extends StatelessWidget {
  const TermsListingScreenBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width - 32,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 2.0,
            blurRadius: 4.0,
          )
        ],
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
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
                  onSubmitTapped: (String data) {
                    TermsAndCondition newTerms = TermsAndCondition(
                      data: data,
                      createdAt: Timestamp.now(),
                    );
                    BlocProvider.of<TermsAndConditionsBloc>(context).add(NewTermsSubmitBtnTapped(newTerms));
                  },
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            "Add More",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
