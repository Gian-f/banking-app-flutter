import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WalletSection extends StatefulWidget {
  const WalletSection({Key? key}) : super(key: key);

  @override
  _WalletSectionState createState() => _WalletSectionState();
}

class _WalletSectionState extends State<WalletSection> {
  bool isTotalVisible = false;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: false,
      child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IntrinsicHeight(
              child: Column(
            children: [
              Row(
                children: [
                  const Text("Saldo", style: TextStyle(fontSize: 18)),
                  IconButton(
                      icon: Icon(isTotalVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () {
                        setState(() {
                          isTotalVisible = !isTotalVisible;
                        });
                      })
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("R\$",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 6,
                  ),
                  if (isTotalVisible)
                    const Text("500,00",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold))
                  else
                    Container(
                      height: 10,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                ],
              )
            ],
          ))),
    );
  }
}
