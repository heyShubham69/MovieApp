import 'package:flutter/material.dart';

class CommonWidgets {
  /// Reusable Truncated Text Widget
  static Widget truncatedText(String text, {double fontSize = 14, int maxLines = 1, Color? color, FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize,fontWeight: fontWeight, color: color ?? Colors.black),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget customText(String text, {double fontSize = 14, Color? color, FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? Colors.black
      ),
    );
  }

  static Widget dividerWidget(){
    return
      Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey,
      );
  }

  /// Reusable Genre List View
  static Widget genreView(List<String> genres) {
    return Text(
      genres.join(", "),
      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Reusable Image Card with Rounded Corners
  static Widget imageCard(String imageUrl, {double radius = 5.0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: double.infinity,
            height: 150,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return imageError(double.infinity, 150, 50,cardView: false);
        },
        cacheWidth: 300,
        cacheHeight: 400,
      ),
    );
  }

  /// Reusable Card Container
  static Widget cardContainer({required Widget child, double radius = 5.0, Color color = Colors.white}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      color: color,
      child: Padding(padding: EdgeInsets.all(8.0), child: child),
    );
  }

  static Widget imageError(double width,double height,double iconSize,{bool cardView =true}){
    return SizedBox(
      width: width,
      height: height,
      child:
      cardView
       ? Card(
          child: Center(child: Icon(Icons.broken_image, size: iconSize, color: Colors.grey)))
    :
    Center(child: Icon(Icons.broken_image, size: iconSize, color: Colors.grey))

    );
  }
}
