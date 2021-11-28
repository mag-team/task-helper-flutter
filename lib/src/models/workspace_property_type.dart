import 'package:flutter/material.dart';

class WorkspacePropertyType {
  final String name;
  final Icon icon;

  const WorkspacePropertyType._(this.name, this.icon);

  static const text = WorkspacePropertyType._(
    'Text',
    Icon(Icons.text_fields),
  );
  static const select = WorkspacePropertyType._(
    'Select',
    Icon(Icons.arrow_drop_down_circle_outlined),
  );

  static const values = [text, select];
}
