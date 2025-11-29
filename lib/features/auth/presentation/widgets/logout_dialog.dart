import 'package:alsama/features/auth/presentation/widgets/default_button.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "تسجيل الخروج",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "انت متأكد انك تريد تسجيل الخروج ؟",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:  DefaultButton(
                    backgroundColor: Colors.white,

                   onTap: ( ) {
                     
                   },
                   text: ' لا اريد ',
                   textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14

                   ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 40
                    ,width: 155,
                    child: DefaultButton(
                    
                     onTap: () {
                       
                     },
                     text: 'تسجيل الخروج',
                     textStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white
                     ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Usage:
// showDialog(
//   context: context,
//   builder: (context) => const LogoutDialog(),
// );
