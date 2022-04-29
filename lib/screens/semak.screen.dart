
import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';

import '../models/temujanji_model.dart';
import '../services/temujanji.service.dart';

class SemakStatusScreen extends StatefulWidget {
  static const String routeName = '/semak';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => SemakStatusScreen(),
    );
  }

  @override
  State<SemakStatusScreen> createState() => _SemakStatusScreenState();
}

class _SemakStatusScreenState extends State<SemakStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Semak Status Temujanji', style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold
        ),),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: StreamBuilder<List<Program>>(
          stream: getTaskListStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Program> temujanjiList = snapshot.data!;
              return ListView(
                children: List.generate(
                  temujanjiList.length,
                  (i) {
                    return TemuJanjiContainer(
                      temujanji: temujanjiList[i],
                      index: i,
                    );
                  },
                ),
              );
            } else
              return Container();
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // final taskListProvider =
      //     //     Provider.of<TaskListProvider>(context, listen: false);
      //     // final taskList = taskListProvider.taskList;
      //     // final newTask = Task(
      //     //     title: 'Task ${taskList.length + 1}',
      //     //     description: 'Task ${taskList.length + 1} Description');
      //     // taskListProvider.addTask(newTask);
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => TanyaImamScreen(),
      //         ));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}


//TASK CONTAINER SECTION
class TemuJanjiContainer extends StatelessWidget {
  final Program temujanji;
  final int index;

  TemuJanjiContainer({required this.temujanji, required this.index});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    temujanji.tajuk!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    temujanji.huraian!,
                    style: TextStyle(fontSize: 20),
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  Text("Jenis : " +
                    temujanji.JenisTemuJanji,
                    style: TextStyle(fontSize: 20),
                  ),

                  temujanji.tarikh != null ?
                  Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        temujanji.tarikh.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ) : Container (),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.cancel_outlined, color: Colors.red,),

                onPressed: () async{
                  print(temujanji.TemuJanjiID);
                  if(temujanji.TemuJanjiID != null) await deleteTemujanji(temujanji.TemuJanjiID!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
