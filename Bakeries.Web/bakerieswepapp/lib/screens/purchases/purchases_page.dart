import 'package:bakerieswepapp/Screens/finished_product_inventory/widgets/add_edit_dialog/add_finished_product_inventory_dialog.dart';
import 'package:flutter/material.dart';

import 'widgets/add_purchase_dialog/add_purchase_dialog.dart';
import 'widgets/purchase_list.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class PurchasesPage extends StatelessWidget {
  const PurchasesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
 
      body: const PurchaseList(),
      floatingActionButton: 
       SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blue,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: Icon(Icons.inventory_outlined, color: Colors.white),
            backgroundColor: Colors.green,
            label: 'اضف عملية شراء لمخزون المواد الخام',
            onTap: () => _showAddPurchaseDialog(context),
          ),
          SpeedDialChild(
            child: Icon(Icons.store, color: Colors.white),
            backgroundColor: Colors.red,
            label: 'اضف عملية شراء للمعرض',
            onTap: () => _showAddFinishedProductInventoryDialog(context),
          ),
        ],
      ),
    
  
    );
  }

  void _showAddPurchaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddPurchaseDialog(
        isEdit: false,
        isFinishedProductInventory: false,
        onAdd: (newPurchase) {
          // Handle add callback
        },
      ),
    );
  }
  void _showAddFinishedProductInventoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddPurchaseDialog(
        isEdit: false,
        isFinishedProductInventory: true,
        onAdd: (newPurchase) {
          // Handle add callback
        },
      ),
    );
  }
}
