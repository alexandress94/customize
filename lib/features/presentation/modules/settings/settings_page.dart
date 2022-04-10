import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/modules/settings/controllers/settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60.h),
        child: AppBar(
          centerTitle: false,
          elevation: 0.0,
          title: Text(
            'Configurações',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
