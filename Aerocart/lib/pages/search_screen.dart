import 'package:amazon_clone/pages/results_screen.dart';
import 'package:amazon_clone/cloud_firestore_methods/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController querry = TextEditingController();
  String name = "";
  List<Widget>? product=[];


    void getData(String name) async{
    List<Widget>?temp=await CloudFirestoreClass().searchProducts(name: name);
    setState(() {
      product=temp;
    });
  }
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 168, 202, 127), Color.fromARGB(255, 37, 46, 42)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                    controller: querry,
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });  
                      getData(val);                    
                    },
                    onSubmitted: (value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResultsScreen(querry: value)));
                    },
                    decoration: InputDecoration(
                      isCollapsed: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.all(11),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 30,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
      // body: Column(
      //   children: [
      //     name != ""
      //         ? Padding(
      //             padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
      //             child: RichText(
      //               text: TextSpan(
      //                 children: [
      //                   const TextSpan(
      //                       text: "Search results for ",
      //                       style:
      //                           TextStyle(fontSize: 17, color: Colors.black)),
      //                   TextSpan(
      //                     text: name,
      //                     style: const TextStyle(
      //                         fontSize: 17,
      //                         fontStyle: FontStyle.italic,
      //                         color: Colors.black),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           )
      //         : const SizedBox(
      //             height: 1,
      //             width: 1,
      //           ),
      //     Expanded(
      //         child: StreamBuilder<QuerySnapshot>(
      //             stream: FirebaseFirestore.instance
      //                 .collection("products")
      //                 .snapshots(),
      //             builder: (context, snapshot) {
      //               if (snapshot.connectionState == ConnectionState.waiting) {
      //                 return const LoadingWidget();
      //               } else {
      //                 if(name.isEmpty){
      //                   return Container();
      //                 }
      //                 else{
      //                   getData(name);
      //                   return ListView(
      //                     children: product,
      //                   );
      //                 }
      //                 // GridView.builder(
      //                 //     gridDelegate:
      //                 //         SliverGridDelegateWithFixedCrossAxisCount(
      //                 //             crossAxisCount: crossAxisCount,),
      //                 //     itemCount: snapshot.data!.docs.length,
      //                 //     itemBuilder: (context, index) {
      //                 //       var dataa=snapshot.data!.docs[index].data() as Map<String,dynamic>;
      //                 //       print(dataa);
      //                 //        ProductModels product =
      //                 //           ProductModels.getModelFromJson(
      //                 //               json: dataa);

      //                 //       if(name.isEmpty){
      //                 //         return const SizedBox(height: 1,width: 1,);
      //                 //       }
      //                 //       else if(dataa['productName'].toLowerCase().startsWith(name.toLowerCase())){
      //                 //        return ResultWidget(product: product);
      //                 //       }
      //                 //     });
      //              }
      //             }))
      //   ],
      // ),
    );
  }
}
