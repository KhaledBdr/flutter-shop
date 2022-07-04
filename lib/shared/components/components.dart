import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget onBoardItem ({
  @required model ,
  @required context,
})=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image.asset(
        'assets/images/${model.img}',
      ),
    ),
    height(15.0,),
    Text(
      '${model.title}' ,
      style: Theme.of(context).textTheme.headline5?.copyWith(
            fontFamily: 'shortbaby'
      ),
    ),
    height(20.0,),
    Text(
      '${model.body}' ,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
          fontFamily: 'opensans'
      ),
    ),
  ],
);

void NavToAndCancel (context , Widget newRoute ) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context)=> newRoute,
      ),
          (route) => false,
    );
}

void NavTo (context , Widget newScreen){
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context){
    return newScreen;
          },
      ),
  );
}

Widget input ({
  @required TextEditingController controller,
  @required String label,
  @required IconData prefixIcon,
  @required validator,
  @required TextInputType keyBoard,
  void onChange(String value),

})=>   TextFormField(
  onChanged:onChange ,
  keyboardType: keyBoard,
  controller: controller,
  decoration: InputDecoration(
      border:OutlineInputBorder(),
      prefixIcon: Icon(
          prefixIcon,
      ),
      labelText: label
  ),
  validator: validator,
);



Widget passwordInput ({
  @required TextEditingController controller,
  IconData suffexIcon,
  @required void onPressedSuffexFunction(),
  @required bool obsecure,
  @required validator,
  @required String label,
  @required bool suffix,
  prefix = Icons.lock,
  suffixColor = Colors.grey
}) => TextFormField(

  controller: controller,
  obscureText: obsecure,
  validator: validator,
  decoration: InputDecoration(
      border:OutlineInputBorder(),
      prefixIcon: Icon(
        prefix,
      ),
      labelText: label,
      suffixIcon: suffix?IconButton(
        icon: Icon(suffexIcon),
        color:suffixColor,
        onPressed: onPressedSuffexFunction,
      ): null,
  ),
);

Widget height (@required double height) => SizedBox(height: height,);
Widget width (@required double width) => SizedBox(width: width,);

Future addToast ({
  @required String msg,
  @required ToastStates state,
})async{
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: setToastColor(state: state),
      textColor: Colors.white,
      fontSize: 16.0,
  );
}

enum ToastStates {SUCCESS , ERROR , WARNING}
Color setToastColor ({
  @required ToastStates state
}){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget line (){
  return Container(
    height: 2.0,
    width: double.infinity,
    color: Colors.grey,
  );
}

Widget centerCircle({
   Color color=Colors.red,
}){
  return Center(
    child: CircularProgressIndicator(color: color,),
  );
}


Widget ImageWithIndecator({
 @required String image ,
  double width ,
  double height,
}){
  return   CachedNetworkImage(
    imageUrl: image,
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        CircularProgressIndicator(value: downloadProgress.progress, ),
    errorWidget: (context, url, error) => Icon(Icons.error),
    height: height,
    width: width,
    fit: BoxFit.cover,
  );
}