import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class AssetPage extends StatelessWidget {
  const AssetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      //height: 500,
      //width: 300,
    //padding: const EdgeInsets.all(8.0),
    //height:MediaQuery.of(context).size.height,
      child: Form(
        key: _formKey,
        child: Row(
      //children: List<Widget>.generate(3, (int index) { 
        children: <Widget> [
         SizedBox(
          height: 500,
          width: 200,
          child: Padding(
          padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(const Size(100, 20)),
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
          onSaved: (String? value){
            //debugPrint('value for field $index saved as "$value"');
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter something' ;
            }
            return null;
          },
        ),
          ),
          
        
          )
        ),
         ElevatedButton(onPressed: () {
          if(_formKey.currentState!.validate()){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Great!'),
            )
            );
          }
        },
        child: const Text('Validate'),
        )
        ]
        ) 
      )
    );
      }
  
  }
