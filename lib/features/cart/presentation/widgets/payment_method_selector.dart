import 'package:flutter/material.dart';
import '../../../orders/domain/entities/order.dart';

class PaymentMethodSelector extends StatefulWidget {
  final void Function(PaymentMethod) onPaymentMethodChanged;
  
  const PaymentMethodSelector({
    super.key,
    required this.onPaymentMethodChanged,
  });

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  PaymentMethod _selectedMethod = PaymentMethod.cashOnDelivery;

  final Map<PaymentMethod, Map<String, dynamic>> _paymentMethods = {
    PaymentMethod.cashOnDelivery: {
      'title': 'الدفع عند الاستلام',
      'subtitle': 'ادفع نقداً عند استلام الطلب',
      'icon': Icons.payments_outlined,
    },
    PaymentMethod.creditCard: {
      'title': 'بطاقة ائتمان',
      'subtitle': 'Visa, Mastercard, American Express',
      'icon': Icons.credit_card,
    },
    PaymentMethod.debitCard: {
      'title': 'بطاقة مدين',
      'subtitle': 'ادفع مباشرة من حسابك البنكي',
      'icon': Icons.credit_card_outlined,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _paymentMethods.entries.map((entry) {
        final method = entry.key;
        final data = entry.value;
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedMethod = method;
              });
              widget.onPaymentMethodChanged(method);
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _selectedMethod == method
                    ? const Color(0xffFFF5F8)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _selectedMethod == method
                      ? const Color(0xff821F40)
                      : const Color(0xffE0E2E3),
                  width: _selectedMethod == method ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Radio<PaymentMethod>(
                    value: method,
                    groupValue: _selectedMethod,
                    onChanged: (PaymentMethod? value) {
                      if (value != null) {
                        setState(() {
                          _selectedMethod = value;
                        });
                        widget.onPaymentMethodChanged(value);
                      }
                    },
                    activeColor: const Color(0xff821F40),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    data['icon'] as IconData,
                    color: _selectedMethod == method
                        ? const Color(0xff821F40)
                        : const Color(0xff55585B),
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['title'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _selectedMethod == method
                                ? const Color(0xff821F40)
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data['subtitle'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff55585B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
