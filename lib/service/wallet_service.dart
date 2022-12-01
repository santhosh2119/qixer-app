import 'package:flutter/material.dart';
import 'package:qixer/view/utils/others_helper.dart';

class WalletService with ChangeNotifier {
  var walletHistory;

  bool isloading = false;
  bool hasWalletHistory = true;

  setLoadingStatus(bool status) {
    isloading = status;
    notifyListeners();
  }

  var amountToAdd;

  setAmount(v) {
    amountToAdd = v;
    notifyListeners();
  }

  Future<bool> depositeToWallet(BuildContext context) async {
    return true;
  }

  // Fetch subscription history
  // fetchWalletHistory(BuildContext context) async {
  //   var connection = await checkConnection();
  //   if (!connection) return;

  //   if (walletHistory != null) return;

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('token');

  //   setLoadingStatus(true);

  //   var header = {
  //     //if header type is application/json then the data should be in jsonEncode method
  //     "Accept": "application/json",
  //     // "Content-Type": "application/json"
  //     "Authorization": "Bearer $token",
  //   };

  //   var response = await http.get(
  //       Uri.parse('$baseApi/seller/subscription/history'),
  //       headers: header);

  //   final decodedData = jsonDecode(response.body);

  //   if (response.statusCode == 201 &&
  //       decodedData['subscription_history'].isNotEmpty) {
  //     final data = SubscriptionHistoryModel.fromJson(jsonDecode(response.body));
  //     subsHistoryList = data.subscriptionHistory;
  //     notifyListeners();
  //   } else {
  //     print('Error fetching subscription history' + response.body);

  //     hasSubsHistory = false;
  //     notifyListeners();
  //   }
  // }

  Future<bool> validate(BuildContext context, isFromDepositeToWallet) async {
    if (isFromDepositeToWallet && amountToAdd == null) {
      OthersHelper().showToast('You must enter an amount', Colors.black);
      return false;
    }
    if (isFromDepositeToWallet && double.tryParse(amountToAdd) == null) {
      // user entered non integer value
      OthersHelper().showToast('Please enter a valid amount', Colors.black);
      return false;
    }
    return true;
  }
}
