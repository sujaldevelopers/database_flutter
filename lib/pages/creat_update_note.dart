
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../component/login_component.dart';
import '../component/text_form_field.dart';
import '../constrain.dart';
import '../helper/date_time.dart';
import '../helper/get data.dart';
import '../note class.dart';
import '../note database.dart';

class CreateUpdateNote extends StatefulWidget {
  final int? noteID;
  const CreateUpdateNote({super.key, this.noteID});

  @override
  State<CreateUpdateNote> createState() => _CreateUpdateNoteState();
}

class _CreateUpdateNoteState extends State<CreateUpdateNote> {
  bool isUpdate = false;

  //database
  final database = NoteDatabase.instance;

  //variable
  final _formkey = GlobalKey<FormState>();
  bool isDone = false;
  DateTime? doneDate;
  bool isLoding = false;
  bool BtnLoding = false;

  // controller
  final titlecontroller = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();


  Future<void> _getSingleNote() async {
    setState(() => isLoding = true);


    final note = await database.singleNote(widget.noteID!);
    titlecontroller.text = note?.title ?? "";
    descController.text = note?.desc ?? "";
    dateController.text = note?.date != null ? formatWithYear(note!.date) : "";
    doneDate = note?.date;
    isDone = note?.done ?? false;

    setState(() => isLoding = false);
  }
@override
  void initState() {
    if(widget.noteID!=null){
      isUpdate=true;
      _getSingleNote();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creat TODO"),
      ),
      floatingActionButton: ActionChip(
        label: BtnLoding ? LoadingComponent() : Text(isUpdate?"Update":"Save"),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        avatar: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () async {
          if (_formkey.currentState != null &&
              _formkey.currentState!.validate()) {
            final note = Note(
              id: widget.noteID ,
              title: titlecontroller.text.trim(),
              desc: descController.text.trim(),
              date: doneDate!,
              done: isDone,
            );
            setState(() => BtnLoding = true);
            if (isUpdate) {
              await database.updatenote(note);
            } else {
              await database.createNote(note);
            }
            setState(() => isLoding = false);
            Navigator.pop(context);
          }
        },
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: padding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextFormField(
                  controller: titlecontroller,
                  lable: "Title",
                  hintText: "Enter title",
                  validater: (title) {
                    if (title != null && title.trim().isNotEmpty) return null;
                    return "Plese Enter Title";
                  },
                ),
                fieldHeight,
                MyTextFormField(
                  controller: descController,
                  lable: "Description",
                  hintText: "Enter description",
                  maxLine: 6,
                  validater: (desc) {
                    if (desc != null && desc.trim().isNotEmpty) return null;
                    return "Plese Enter Description";
                  },
                ),
                fieldHeight,
                MyTextFormField(
                  controller: dateController,
                  lable: "Date",
                  abscorbing: true,
                  hintText: "Select Date",
                  validater: (date) {
                    if (date != null && date.trim().isNotEmpty) return null;
                    return "Plese Select Date";
                  },
                  onTap: () async { 
                    final date = await getdata(
                      context: context,
                      initialDate: doneDate,
                    );
                    if (date != null) {
                      setState(() {
                        doneDate=date;
                        dateController.text = formatWithYear(date);
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Is Done",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          activeColor: primary,
                          value: isDone,
                          onChanged: (_) => setState(() => isDone = _),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
