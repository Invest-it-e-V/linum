//  List Divider - pretty much the equivalent of an <hr/> HTML Tag. Used mostly on the Settings Screen.
//
//  Author: NightmindOfficial
//  Co-Author: n/a
//

import 'package:flutter/material.dart';

class ListDivider extends StatelessWidget {
  final double T;
  final double R;
  final double B;
  final double L;

  const ListDivider({this.T = 8.0, this.R = 0, this.B = 8.0, this.L = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: T, right: R, bottom: B, left: L),
      child: Divider(
        thickness: 1.0,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}
