import 'package:flutter/material.dart';

class PreLoader extends StatelessWidget {
  final String loadingText;
  PreLoader([this.loadingText]);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20.0),
          loadingText!=null?Text(loadingText,style: TextStyle(
            fontSize: 18.0
          )):SizedBox.shrink()
        ],
      ),
    );
  }
}
