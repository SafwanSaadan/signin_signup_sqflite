// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../add_record.dart';
import '../database/sql_helper.dart';
import '../edit_record.dart';

void main() {
  runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      )
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  bool _isLoading = false;
  List<Map<String, dynamic>> _journals = [];
  void _refreshJournals() async {
    final data = await SQLHelper.getUsers();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }


  void _deleteItem(int id) async {
    await SQLHelper.deleteUser(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted'),
    ));
    _refreshJournals();
  }


  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: const Text('Book Store'),
      ),
      body: _isLoading? const Center(
        child: CircularProgressIndicator(),
       ): ListView.builder(
        itemCount: _journals.length,
          itemBuilder: (context,index)=> Card(
            color: Colors.orange[200],
            margin: const EdgeInsets.all(15),
            child: ListTile(
              title: Text(_journals[index]['title']),
              subtitle: Text(_journals[index]['description']),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [IconButton(
                      onPressed: (){
                        Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context)=>EditRecord(id:_journals[index]['id'].toString()))
                        );
                      },
                      icon: const Icon(Icons.edit),
                  ),
                    IconButton(
                        onPressed: ()=>_deleteItem(_journals[index]['id']),
                        icon: const Icon(Icons.delete_forever)
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: ()async{
          String refresh  = await Navigator.push(
              context, MaterialPageRoute(
              builder: (context)=> const AddRecord(),
          ));
          if(refresh =='refresh'){
            _refreshJournals();
          }
        },
      ),
     );
  }
}
