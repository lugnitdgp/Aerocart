import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
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
          SizedBox(
            height: MQ.height*0.139,
            child:Image.asset(image,fit: BoxFit.contain,),
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
            blurRadius: 15,
            offset: Offset(1, 1),
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

