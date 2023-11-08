import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    notesDescriptionMaxLength=notesDescriptionMaxLines*notesDescriptionMaxLines;
  }

  @override
  void dispose() {
    super.dispose();
    noteDiscriptionController.dispose();
    noteHeadingController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: notesHeader(),
      ),
      body: noteHeading.length > 0
      ? buildNotes()
      :const Center(
        child: Text('Add Notes...',
        style: TextStyle(
          color: Colors.white
        ),
        ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: (){
            _settingModalBottomSheet(context);
          },
          child: const Icon(Icons.create),
          ),
    );
  }
  Widget buildNotes(){
    return  Padding(
      padding: const EdgeInsets.only(top:10,left:10,right: 10),
      child: ListView.builder(
        itemCount: noteHeading.length,
        itemBuilder: (context,int index){
          return Padding(padding: const EdgeInsets.only(bottom: 5.5),
          child: Dismissible(key: new UniqueKey(),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            setState(() {
              deletedNoteHeading=noteHeading[index];
              deletedNoteDescription=noteDescription[index];
              noteHeading.removeAt(index);
              noteDescription.removeAt(index);
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar
              (backgroundColor: Colors.purple,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Note Deleted'),
                  deletedNoteHeading!=""?GestureDetector(onTap: (){
                    setState(() {
                      if(deletedNoteHeading!=""){
                        noteHeading.add(deletedNoteHeading);
                        noteDescription.add(deletedNoteDescription);
                      }
                      deletedNoteHeading="";
                      deletedNoteDescription="";
                    });
                  },
                  child: const Text('Undo'),
                  )
                  :const SizedBox()
                ],
                ),
                ),
                );
            });
          },
          background: ClipRRect(
            borderRadius: BorderRadius.circular(5.5),
            child: Container(color: Colors.green,
            child: const Align(alignment: Alignment.centerLeft,
            child: Padding(padding: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete,
                color: Colors.white,
                ),
                Text('Delete',
                style: TextStyle(
                  color: Colors.white),
                  )
              ],
            ),
            ),
            ),
            ),
            ),
            secondaryBackground:ClipRRect(
            borderRadius: BorderRadius.circular(5.5),
            child: Container(color: Colors.red,
            child: const Align(alignment: Alignment.centerRight,
            child: Padding(padding: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete,
                color: Colors.white,
                ),
                Text('Delete',
                style: TextStyle(
                  color: Colors.white),
                  )
              ],
            ),
            ),
            ),
            ),
            ) ,
            child: noteList(index),
          ),
          );
        }),
      );
  }
  Widget noteList(int index){
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.5),
      child: Container(
        width: double.infinity,
        height: 100,
      decoration: BoxDecoration(
        color: noteColor[(index % noteColor.length).floor()],
        borderRadius: BorderRadius.circular(5.5)
        ),
        child: Center(
          child: Row(
            children: [
              Container(
                color: noteMarginColor[(index % noteMarginColor.length).floor()],
                width: 3.5,
                height: double.infinity,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(child: Text(
                        noteHeading[index],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                      ),
                      ),
                      const SizedBox(height: 2.5,),
                      Flexible(
                        child: Container(
                          height: double.infinity,
                          child: AutoSizeText("${(noteDescription[index])}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                          color: Colors.black
                          ),
                          ),
                          ))
                    ],
                  ),
                  ),
                  )
            ],
          ),
        ),
      ),
      );
  }

  void  _settingModalBottomSheet(context){
    showModalBottomSheet(context: context,
    isScrollControlled: true,
    elevation: 50,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
      topLeft: Radius.circular(30)
      )
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
     builder: (BuildContext bc){
      return  Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25),
          child:Form(
            key: _formKey,
            child:
            SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: (MediaQuery.of(context).size.height),
                ),
                child: Padding(padding: const EdgeInsets.only(bottom: 250,top:50),
                child: Column(
                  children:  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("New Note",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                          ),
                          ),
                          GestureDetector(
                            onTap: (){
                              if(_formKey.currentState!.validate()){
                                setState(() {
                                  noteHeading.add(noteHeadingController.text);
                                  noteDescription.add(noteDiscriptionController.text);
                                  noteHeadingController.clear();
                                  noteDiscriptionController.clear();
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              child: const Row(
                                children: [
                                  Text("Save",
                                  style:TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500
                                  )
                                  )
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                    const Divider(
                      color: Colors.blueAccent,
                      thickness: 2.5,
                    ),
                    TextFormField(
                      maxLength: notesHeaderMaxLength,
                      controller: noteHeadingController,
                      decoration: const InputDecoration(
                        hintText: "Notes Header",
                        hintStyle:TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500
                          ),
                          prefixIcon: Icon(Icons.text_fields),
                      ),
                      validator: ( noteHeading) {
                        if(noteHeading!.isEmpty){
                          return "Enter Note Heading";
                        }
                        else if(noteHeading.startsWith(" ")){
                          return "Please avoid whitespaces";
                        }
                      },
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context)
                        .requestFocus(textSecondFocusNode);
                      },
                    ),
                    Padding(padding: const EdgeInsets.only(top:15),
                    child: Container(
                      margin: const EdgeInsets.all(1),
                      height: 5*24,
                      child: TextFormField(
                        focusNode: textSecondFocusNode,
                        maxLines: notesDescriptionMaxLines,
                        maxLength: notesDescriptionMaxLength,
                        controller: noteDiscriptionController,
                        decoration: const InputDecoration(
                          border: 
                        OutlineInputBorder(),
                        hintText: "Description",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500
                          )
                        ),
                        validator: ( noteDescription) {
                          if(noteDescription!.isEmpty){
                            return "Enter note Desc";
                          }
                          else if(noteDescription.startsWith(" ")){
                            return "Avoid whitespace";
                          }
                        },
                      ),
                    ),
                    )
                  ],
                ),
                ),
                ),
          ),
             )
           
          );
     });
  }
}
Widget notesHeader(){
  return const Padding(
    padding:EdgeInsets.only(top: 10,left: 2.5,right: 2.5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Notes',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w900),
          ),
          Divider(color: Colors.grey,
          thickness: 2.5,
          )
      ],
    ),
    );
}