import 'package:flutter/material.dart';
import 'package:pre_test_submission/models/location.dart';
import 'package:pre_test_submission/views/error_dialog.dart';

class LocalService {
  BuildContext context;

  LocalService(this.context);

  Future<List<Location>> getLocations() async {
    try {
      String source = await DefaultAssetBundle.of(context).loadString('data/location.json');
      return locationFromJson(source);
    } catch (e) {
      showErrorDialog(context, "Failed to get locations: $e");
    }
    throw Exception("Failed to get locations");
  }

  List<Location>? getProvince(List<Location>? locations) {
    return locations?.where((element) => element.parentNid == 0).toList();
  }

  List<Location>? getRegency(List<Location>? locations, Location? currentProvince) {
    return locations?.where((element) => element.parentNid == currentProvince?.nid).toList();
  }
}
