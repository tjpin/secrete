

import 'package:secrete/core.dart';

extension PaddingExtension on Widget {
    Widget addHPadding(double p) {
        return Padding(padding: EdgeInsets.symmetric(horizontal: p), child: this,);
    }

    Widget addVPadding(double p) {
        return Padding(padding: EdgeInsets.symmetric(vertical: p), child: this,);
    }

    Widget addAllPadding(double p) {
        return Padding(padding: EdgeInsets.all(p), child: this,);
    }
}