import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BudgetToolTipsWidget extends ConsumerWidget {
  const BudgetToolTipsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
          child: Column(
            children: [
              Row(
                children: [Icon(Icons.lightbulb_rounded), Text('Tool Tips')],
              ),
              Text('data')
            ],
          ),
        ),
      );
}
