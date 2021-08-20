import 'package:dapp/utils/app_snackbar.dart';
import 'package:dapp/utils/images_path.dart';
import 'package:dapp/utils/strings.dart';
import 'package:dapp/utils/utils.dart';
import 'package:dapp/widgets/app_button.dart';
import 'package:dapp/widgets/app_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class CenterBox extends StatefulWidget {
  Web3Client? client;
  CredentialsWithKnownAddress? credentials;
  GestureTapCallback connectWallet;

  CenterBox(this.client, this.credentials, this.connectWallet);

  @override
  _CenterBoxState createState() => _CenterBoxState();
}

class _CenterBoxState extends State<CenterBox> {
  AppTextFormField? toAddress;
  AppTextFormField? amount;

  Widget amountSuffix() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ETH', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8.0),
            Image.asset(Images.ETH, width: 24.0, height: 24.0),
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    amount = AppTextFormField(
      hint: Strings.AMOUNT.tr,
      textInputType: TextInputType.number,
      autoValidateMode: false,
      onChanged: (val) {
        if (val!.length <= 1) setState(() {});
      },
    );
    toAddress = AppTextFormField(
      hint: Strings.ADDRESS.tr,
      nextFocusNode: amount!.focusNode,
      autoValidateMode: false,
      onChanged: (val) {
        if (val!.length <= 1) setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    toAddress!.suffixIcon = pasteSuffix(toAddress!.controller);
    amount!.suffixIcon = amountSuffix();

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(top: 68.0),
      width: 480.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: darkModeEnabled() ? Colors.black : Colors.grey.shade300,
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              Strings.TRANSACTION.tr,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            child: toAddress!,
            decoration: BoxDecoration(
              color: darkModeEnabled()
                  ? Colors.grey.shade900
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          const SizedBox(height: 4.0),
          Container(
            child: amount!,
            decoration: BoxDecoration(
              color: darkModeEnabled()
                  ? Colors.grey.shade900
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            height: 50.0,
            child: AppButton(
              title: widget.credentials == null
                  ? Strings.CONNECT_TO_WALL.tr
                  : toAddress!.controller.text == ''
                      ? Strings.ADDRESS.tr
                      : amount!.controller.text == ''
                          ? Strings.AMOUNT.tr
                          : Strings.SEND.tr,
              onTap: widget.credentials == null
                  ? widget.connectWallet
                  : amount!.controller.text == '' ||
                          toAddress!.controller.text == ''
                      ? null
                      : send,
            ),
          ),
        ],
      ),
    );
  }

  void send() async {
    if (!isNumeric(amount!.controller.text) ||
        !toAddress!.controller.text.startsWith('0x')) {
      showSnackBar(
        '${Strings.PLEASE.tr} ${Strings.ENTER.tr} ${Strings.VALID_VALUE.tr}',
      );
      return;
    }

    /// result is trxHash
    String result = await widget.client!.sendTransaction(
      widget.credentials!,
      Transaction(
        to: EthereumAddress.fromHex(toAddress!.controller.text),
        gasPrice: EtherAmount.inWei(BigInt.from(1000000000)),
        maxGas: 21000,
        value: EtherAmount.fromUnitAndValue(
          EtherUnit.wei,
          castEthToWei(double.parse(amount!.controller.text)),
        ),
      ),
      fetchChainIdFromNetworkId: true,
    );

    showSnackBar(Strings.SUCCESS_DONE.tr);
    
    // eth.request(args)
    // eth.rawRequest(method)

    // final message = Uint8List.fromList(utf8.encode('Hello from web3dart'));
    // final signature = await credentials.signPersonalMessage(message);
    // print('Signature: ${base64.encode(signature)}');
  }
}
