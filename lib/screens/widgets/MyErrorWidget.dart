import 'package:flutter/material.dart';
import 'package:rrptflutter/generated/l10n.dart';

class MyErrorWidget extends StatelessWidget {
  final String errorMsg;

  MyErrorWidget(this.errorMsg);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Text(errorMsg),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                  elevation: 6.0,
                  child: Text(S.of(context).retry),
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
