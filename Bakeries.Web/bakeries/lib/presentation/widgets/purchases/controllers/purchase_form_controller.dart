import 'package:flutter/material.dart';
import 'dart:async';
import '/models/product.dart';
import '/models/purchase.dart';
import '/core/base/base_form_controller.dart';

class PurchaseFormController extends BaseFormController {
  final Purchase? initialPurchase;
  final List<Product> products;

  late Product? selectedProduct;
  late final TextEditingController itemDescriptionController;
  late final TextEditingController notesController;
  late final TextEditingController supplierNameController;
  late final TextEditingController supplierInvoiceNumberController;
  late final TextEditingController quantityController;
  late final TextEditingController unitPriceController;
  late final TextEditingController totalPriceController;
  late String selectedUnitOfMeasure;
  late String selectedPaymentMethod;
  late String selectedStatus;

  final List<String> unitOfMeasureOptions = ['كيلو غرام', 'غرام', 'لتر'];
  final List<String> paymentMethodOptions = ['كاش', 'شيك'];
  final List<String> statusOptions = ['مدفوع', 'غير مدفوع', 'مؤرشف', 'ملغي'];

  Timer? _debounceTimer;

  PurchaseFormController({
    this.initialPurchase,
    required this.products,
  }) {
    _initializeControllers();
  }

  void _initializeControllers() {
    // تهيئة المنتج المحدد
    selectedProduct = null;
    if (initialPurchase != null && products.isNotEmpty) {
      try {
        selectedProduct = products.firstWhere(
          (p) => p.id == initialPurchase!.itemId,
        );
      } catch (_) {
        selectedProduct = null;
      }
    }

    // تهيئة وحدة القياس
    selectedUnitOfMeasure = unitOfMeasureOptions.first;
    if (initialPurchase?.unitOfMeasure != null &&
        unitOfMeasureOptions.contains(initialPurchase!.unitOfMeasure)) {
      selectedUnitOfMeasure = initialPurchase!.unitOfMeasure;
    }

    // تهيئة طريقة الدفع
    selectedPaymentMethod = paymentMethodOptions.first;
    if (initialPurchase?.paymentMethod != null &&
        paymentMethodOptions.contains(initialPurchase!.paymentMethod)) {
      selectedPaymentMethod = initialPurchase!.paymentMethod;
    }

    // تهيئة الحالة
    selectedStatus = statusOptions.first;
    if (initialPurchase?.status != null &&
        statusOptions.contains(initialPurchase!.status)) {
      selectedStatus = initialPurchase!.status;
    }

    // تهيئة حقول النص
    itemDescriptionController =
        TextEditingController(text: initialPurchase?.itemDescription ?? '');
    notesController = TextEditingController(text: initialPurchase?.notes ?? '');
    supplierNameController =
        TextEditingController(text: initialPurchase?.supplierName ?? '');
    supplierInvoiceNumberController = TextEditingController(
        text: initialPurchase?.supplierInvoiceNumber ?? '');
    quantityController =
        TextEditingController(text: initialPurchase?.quantity.toString() ?? '');
    unitPriceController = TextEditingController(
        text: initialPurchase?.unitPrice.toString() ?? '');
    totalPriceController = TextEditingController(
        text: initialPurchase?.totalPrice.toString() ?? '');

    // إضافة المستمعين
    quantityController.addListener(_calculateTotalPrice);
    unitPriceController.addListener(_calculateTotalPrice);
  }

  void onProductChanged(Product? value) {
    selectedProduct = value;
  }

  void onUnitOfMeasureChanged(String? value) {
    if (value != null) {
      selectedUnitOfMeasure = value;
    }
  }

  void onPaymentMethodChanged(String? value) {
    if (value != null) {
      selectedPaymentMethod = value;
    }
  }

  void onStatusChanged(String? value) {
    if (value != null) {
      selectedStatus = value;
    }
  }

  void onQuantityChanged(String value) {
    debounce(_calculateTotalPrice);
  }

  void _calculateTotalPrice() {
    if (quantityController.text.isNotEmpty &&
        unitPriceController.text.isNotEmpty) {
      int quantity = int.tryParse(quantityController.text) ?? 0;
      double unitPrice = double.tryParse(unitPriceController.text) ?? 0;
      double totalPrice = quantity * unitPrice;
      totalPriceController.text = totalPrice.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    super.dispose();
    itemDescriptionController.dispose();
    notesController.dispose();
    supplierNameController.dispose();
    supplierInvoiceNumberController.dispose();
    quantityController.dispose();
    unitPriceController.dispose();
    totalPriceController.dispose();
  }
}
