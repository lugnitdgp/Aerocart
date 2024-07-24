import 'package:amazon_clone/auth/user_details_model.dart';
import 'package:amazon_clone/pages/update_address.dart';
import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:amazon_clone/utils/button.dart';
import 'package:amazon_clone/utils/cloud_firestore.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  final double cost;
  const CheckoutScreen({super.key, required this.cost});

  @override
  State<CheckoutScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<CheckoutScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController number = TextEditingController();
  List<Widget>? product;
  double shipping = 7;
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    List<Widget>? temp = await CloudFirestoreClass().checkoutProducts();
    setState(() {
      product = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userdetails;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(width * 0.077, 10, 0, 10),
        child: MyButton(
            ontap: () async{
              if ((int.parse(number.text) / 1000000000 < 10) &&
                  (int.parse(number.text) / 1000000000 > 5)) {
                   await CloudFirestoreClass().buyAllItemsInCart(userDetails: userDetailsModel);
                   Utils().showSnackBar(context: context, content: "Success");
                   Navigator.pop(context);
              } else {
                Utils().showSnackBar(
                    context: context,
                    content: "Please enter a valid phone number");
              }
            },
            text: "Checkout- ₹${(widget.cost + shipping).toString()}"),
      ),
      appBar: AppBar(
        elevation: 3,
        title: const Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 50),
                child: Text(
                  "Order Review",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 55,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.cyan, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Order Summary-",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Cost(₹)",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: product!,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Shipping fee-",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Text(
                        shipping.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total-",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      Text(
                        (widget.cost + shipping).toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 5, 18, 0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Have a Promo code? Apply here",
                        hintStyle: TextStyle(color: Colors.grey[700])),
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Shipping Address-",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UpdateAddress()));
                        },
                        child: const Text(
                          "Change address",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      const Text(
                        "Deliver to- ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        userDetailsModel.address,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
                  child: Row(
                    children: [
                      Text(
                        "Enter your phone number-",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: number,
                    onSubmitted: (value) {
                      if ((int.parse(value) / 1000000000 < 10) &&
                          (int.parse(value) / 1000000000 > 5)) {
                      } else {
                        Utils().showSnackBar(
                            context: context,
                            content: "Please enter a valid phone number");
                      }
                    },
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter your phone number here",
                        hintStyle: TextStyle(color: Colors.grey[700])),
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
