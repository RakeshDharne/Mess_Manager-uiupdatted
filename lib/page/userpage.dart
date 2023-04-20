import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sub_mgmt/page/utils/admin_preferences.dart';
import 'package:sub_mgmt/widget/appbarwidget.dart';
import 'package:sub_mgmt/widget/navigation_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/profilewidget.dart';
import 'editprofile.dart';
import 'model/admin.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  static const menuItems = <String>[
    'English',
    'Hindi',
    'Marathi',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn1SelectedVal = 'English';

  //second menu bar

  // static const menuItems1 = <String>[
  //   'Light',
  //   'Dark',
  // ];
  // final List<DropdownMenuItem<String>> _dropDownMenuItems1 = menuItems
  //     .map(
  //       (String value) => DropdownMenuItem<String>(
  //     value: value,
  //     child: Text(value),
  //   ),
  // )
  //     .toList();
  // final List<PopupMenuItem<String>> _popUpMenuItems1 = menuItems
  //     .map(
  //       (String value) => PopupMenuItem<String>(
  //     value: value,
  //     child: Text(value),
  //   ),
  // )
  //     .toList();
  //
  // String _btn1SelectedVal1 = 'Light';

  @override
  Widget build(BuildContext context) {
    final admin = AdminPreferences.getAdmin();
    return Scaffold(
        appBar: buildAppBar(context, "Profile".tr),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                ProfileWidget(
                  imagePath: admin.imagePath,
                  onClicked: () async {
                    print(admin.imagePath);
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditProfile()));
                    setState(() {});
                  },
                ),

                const SizedBox(height: 24),
                buildName(admin),

                ListTile(
                  // contentPadding: EdgeInsets.all(20.0),
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 0),

                  title: Text(
                    "Change_lan".tr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  trailing: DropdownButton<String>(
                    // Must be one of items.value.
                    value: _btn1SelectedVal,
                    onChanged: (String? newValue) {
                      _language(newValue!);
                    },
                    items: this._dropDownMenuItems,
                  ),
                ),

                //not working dark mode option

                // ListTile(
                //   // contentPadding: EdgeInsets.all(20.0),
                //   contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                //   title:  Text("Change Mode".tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                //   trailing: DropdownButton<String>(
                //     // Must be one of items.value.
                //     value: _btn1SelectedVal1,
                //     onChanged: (String? newValue) {
                //       _language(newValue!);
                //     },
                //     items: this._dropDownMenuItems1,
                //
                //   ),
                //
                //
                // ),
              ],
            ),
          ],
        ));
  }

  void _language(String newValue) {
    setState(() => _btn1SelectedVal = newValue);
    if (newValue == 'Hindi') {
      var local = Locale('hi', 'IN');
      Get.updateLocale(local);
    } else if (newValue == 'English') {
      var local1 = Locale('en', 'US');
      Get.updateLocale(local1);
    } else {
      var local2 = Locale('mr', 'IN');
      Get.updateLocale(local2);
    }
  }

  Widget buildName(Admin admin) => Column(
        children: [
          Text(admin.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )),
          const SizedBox(height: 4),
          Text(
            admin.email,
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      );
}

// class UserPage extends StatelessWidget {
//   const UserPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final admin = AdminPreferences.getUser();
//     return Scaffold(
//       appBar: buildAppBar(context, "User"),
//       body: ListView(
//         physics: BouncingScrollPhysics(),
//         children: [
//           ProfileWidget(
//             imagePath: admin.imagePath,
//             onClicked: () async {
//               await Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfile()));
//               setState(() {});
//             },
//           ),
//           const SizedBox(height: 24),
//           buildName(admin),
//         ],
//       )
//     );
//   }
//
//   Widget buildName(Admin admin) => Column(
//     children: [
//       Text(
//         admin.name,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 24,
//         )
//       ),
//       const SizedBox(height: 4),
//       Text(
//         admin.email,
//         style: TextStyle(
//           color: Colors.grey,
//         ),
//       )
//     ],
//   );
// }
