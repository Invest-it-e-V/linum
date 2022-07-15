//  Home Screen Functions - Handles "Flipping" of the card
//
//  Author: NightmindOfficial
//  Co-Author: damattl
//  (Refactored)

import 'package:easy_localization/easy_localization.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

TextStyle? getBalanceTextStyle(BuildContext context, num balance) {
  return MediaQuery.of(context).size.height < 650
      ? Theme.of(context).textTheme.headline2?.copyWith(
            color: balance < 0
                ? Theme.of(context).colorScheme.error
                : const Color(0xFF202020),
          )
      : Theme.of(context).textTheme.headline1?.copyWith(
            color: balance < 0
                ? Theme.of(context).colorScheme.error
                : const Color(0xFF505050),
          );
}

// TODO: Perhaps build this file as class that gets inherited

void onFlipCardTap(BuildContext context, FlipCardController controller) {
  controller.hint(
    duration: const Duration(
      milliseconds: 100,
    ),
    total: const Duration(
      milliseconds: 500,
    ),
  );

  Fluttertoast.showToast(
    msg: tr('home_screen_card.home-screen-card-toast'),
    toastLength: Toast.LENGTH_SHORT,
  );
}
