import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'dart:math' as math;

class AppWidget {
  //
  static double mainWindowPadding = 5.0;
  static double mainDtlPadding = 5.0;
  static double dtlRecPadding = 2.0;
  BuildContext? context;

  AppWidget(BuildContext pContext) {
    this.context = pContext;
  }

  static Container fieldTxt(BuildContext context, TextEditingController ctrl,
      String lblNm, bool readOnly, double txtWidth, double txtHeight) {
    return Container(
      width: txtWidth,
      height: txtHeight,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText2,
        controller: ctrl,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: lblNm,
        ),
      ),
    );
  }

  static Container fieldDesc(
      BuildContext context,
      TextEditingController ctrl,
      String lblNm,
      bool readOnly,
      double txtWidth,
      double txtHeight,
      int maxLines) {
    return Container(
      width: txtWidth,
      height: txtHeight,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText2,
        maxLines: maxLines,
        controller: ctrl,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: lblNm,
        ),
      ),
    );
  }

  static Container fieldDescV2(
      BuildContext context,
      TextEditingController ctrl,
      String lblNm,
      bool readOnly,
      double txtWidth,
      double txtHeight,
      int maxLines) {
    return Container(
      width: txtWidth,
      height: txtHeight,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText2,
        maxLines: maxLines,
        controller: ctrl,
        readOnly: readOnly,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: lblNm,
        ),
      ),
    );
  }

  static Container fieldTxtNumKey(
      BuildContext context,
      TextEditingController ctrl,
      String lblNm,
      bool readOnly,
      double txtWidth,
      double txtHeight) {
    return Container(
      width: txtWidth,
      height: txtHeight,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText2,
        controller: ctrl,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: lblNm,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  static Container fieldNum9Int2Dec(
      BuildContext context,
      TextEditingController ctrl,
      String lblNm,
      bool readOnly,
      double txtWidth,
      double txtHeight) {
    return Container(
      width: txtWidth,
      height: txtHeight,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText2,
        controller: ctrl,
        readOnly: readOnly,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        // new MaskTextInputFormatter(
        //     mask: '###,###,##0.00', filter: {"#": RegExp(r'[0-9]')})
        //],
        decoration: InputDecoration(
          labelText: lblNm,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  static Container fieldNum9Int2DecWithNeg(
      BuildContext context,
      TextEditingController ctrl,
      String lblNm,
      bool readOnly,
      double txtWidth,
      double txtHeight) {
    return Container(
      width: txtWidth,
      height: txtHeight,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText2,
        controller: ctrl,
        readOnly: readOnly,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^[-]|[0-9]+\.?\d{0,2}')),
          // FilteringTextInputFormatter.allow(RegExp(r'^[-|0-9]+\.?\d{0,2}')),
        ],
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        // new MaskTextInputFormatter(
        //     mask: '###,###,##0.00', filter: {"#": RegExp(r'[0-9]')})
        //],
        decoration: InputDecoration(
          labelText: lblNm,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  static Container fieldNum9Int4Dec(
      BuildContext context,
      TextEditingController ctrl,
      String lblNm,
      bool readOnly,
      double txtWidth,
      double txtHeight) {
    return Container(
      width: txtWidth,
      height: txtHeight,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText2,
        controller: ctrl,
        readOnly: readOnly,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}')),
        ],
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        // inputFormatters: [
        //  new MaskTextInputFormatter(
        //      mask: '###,###,###.####', filter: {"#": RegExp(r'[0-9]')})
        // ],
        decoration: InputDecoration(
          labelText: lblNm,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  static Container fieldNum9Int(
      BuildContext context,
      TextEditingController ctrl,
      String lblNm,
      bool readOnly,
      double txtWidth,
      double txtHeight) {
    return Container(
      width: txtWidth,
      height: txtHeight,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText2,
        controller: ctrl,
        readOnly: readOnly,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        // inputFormatters: [
        //   new MaskTextInputFormatter(
        //       mask: '###,###,###', filter: {"#": RegExp(r'[0-9]')})
        // ],
        decoration: InputDecoration(
          labelText: lblNm,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}
