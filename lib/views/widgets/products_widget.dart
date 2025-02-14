import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';


class ProductsWidget extends StatelessWidget {
  final String? name;
  final VoidCallback? onTap;
  final VoidCallback? favButton;
  final String? image;
  final VoidCallback? addBtn;
  final bool isFavourite;
  final String? discount;
  final String? amount;
  final String? disAfter;

  const ProductsWidget({
    super.key,
    required this.name,
    this.image,
    this.discount,
    this.amount,
    this.disAfter,
    this.onTap,
    this.favButton,
    this.addBtn,
    required this.isFavourite,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return
      InkWell(
        onTap: onTap,
        child: Card(
            color: Colors.white,
            elevation: 3,
            shadowColor: Colors.white54,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left:10,right: 10 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: favButton,
                        child: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: cRed,
                        )),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      image!,
                      height: height * .1,
                      width: width * .36,
                    ),
                  ),
                  Text(
                    name!,
                    textAlign: TextAlign.start,
                    style: TextHelper.pop14W600B,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "${discount!}% discount",
                    textAlign: TextAlign.start,
                    style: TextHelper.pop10W400Gr,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * .26, // Adjust the width as needed
                        child: Wrap(
                          direction: Axis.horizontal, // Ensures that the text wraps if necessary
                          children: [
                            Text(
                              amount!,
                              style: const TextStyle(
                                color: cGrey,
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: cGrey,
                                decorationThickness: 2,
                              ),
                              overflow: TextOverflow.ellipsis, // Ellipsis if amount is too long
                            ),
                            // SizedBox(width:width*.02), // Add some space between the two texts
                            Text(
                              disAfter!,
                              style: TextHelper.pop12W600B,
                              overflow: TextOverflow.ellipsis, // Ellipsis if disAfter is too long
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: addBtn,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                          decoration: const BoxDecoration(
                            color: cPrimaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4),
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                              bottomRight: Radius.zero,
                            ),
                          ),
                          child: Text(
                            "Add",
                            style: TextHelper.pop12W500W,
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            )),
      );
  }
}


