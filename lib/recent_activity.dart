import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_app/transaction.dart';

class RecentActivity extends ConsumerWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider);
    final isExpanded = ref.watch(isExpandedProvider);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent activity',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  isExpanded
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.notifications, size: 20),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '5',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: !isExpanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: transactions.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (_, __) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final t = transactions[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(t['avatar']),
                        radius: 28,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: t['name'].split(' ')[0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        ' ${t['name'].split(' ').skip(1).join(' ')}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              t['datetime'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${t['amount'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: t['isCredit'] ? Colors.green : Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
