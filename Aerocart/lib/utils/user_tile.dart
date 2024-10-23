import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    required this.child,
    this.onTap,
    required this.icon,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final dynamic icon;


  @override
  Widget build(BuildContext context) {
    final widget = Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          icon,
          const SizedBox(height: 10,),
          child,
        ],
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 253, 178, 17),
            blurRadius: 5,
            offset: Offset(8, 8),
            //blurStyle: BlurStyle(),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 168, 202, 127),
            Color.fromARGB(0,0,0,0),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SizedBox(
        height: 30,
        //width: double.infinity,
        child: null == onTap
            ? widget
            : Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  child: widget,
                ),
              ),
      ),
    );
  }
}

class UserTile2 extends StatelessWidget {
  const UserTile2({
    required this.child,
    this.onTap,
    required this.icon,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final dynamic icon;


  @override
  Widget build(BuildContext context) {
    final widget = Padding(
      padding: const EdgeInsets.all(5.0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          icon,
          SizedBox(height:MediaQuery.of(context).size.height * 0.02,),
          child,
        ],
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:  Color.fromARGB(255, 168, 202, 127),
            blurRadius: 5,
            offset: Offset(8, 8),
            //blurStyle: BlurStyle(),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 253, 178, 17),
            Color.fromARGB(0,0,0,0),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SizedBox(
        height: 30,
        width: double.infinity,
        child: null == onTap
            ? widget
            : Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  child: widget,
                ),
              ),
      ),
    );
  }
}
