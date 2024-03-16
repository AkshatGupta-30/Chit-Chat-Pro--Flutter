import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';

class BottomView extends StatelessWidget {
  BottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Hint Text',
            suffixIcon: CloseButton() // TODO : Remove Text
          ),
        ),
        Gap(10),
        ElevatedButton(
          onPressed: () {}, // TODO : Submit enable disable
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Submit', style: Theme.of(context).primaryTextTheme.headlineSmall,),
              Gap(2),
              Iconify(MaterialSymbols.send_rounded, size: 32, color: Colors.white,)
            ],
          ),
        ),
        Gap(10),
        Text(
          "Chit Chat Pro, Enhanced with ChatGPT Brilliance.",
          style: Theme.of(context).primaryTextTheme.bodySmall,
        )
      ],
    );
  }
}
