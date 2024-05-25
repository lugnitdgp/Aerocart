
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});
   @override
   State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  double result = 0;
  final TextEditingController textEditingController = TextEditingController(); 

  void convert(){
    result= double.parse(textEditingController.text)*80;
    setState(() {});
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    const border = OutlineInputBorder(
    borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Currency Converter',
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 23,          
        ),
        centerTitle: true,
        elevation: 55,
        toolbarHeight: 70,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(50.0,30.0,50,50),
                child: Text(
                  'INR ${result !=0 ? result.toStringAsFixed(2):result.toStringAsFixed(0)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(3.0,30.0,3.0,30.0),
                child: TextField(
                  controller: textEditingController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter the amount in USD',
                    hintStyle: TextStyle(
                      color: Colors.black45,
                    ),
                    prefixIcon: Icon(Icons.monetization_on_outlined),
                    prefixIconColor: Colors.black87,
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: convert,
                  style: ElevatedButton.styleFrom(
                    elevation: 15,
                    backgroundColor: (Colors.white),
                    foregroundColor: (Colors.black),
                    minimumSize: const Size(90, 40),
                  ),
                  child: const Text('Convert'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}