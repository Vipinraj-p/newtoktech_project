import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UserHomeScreeenServices extends ChangeNotifier {
  String fileName = "";
  var filePath;
  int totalRow = 0;
  var location;
  Set<String> setlocation = {};
  filePick() async {
    //int index = 0;
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['xlsx'],
      type: FileType.custom,
    );
    if (result == null) {
      fileName = "";
      filePath = "";
      notifyListeners();
      return;
    }
    fileName = result.files.first.name;
    filePath = result.files.first.path;
    var bytes = File(filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    // log(TextCellValue('location').toString());
    // var cell = excel[fileName].cell(CellIndex.indexByString('A1'));
    // cell.value = TextCellValue('Some Text');
    // log(cell.value as String, name: "cell value");
    for (var table in excel.tables.keys) {
      totalRow = excel.tables[table]!.maxRows;
      // log(table.toString(), name: "table");
      // log(table.toString(), name: "table");
      // log(excel.tables[table]!.maxColumns.toString(), name: "table");
      // log(excel.tables[table]!.maxRows.toString(), name: "table");
      for (var row in excel.tables[table]!.rows) {
        // indexnumber.add(index + 1);

        location = row.first!.value.toString();
        setlocation.add(location);
        notifyListeners();
        // log(row.toString(), name: "row");
        log(row.first!.value.toString(), name: "location");

        notifyListeners();
        // log(excel.sheets.entries.iterator.toString(), name: "entries");
      }
    }

    notifyListeners();
    // log(result.files.first.name, name: "result.files.first.name");
    // log(result.files.first.size.toString());
    // log(result.files.first.extension.toString());
    // log(result.files.first.path.toString());
  }
}
