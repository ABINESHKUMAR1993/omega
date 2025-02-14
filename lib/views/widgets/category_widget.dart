import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? onTap;
  const CategoriesWidget({
    super.key,
    this.onTap,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width * .2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height*.08,
              width: width*.2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  )),
            ),
            SizedBox(height:height*.007,),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
