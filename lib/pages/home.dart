import 'dart:async';
import 'dart:html';

import 'package:dapp/models/network_model.dart';
import 'package:dapp/pages/settings_menu.dart';
import 'package:dapp/utils/app_snackbar.dart';
import 'package:dapp/utils/app_theme.dart';
import 'package:dapp/utils/images_path.dart';
import 'package:dapp/utils/strings.dart';
import 'package:dapp/utils/utils.dart';
import 'package:dapp/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/browser.dart';
import 'package:get/get.dart';

import 'center_box.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final eth = window.ethereum;
  Web3Client? client;
  CredentialsWithKnownAddress? credentials;
  String network = 'Unknown';
  EtherAmount? ethBalance;

  // bool loadingForConnectToWallet = false;
  bool showSettingsMenu = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      // connectToWallet();
      if (eth != null) {
        showSnackBar(eth!.isConnected().toString());
        eth!.chainChanged.listen((event) {
          showSnackBar(event.toString());
        });

        eth!.stream('accountsChanged').listen((event) {
          showSnackBar(event.toString());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (showSettingsMenu)
            setState(() {
              showSettingsMenu = false;
            });
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Get.theme.primaryColor.withOpacity(0.1),
                Get.theme.primaryColor.withOpacity(0.07),
                Get.theme.primaryColor.withOpacity(0.0),
              ],
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(Images.LOGO, width: 35.0, height: 35.0),
                      Row(
                        children: [
                          credentials != null
                              ? info()
                              : AppButton(
                                  title: Strings.CONNECT_TO_WALL,
                                  onTap: connectToWallet,
                                ),
                          const SizedBox(width: 16.0),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                showSettingsMenu = !showSettingsMenu;
                              });
                            },
                            icon: Icon(Icons.menu),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CenterBox(credentials, connectToWallet),
                ],
              ),
              Positioned(
                right: 0.0,
                top: 50.0,
                child: Visibility(
                  child: SettingsMenu(credentials != null),
                  visible: showSettingsMenu,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget info() {
    String address = credentials!.address.toString();
    address = address.substring(0, 6) +
        '....' +
        address.substring(address.length - 4);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppTheme.yellow.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            network,
            style: TextStyle(fontSize: 16.0, color: AppTheme.yellow),
          ),
        ),
        const SizedBox(width: 8.0),
        Visibility(
          visible: MediaQuery.of(context).size.width > 520.0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
            ),
            child: Text(
              castWeiToEth(ethBalance!.getInWei).toString() + ' ETH',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Text(address, style: TextStyle(fontSize: 16.0)),
          ),
        ),
      ],
    );
  }

  void connectToWallet() async {
    if (eth == null) {
      showSnackBar('MetaMask is not available');
      return;
    }

    // setState(() {
    //   loadingForConnectToWallet = true;
    // });

    client = Web3Client.custom(eth!.asRpcService());

    credentials = await eth!.requestAccount();

    for (NetworkModel nm in networks)
      if (nm.id == await client!.getNetworkId()) {
        network = nm.name;
        break;
      }

    ethBalance = await client!.getBalance(credentials!.address);

    setState(() {});
    //
    // if (eth!.isConnected())
    //   showSnackBar('okk connected');
    // else
    //   showSnackBar('oops :(');
  }
}
