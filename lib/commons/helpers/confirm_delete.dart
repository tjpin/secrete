import 'package:flutter/material.dart';

confirmDelete(BuildContext cx, VoidCallback deleteAction) async {
  final ctx = Theme.of(cx);
  await showDialog(
      context: cx,
      builder: (cx) => Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: 120,
              child: Column(
                children: [
                  Text("Confirm",
                      style: ctx.textTheme.bodyMedium!
                          .copyWith(color: Colors.red)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        onPressed: () => Navigator.pop(cx),
                        child: const Text("Cancel"),
                      ),
                      MaterialButton(
                        onPressed: () {
                          deleteAction();
                          Navigator.pop(cx);
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
}
