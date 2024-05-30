import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity,60),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.cyanAccent,
                    Colors.greenAccent
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                     Padding(
                       padding: const EdgeInsets.fromLTRB(0,0,0,10),
                       child: IconButton(
                        onPressed: () {Navigator.pop(context);},
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black,
                       ),
                     ),      
                  
                    SizedBox(
                      width: width*0.8,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,10),
                        child: TextField(
                          decoration: InputDecoration(
                            isCollapsed: true,
                            isDense: true,
                            contentPadding: EdgeInsets.all(11),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,),
                            suffixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0),size: 30,),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
              ]
            ),
          ),
      ),
    );
  }
}