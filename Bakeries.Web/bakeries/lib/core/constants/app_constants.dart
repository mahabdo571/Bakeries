class AppConstants {
  // القيم المشتركة
  static const List<String> unitOfMeasureOptions = ['كيلو غرام', 'غرام', 'لتر'];
  static const List<String> paymentMethodOptions = ['كاش', 'شيك'];
  static const List<String> statusOptions = [
    'مدفوع',
    'غير مدفوع',
    'مؤرشف',
    'ملغي'
  ];

  // رسائل التحقق
  static const String requiredFieldMessage = 'هذا الحقل مطلوب';
  static const String invalidNumberMessage = 'الرجاء إدخال رقم صحيح';
}
