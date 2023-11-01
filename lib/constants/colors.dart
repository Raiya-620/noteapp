
import 'package:flutter/material.dart';

final List<String> noteDescription=[];
final List<String> noteHeading=[];
TextEditingController noteHeadingController=new TextEditingController();
TextEditingController noteDiscriptionController=new TextEditingController();
FocusNode textSecondFocusNode=new FocusNode();

int notesHeaderMaxLength=25;
int notesDescriptionMaxLines=10;
int notesDescriptionMaxLength=10;
String deletedNoteHeading="";
String deletedNoteDescription="";


List <Color> noteColor=[
  const Color(0xFFFCE4EC),//pink color
  const Color(0xFFE8F5E9),//green color
  const Color(0xFFE3F2FD),//blue color
  const Color(0xFFFFF3E0),//orange color
  const Color(0xFFE8EAF6),//Colors.indigo[50],
  const Color(0xFFFFEBEE),//red color
   const Color(0xFFFFF8E1),//yellow color
  const Color(0xFFEFEBE9),//brown color
  const Color(0xFFE0F2F1),//teal color
  const Color(0xFFF3E5F5),//purple color
];
List <Color> noteMarginColor=[
  const Color(0xFFF06292),//pink[300]
  const Color(0xFF81C784),//Colors.green[300],
  const Color(0xFF64B5F6),//Colors.blue[300],
  const Color(0xFFFFB74D),//Colors.orange[300],
  const Color(0xFF7986CD),//Colors.indigo[300],
  const Color(0xFFE57373),//Colors.red[300],
  const Color(0xFFFFF176),//Colors.yellow[300],
  const Color(0xFFA1887F),//Colors.brown[300],
  const Color(0xFF4DB6AC),//Colors.teal[300],
  const Color(0xFFBA68C8),//Colors.purple[300],
];