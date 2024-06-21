import 'package:amazon_clone/utils/models.dart';
import 'package:amazon_clone/utils/result_widget.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String querry;
  const ResultsScreen({super.key, required this.querry});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width ~/ 180;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyanAccent, Colors.greenAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,10,0,30),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: "Search results for ",
                      style: TextStyle(fontSize: 17, color: Colors.black)),
                  TextSpan(
                    text: "'$querry'",
                    style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ResultWidget(
                    product: ProductModels(
                        cost: 1000,
                          productname: "Something very good",
                          sellername: "Keshto",
                          selleruid: "zmjjkk",
                          uid: "2ku5",
                          url:"https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
                          description: "sodales ut etiam sit amet nisl purus in mollis nunc sed id semper risus in hendrerit gravida rutrum quisque non tellus orci ac auctor augue mauris augue neque gravida in fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum odio jsdfgnivdn fndfngo fnignfnof nognfodngnofgnofnognn nn nnognfgonfo gnofn no n gonfdognfodn non fognfo ngon nosfdngonffognsodfngonfo nsnfognodfsngonsfon ndsofgnosfndognsfodngo sofdgnosdfngonfong nfodgn osfdn gon ",

                        ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
