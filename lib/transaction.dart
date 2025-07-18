// lib/transaction/transaction_screen.dart
import 'package:flutter/material.dart';
import 'package:wallet_app/header.dart';
import 'package:wallet_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_app/recent_activity.dart';

final isExpandedProvider = StateProvider<bool>((ref) => false);
final isShowRowCardsProvider = StateProvider<bool>((ref) => false);

void whenPressWallet(WidgetRef ref, CardModel currentCardList) {
  ref.read(isExpandedProvider.notifier).state = !ref.read(isExpandedProvider);
  Future.delayed(const Duration(milliseconds: 400), () {
    ref.read(isShowRowCardsProvider.notifier).state = true;
  });

  // ref.read(cardListProvider.notifier).state = [
  //   currentCardList,
  //   ...ref.read(cardListProvider).where((card) => card != currentCardList),
  // ];
}

final transactionsProvider = Provider<List<Map<String, dynamic>>>(
  (ref) => [
    {
      'name': 'Kathryn Murphy',
      'avatar': 'https://randomuser.me/api/portraits/women/1.jpg',
      'datetime': '06 July 2025 12:55 PM',
      'amount': 928.41,
      'isCredit': false,
    },
    {
      'name': 'Albert Flores',
      'avatar': 'https://randomuser.me/api/portraits/men/2.jpg',
      'datetime': '05 July 2025 18:45 PM',
      'amount': 767.50,
      'isCredit': false,
    },
    {
      'name': 'Marvin McKinney',
      'avatar': 'https://randomuser.me/api/portraits/men/3.jpg',
      'datetime': '04 July 2025 15:33 PM',
      'amount': 169.43,
      'isCredit': true,
    },
    {
      'name': 'Eleanor Pena',
      'avatar': 'https://randomuser.me/api/portraits/women/4.jpg',
      'datetime': '03 July 2025 02:11 PM',
      'amount': 601.13,
      'isCredit': false,
    },
    {
      'name': 'Brooklyn Simmons',
      'avatar': 'https://randomuser.me/api/portraits/women/7.jpg',
      'datetime': '02 July 2025 10:32 PM',
      'amount': 275.43,
      'isCredit': false,
    },
    {
      'name': 'Darlene Robertson',
      'avatar': 'https://randomuser.me/api/portraits/women/8.jpg',
      'datetime': '02 July 2025 10:32 PM',
      'amount': 475.22,
      'isCredit': false,
    },
  ],
);

final cardListProvider = StateProvider<List<CardModel>>(
  (ref) => [
    CardModel(
      bank: 'Visa',
      number: '23-55-22 99812374',
      balance: 539.56,
      color: Colors.green,
    ),
    CardModel(
      bank: 'MasterCard',
      number: '26-97-11 12345678',
      balance: 2334.56,
      color: Colors.red,
    ),
    CardModel(
      bank: 'American Express',
      number: '12-34-56 98765432',
      balance: 14.56,
      color: Colors.cyan,
    ),
  ],
);

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({super.key});

  @override
  ConsumerState<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(isShowRowCardsProvider, (previous, next) {
      if (!next && _scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    void whenPressRowCards(WidgetRef ref, CardModel currentCardList) {
      ref.read(cardListProvider.notifier).state = [
        currentCardList,
        ...ref.read(cardListProvider).where((card) => card != currentCardList),
      ];

      _scrollController.animateTo(
        0,
        duration: const Duration(microseconds: 1),
        curve: Curves.ease,
      );
      ref.read(isExpandedProvider.notifier).state = true;
      ref.read(isShowRowCardsProvider.notifier).state = false;
    }

    final isExpanded = ref.watch(isExpandedProvider);
    final isShowRowCards = ref.watch(isShowRowCardsProvider);
    final cardList = ref.watch(cardListProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(top: 0, left: 0, right: 0, child: Header()),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: isExpanded ? DEVICE_HEIGHT * 0.12 : DEVICE_HEIGHT * 0.52,
              left: MediaQuery.of(context).size.width * 0.06,
              right: MediaQuery.of(context).size.width * 0.06,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/wallet_back.png',
                  height: DEVICE_HEIGHT * 0.31,
                  width: DEVICE_WIDTH * 0.82,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: isExpanded ? DEVICE_HEIGHT * 0.13 : DEVICE_HEIGHT * 0.1,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: isShowRowCards ? 0.0 : 1.0,
                child: GestureDetector(
                  onTap: () => whenPressWallet(ref, cardList[0]),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: 180,
                    width: 360,
                    child: buildCard(cardList[0]),
                  ),
                ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: isExpanded ? DEVICE_HEIGHT * 0.18 : DEVICE_HEIGHT * 0.1,
              left: DEVICE_WIDTH * 0.1,
              right: DEVICE_WIDTH * 0.1,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: isShowRowCards ? 0.0 : 1.0,
                child: GestureDetector(
                  onTap: () => whenPressWallet(ref, cardList[1]),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: 180,
                    width: 360,
                    child: buildCard(cardList[1]),
                  ),
                ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: isExpanded ? DEVICE_HEIGHT * 0.235 : DEVICE_HEIGHT * 0.1,
              left: DEVICE_WIDTH * 0.1,
              right: DEVICE_WIDTH * 0.1,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: isShowRowCards ? 0 : 1.0,
                child: GestureDetector(
                  onTap: () => whenPressWallet(ref, cardList[2]),

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: 180,
                    width: 360,
                    child: buildCard(cardList[2]),
                  ),
                ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: isExpanded ? DEVICE_HEIGHT * 0.235 : DEVICE_HEIGHT * 0.1,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: isShowRowCards
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 40),
                    GestureDetector(
                      onTap: () => whenPressRowCards(ref, cardList[2]),

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        height: 180,
                        width: 360,
                        child: buildCard(cardList[2]),
                      ),
                    ),

                    SizedBox(width: 40), // Spacing before first card
                    GestureDetector(
                      onTap: () => whenPressRowCards(ref, cardList[1]),

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        height: 180,
                        width: 360,
                        child: buildCard(cardList[1]),
                      ),
                    ),

                    SizedBox(width: 40), // Spacing between cards
                    GestureDetector(
                      onTap: () => whenPressRowCards(ref, cardList[0]),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        height: 180,
                        width: 360,
                        child: buildCard(cardList[0]),
                      ),
                    ),
                    SizedBox(width: 40), // Spacing before first card
                  ],
                ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: isExpanded ? DEVICE_HEIGHT * 0.11 : DEVICE_HEIGHT * 0.5,
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.02,
              child: GestureDetector(
                onTap: () => whenPressWallet(ref, cardList[2]),

                child: Image.asset(
                  'assets/wallet_front.png',
                  width: DEVICE_WIDTH,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),

            Positioned(
              top: DEVICE_HEIGHT * 0.45,
              right: 0,
              left: 0,
              child: RecentActivity(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCard(CardModel cardData) {
  return Container(
    width: 360,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          cardData.color.withOpacity(0.85),
          cardData.color.withOpacity(0.65),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: cardData.color.withOpacity(0.4),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              cardData.bank,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              '\$${cardData.balance.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.account_balance, color: Colors.white70, size: 18),
            const SizedBox(width: 6),
            Text(
              cardData.number,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: const [
            Text(
              'Add money',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Icon(Icons.credit_card, color: Colors.white70, size: 20),
          ],
        ),
      ],
    ),
  );
}

class CardModel {
  final String bank;
  final String number;
  final double balance;
  final Color color;

  CardModel({
    required this.bank,
    required this.number,
    required this.balance,
    required this.color,
  });
}
