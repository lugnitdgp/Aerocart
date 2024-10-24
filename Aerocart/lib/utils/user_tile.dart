import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    required this.child,
    this.onTap,
    required this.image,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final dynamic image;

  @override
  Widget build(BuildContext context) {
    final MQ =MediaQuery.of(context).size;
    final widget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MQ.height*0.2,
            child:Image.asset(image,fit: BoxFit.contain,),
          ),
          const SizedBox(
            height: 10,
          ),
          child,
        ],
      ),
    );
    return Container(
      width: MQ.width * 0.42,
      height: MQ.height * 0.3,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 30,
            offset: Offset(8, 8),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: SizedBox(
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
    required this.image,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final dynamic image;

  @override
  Widget build(BuildContext context) {
    final MQ =MediaQuery.of(context).size;
    final widget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MQ.height*0.1,
            child:Image.asset(image,),
          ),
          const SizedBox(
            height: 10,
          ),
          child,
        ],
      ),
    );
    return Container(
      width: MQ.width * 0.42,
      height: MQ.height * 0.2,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 30,
            offset: Offset(8, 8),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
      ),
      child: SizedBox(
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
