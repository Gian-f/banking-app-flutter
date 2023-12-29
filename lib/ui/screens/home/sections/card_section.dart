import 'package:banking_app/utils/util.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/card.dart';
import '../../../../ui/theme/colors.dart';

List<CreditCard> creditCards = [
  CreditCard(
    cardType: "VISA",
    cardNumber: "3664 7865 3786 3976",
    cardName: "Business",
    balance: 456.467,
    color: [PurpleStart, PurpleEnd],
  ),
  CreditCard(
    cardType: "VISA",
    cardNumber: "3664 7865 3786 3976",
    cardName: "Business",
    balance: 456.467,
    color: [BlueStart, BlueEnd],
  ),
  CreditCard(
    cardType: "VISA",
    cardNumber: "3664 7865 3786 3976",
    cardName: "Business",
    balance: 456.467,
    color: [GreenStart, GreenEnd],
  ),
  CreditCard(
    cardType: "ADD_CARD",
    cardNumber: "",
    cardName: "Adicionar",
    balance: 0,
    color: [OrangeStart, OrangeEnd],
  ),
];

class CardsSection extends StatelessWidget {
  const CardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: creditCards.length,
              itemBuilder: (context, index) {
                if (creditCards[index].cardType == "ADD_CARD") {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: index == 0 ? 16 : 0, right: 16),
                    child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(25),
                        child: _buildAddCardButton()),
                  );
                } else {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: index == 0 ? 6 : 0, right: 16),
                    child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(25),
                        child: CardItem(creditCards[index])),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final CreditCard card;

  const CardItem(this.card, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: card.color,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
              card.cardType == "VISA"
                  ? 'assets/ic_visa.png'
                  : 'assets/ic_mastercard.png',
              width: 60),
          Text(card.cardName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
          Text('\$${card.balance.toStringAsFixed(2)}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          Text(hideCreditCardNumber(card.cardNumber),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

Widget _buildAddCardButton() {
  return Container(
    width: 250,
    height: 160,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [OrangeStart, OrangeEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(25),
    ),
    padding: const EdgeInsets.all(12),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.add_card_outlined, color: Colors.white, size: 44),
        Text('Adicionar',
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
