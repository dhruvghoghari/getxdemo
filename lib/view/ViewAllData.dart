import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controlar/MyControlar.dart';

class ViewAllData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MyControlar obj = Get.put(MyControlar());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AlertDialog alert = new AlertDialog(
          backgroundColor: Colors.grey,
          contentPadding: EdgeInsets.all(10.0),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  TextField(
                  controller: obj.itemid,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter ID",
                  ),
                )
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await obj.addProduct();
                Navigator.of(context).pop();
              },
              child: Text("Add",style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
            )
          ]);
          showDialog(
                context: context,
                builder: (context){
                  return alert;
                  }
                );
          },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("ViewAllData"),),
      body: Obx(()=>(obj.alldata==null)?Center(child: CircularProgressIndicator(),):
      ListView.builder(
          itemCount: obj.alldata!.length,
          itemBuilder: (context,index)
          {
            return Container(
              child: ListTile(
                title: Image.network(obj.alldata![index].url.toString()),
                subtitle: Column(
                  children: [
                    Text(obj.alldata![index].id.toString()),
                  ],
                ),
              ),
            );
          }
      )),
    );
  }
}
