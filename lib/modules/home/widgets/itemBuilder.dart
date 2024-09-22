import 'package:flutter/material.dart';

import '../../../core/cubit/cubit.dart';

class Itembuilder extends StatelessWidget {
  Itembuilder({
    super.key,
    context,
    required this.id,
    required this.data,
  });

  int id;
  String data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  MainCubit.get(context)
                      .launchURL(data);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Text(
                    data,
                    overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    MainCubit.get(context)
                        .deleteData(id);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey[300],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
