import 'package:flutter/material.dart';

class CustomItemListTileWidget extends StatelessWidget {
  CustomItemListTileWidget(
      {super.key,
      required this.index,
      required this.itemPurchasePlace,
      required this.itemQuantity,
      required this.itemQuantityAmount,
      required this.itemName,
      required this.itemCategory});

  int? index;
  String? itemName;
  String? itemCategory;
  String? itemQuantity;
  String? itemQuantityAmount;
  String? itemPurchasePlace;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(children: [
              Text(
                "Name: ${itemName!}",
                overflow: TextOverflow.ellipsis,
              )
            ]),
            Wrap(children: [
              Text(
                "Category: ${itemCategory!}",
                overflow: TextOverflow.ellipsis,
              ),
            ]),
          ],
        ),
        trailing:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(
            children: [
              Wrap(
                children: [
                  Text(
                    "Place: ${itemPurchasePlace!}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          Wrap(children: [
            Text(
              "Quantity: $itemQuantityAmount $itemQuantity",
              overflow: TextOverflow.ellipsis,
            ),
          ])
        ]),
      ),
    );
  }
}
