import 'package:amazon_clone/pages/search_screen.dart';
import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:amazon_clone/utils/button.dart';
import 'package:amazon_clone/cloud_firestore_methods/cloud_firestore.dart';
import 'package:amazon_clone/utils/text_field.dart';
import 'package:amazon_clone/utils/user_details_bar.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  int itemCount = 1;
  TextEditingController name = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController description = TextEditingController();
  String dropdownValue = "Select";
  var itemss = <String>[
    'Select',
    'Appliances',
    'Beauty',
    'Books',
    'Electronics',
    'Essentials',
    'Fashion',
    'Fitness',
    'Grocery',
    'Headphone',
    'Home',
    'Laptop',
    'Medicine',
    'Mobiles',
    'Sports',
    'Stationary',
    'Travel',
    'Toys',
  ];
  @override
  void dispose() {
    name.dispose();
    cost.dispose();
    description.dispose();
    super.dispose();
  }

  List<XFile> imagefileList = [];
  List<Uint8List> image = [];

  Future<void> selectImages() async {
    final List<XFile> selectImages = await ImagePicker().pickMultiImage();
    if (selectImages.isNotEmpty) {
      imagefileList.addAll(selectImages);
      for (int i = 0; i < imagefileList.length; i++) {
        XFile file = imagefileList[i];
        Uint8List bytes = await file.readAsBytes();
        image.add(bytes);
      }
    }
    setState(() {});
  }

  void loadingWidget(int i) {
    if (i == 1) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 55),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyanAccent, Colors.greenAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
                      child: Image.asset(
                        'lib/images/Amazon_icon.png',
                        height: 50,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchScreen()));
                            },
                            icon: const Icon(
                              Icons.notifications_none_outlined,
                              size: 28,
                            )),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ]),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    child: image.isEmpty
                        ? Container(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              strokeWidth: 2,
                              color: Colors.blueGrey,
                              child: ClipRRect(
                                child: Container(
                                  width: width / 3,
                                  height: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: IconButton(
                                        onPressed: () async {
                                          selectImages();
                                        },
                                        icon: const Icon(
                                          Icons.upload_outlined,
                                          size: 30,
                                          color: Colors.blueGrey,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: image.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 50, 0, 10),
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(10),
                                  strokeWidth: 2,
                                  color: Colors.blueGrey,
                                  child: ClipRRect(
                                    child: Container(
                                      width: width / 3,
                                      height: 180,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: imagefileList.isEmpty
                                          ? Center(
                                              child: IconButton(
                                                  onPressed: () async {
                                                    selectImages();
                                                  },
                                                  icon: const Icon(
                                                    Icons.upload_outlined,
                                                    size: 30,
                                                    color: Colors.blueGrey,
                                                  )),
                                            )
                                          : Stack(
                                              children: [
                                                Center(
                                                  child: Image.memory(
                                                      image[index]),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const Text(
                    "Upload Images of the Product",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: width / 1.1,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Product Details",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Name",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        Textfield(
                            controller: name,
                            hintText: "Name of Product",
                            obstext: false),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Description",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: TextField(
                            controller: description,
                            maxLines: 5,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey)),
                                fillColor: Colors.blueGrey[50],
                                filled: true,
                                hintText: "Product Description",
                                hintStyle: const TextStyle(color: Colors.grey)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Cost (in ₹)",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        Textfield(
                            controller: cost, hintText: "Cost", obstext: false),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text("Select Category-",style: TextStyle(fontSize: 15),),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            items: itemss.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                          )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width - width / 1.2),
                    child: MyButton(
                        ontap: () async {
                          if (name.text != "" &&
                              description.text != "" &&
                              cost.text != "" &&
                              image.isNotEmpty &&
                              dropdownValue != "Select") {
                            loadingWidget(1);
                            String output = await CloudFirestoreClass()
                                .uploadProducttoDatabase(
                                    image: image,
                                    description: description.text,
                                    productName: name.text,
                                    cost: cost.text,
                                    sellerName:
                                        Provider.of<UserDetailsProvider>(
                                                context,
                                                listen: false)
                                            .userdetails
                                            .name,
                                    sellerUid:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    category: dropdownValue);
                            if (output == "Success") {
                              Utils().showSnackBar(
                                  context: context,
                                  content: "Product Uploaded");
                              loadingWidget(0);
                              Navigator.pop(context);
                            } else if (output != "Success") {
                              Utils().showSnackBar(
                                  context: context, content: output);
                              loadingWidget(2);
                            }
                          } else {
                            Utils().showSnackBar(
                                context: context,
                                content: "Please fill all the sections");
                          }
                        },
                        text: "Sell"),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width - width / 1.2),
                    child: MyButton(
                        ontap: () {
                          Navigator.pop(context);
                        },
                        text: "Cancel"),
                  ),
                ],
              ),
            ),
          ),
          UserDetailsBar(
            offset: 0,
          ),
        ],
      ),
    );
  }
}
