import 'package:flutter/material.dart';


class NoteDetail extends StatefulWidget {

  final String title;
  const NoteDetail({required this.title,Key? key}) : super(key: key);

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {

static var _priorities = ['high', 'low'];
TextEditingController titleTextEditingController =TextEditingController();
TextEditingController descriptionTextEditingController =TextEditingController();


@override
  void initState() {
    super.initState();

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          children: [
            DropdownButton(
                items: _priorities.map((String dropDownItems) {
                  return DropdownMenuItem<String>(
                      value: dropDownItems,
                      child: Text(dropDownItems)
                  );
                }).toList(),
                style: const TextStyle(
                  fontSize: 15,
                ),
                onChanged: (valueSelectedByUser){
                  setState(() {
                   print('value is $valueSelectedByUser');
                  });
                }),
            const SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                   controller: titleTextEditingController,
                   onChanged: (value){
                     print('hello');
                   },
                   decoration: InputDecoration(
                     labelText: 'Title',
                     focusColor: Colors.white70,
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5)
                     )
                   ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: descriptionTextEditingController,
                onChanged: (value){
                  print('hello');
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    focusColor: Colors.white70,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                    )
                ),
              ),
            ),
            const SizedBox(height: 10.0,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed:(){},
                      style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                      elevation: MaterialStateProperty.all(5),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                      child: const Text('Save')
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: ElevatedButton(
                      onPressed:(){},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                        elevation: MaterialStateProperty.all(5),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: const Text('Delete')
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }


}






