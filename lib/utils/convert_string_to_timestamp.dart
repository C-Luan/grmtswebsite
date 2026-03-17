// Flutter imports:
import 'package:flutter/material.dart';

class ConvertStringToDateTime {
  DateTime convert({required String timestap}) {
    var regex = timestap.split('/');
    DateTime regexDateTime = DateTime.utc(
      int.parse(regex.elementAt(2)),
      int.parse(regex.elementAt(1)),
      int.parse(regex.elementAt(0)),
    );
    return regexDateTime;
  }

  DateTime? tryConvert({required String timestap}) {
    try {
      var regex = timestap.split('/');
      DateTime regexDateTime = DateTime.utc(
        int.parse(regex.elementAt(2)),
        int.parse(regex.elementAt(1)),
        int.parse(regex.elementAt(0)),
      );
      return regexDateTime;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
