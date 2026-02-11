import 'package:flutter/material.dart';

class AddressFormWidget extends StatefulWidget {
  final void Function(Map<String, String>) onAddressChanged;
  
  const AddressFormWidget({
    super.key,
    required this.onAddressChanged,
  });

  @override
  State<AddressFormWidget> createState() => _AddressFormWidgetState();
}

class _AddressFormWidgetState extends State<AddressFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _countryController = TextEditingController(text: 'مصر');

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _notifyAddressChanged() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onAddressChanged({
        'fullName': _fullNameController.text,
        'phone': _phoneController.text,
        'addressLine1': _addressLine1Controller.text,
        'addressLine2': _addressLine2Controller.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'postalCode': _postalCodeController.text,
        'country': _countryController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildTextField(
            controller: _fullNameController,
            label: 'الاسم الكامل',
            icon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال الاسم الكامل';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _phoneController,
            label: 'رقم الهاتف',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال رقم الهاتف';
              }
              if (value.length < 10) {
                return 'رقم الهاتف غير صحيح';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _addressLine1Controller,
            label: 'العنوان (السطر الأول)',
            icon: Icons.location_on_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال العنوان';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _addressLine2Controller,
            label: 'العنوان (السطر الثاني) - اختياري',
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _stateController,
                  label: 'المحافظة',
                  icon: Icons.map_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال المحافظة';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTextField(
                  controller: _cityController,
                  label: 'المدينة',
                  icon: Icons.location_city_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال المدينة';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _countryController,
                  label: 'الدولة',
                  icon: Icons.flag_outlined,
                  enabled: false,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTextField(
                  controller: _postalCodeController,
                  label: 'الرمز البريدي',
                  icon: Icons.markunread_mailbox_outlined,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool enabled = true,
  }) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
            textDirection: TextDirection.rtl,
      
        decoration: InputDecoration(
      
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14),
          prefixIcon: Icon(icon, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffE0E2E3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffE0E2E3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff821F40), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          filled: true,
          fillColor: enabled ? Colors.white : const Color(0xffF3F5F6),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        textAlign: TextAlign.right,
        validator: validator,
        keyboardType: keyboardType,
        
        enabled: enabled,
        onChanged: (_) => _notifyAddressChanged(),
      ),
    );
  }
}
