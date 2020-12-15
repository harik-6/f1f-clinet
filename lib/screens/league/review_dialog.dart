import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/services/native/review_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

double iconSize = 40.0;

class RatingDialog extends StatefulWidget {
  final GrandPrix active;
  final Function callback;
  RatingDialog({this.active, this.callback});
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int rating = 0;
  final AppReviewService review = AppReviewService();
  void _setRating(int ratenumber) {
    setState(() {
      rating = ratenumber;
    });
  }

  void _remindLater() async {
    await review.remindLater(widget.active.round);
    widget.callback();
  }

  void _userReviwed() async {
    await review.userReviewed();
    launch("https://play.google.com/store/apps/details?id=com.F1Fantasy");
    widget.callback();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
      backgroundColor: Colors.grey[900],
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text("Do you like the app ?",
            style: TextStyle(color: Colors.white)),
      ),
      content: Padding(
        padding: EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
              onPressed: () {
                _setRating(1);
              },
              icon: Icon(Icons.star,
                  size: iconSize,
                  color: rating > 0 ? Colors.yellow : Colors.white)),
          IconButton(
              onPressed: () {
                _setRating(2);
              },
              icon: Icon(Icons.star,
                  size: iconSize,
                  color: rating > 1 ? Colors.yellow : Colors.white)),
          IconButton(
              onPressed: () {
                _setRating(3);
              },
              icon: Icon(Icons.star,
                  size: iconSize,
                  color: rating > 2 ? Colors.yellow : Colors.white)),
          IconButton(
              onPressed: () {
                _setRating(4);
              },
              icon: Icon(Icons.star,
                  size: iconSize,
                  color: rating > 3 ? Colors.yellow : Colors.white)),
          IconButton(
              onPressed: () {
                _setRating(5);
              },
              icon: Icon(Icons.star,
                  size: iconSize,
                  color: rating > 4 ? Colors.yellow : Colors.white)),
        ]),
      ),
      actions: [
        RaisedButton(
          onPressed: _remindLater,
          color: Colors.transparent,
          elevation: 0.0,
          child: Text("Ask me later"),
        ),
        SizedBox(width: 8.0),
        RaisedButton(
          onPressed: _userReviwed,
          elevation: 0.0,
          color: Colors.green,
          child: Text("Rate now"),
        )
      ],
    );
  }
}