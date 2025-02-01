import 'package:bakerieswepapp/models/production_process_detail.dart';
import 'package:bakerieswepapp/services/production_process_detail_service.dart';
import 'package:flutter/material.dart';

class DetailsDialog extends StatefulWidget {
  final int productionId;
  DetailsDialog({super.key, required this.productionId});

  @override
  State<DetailsDialog> createState() => _DetailsDialogState();
}

class _DetailsDialogState extends State<DetailsDialog> {
  List<ProductionProcessDetail> _items = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
        if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('متتبع الاستهلاك'),
        centerTitle: true,
      ),
      body: Center(
        child: AlertDialog(
          title: Text('العناصر المستهلكة', textAlign: TextAlign.center),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: _items.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                final item = _items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _items[index].ItemName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${_items[index].Quantity} ${_items[index].UnitOfMeasure}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('إغلاق'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadItems() async {
    try {
      final items = await ProductionProcsessDetailService
          .getProductionProcessDetailByPruductionId(widget.productionId);
      setState(() {
        _items = items;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في تحميل الأصناف: $e')),
      );
    }
  }
}
