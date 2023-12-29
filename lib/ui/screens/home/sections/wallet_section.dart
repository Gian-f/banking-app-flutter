import 'package:flutter/material.dart';

class WalletSection extends StatefulWidget {
  const WalletSection({Key? key}) : super(key: key);

  @override
  _WalletSectionState createState() => _WalletSectionState();
}

class _WalletSectionState extends State<WalletSection> {
  bool isTotalVisible = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 30),
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
              children: [
                const Text("R\$",
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 6,
                ),
                if (isTotalVisible)
                  const Text("44.000,00",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold))
                else
                  const Text("****",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold))
              ],
            )
          ],
        ));
  }
}
