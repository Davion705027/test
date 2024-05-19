import '../../../../../login/login_head_import.dart';

class TrianglePath extends CustomClipper<Path>{
  bool? up;
  TrianglePath({this.up});
  @override
  Path getClip(Size size) {
    var path = Path();
    if(up==true) {
      path.moveTo(size.width/2, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width/2, size.height*2/3);
      path.lineTo(size.width, size.height);
      path.close();
    }else{
      path.moveTo(0, 0);
      path.lineTo(size.width/2,  size.height);
      path.lineTo(size.width, 0);
      path.lineTo(size.width/2, size.height*1/3);
      path.close();
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}