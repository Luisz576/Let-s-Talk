import 'package:flutter/material.dart';
import 'package:letstalk/utils/app_colors.dart';

class MessageTileError extends StatelessWidget {
  const MessageTileError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.fifthColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: const [
            Icon(Icons.lock_clock,
              color: AppColors.errorColor,
            ),
            Text("Não foi possível carregar essa mensagem",
              style: TextStyle(
                color: AppColors.errorColor,
                fontSize: 12,
                fontStyle: FontStyle.italic
              ),
            )
          ],
        ),
      )
    );
  }
}