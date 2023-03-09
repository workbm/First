import 'package:flutter/material.dart';

import '../../../constants/general_data.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  var _isFavorite = false;

  void _favoriteFct() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 28,
      margin: const EdgeInsets.only(top: 7, left: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: GeneralData.favoriteButton),
      child: Center(
        child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              _favoriteFct();
            },
            icon: _isFavorite
                ? const Icon(
                    Icons.favorite,
                    color: GeneralData.primaryColor,
                    size: 20,
                  )
                : const Icon(
                    Icons.favorite_border,
                    size: 20,
                  )),
      ),
    );
  }
}
