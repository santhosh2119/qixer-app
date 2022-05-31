import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/my_orders_service.dart';

class CreateTicketService with ChangeNotifier {
  //priority dropdown
  var priorityDropdownList = ['Urgent', 'High', 'Medium', 'Low'];
  var priorityDropdownIndexList = ['Urgent', 'High', 'Medium', 'Low'];
  var selectedPriority = 'Urgent';
  var selectedPriorityId = '';

  setPriorityValue(value) {
    selectedPriority = value;
    notifyListeners();
  }

  setSelectedPriorityId(value) {
    selectedPriorityId = value;
    notifyListeners();
  }

  //order list dropdown
  var orderDropdownList = [];
  var orderDropdownIndexList = [];
  var selectedOrder;
  var selectedOrderId;

  setOrderValue(value) {
    selectedOrder = value;
    notifyListeners();
  }

  setSelectedOrderId(value) {
    selectedOrderId = value;
    notifyListeners();
  }

  makeOrderlistEmpty() {
    orderDropdownList = [];
    orderDropdownIndexList = [];
    notifyListeners();
  }

  fetchOrderDropdown(BuildContext context) async {
    var orders = await Provider.of<MyOrdersService>(context, listen: false)
        .fetchMyOrders();
    if (orders != 'error') {
      for (int i = 0; i < orders.length; i++) {
        orderDropdownList.add('#${orders[i].id}');
        orderDropdownIndexList.add(orders[i].id);
      }
      selectedOrder = '#${orders[0].id}';
      selectedOrderId = orders[0].id;
      notifyListeners();
    }
  }
}
