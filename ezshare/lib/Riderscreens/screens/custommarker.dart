import 'dart:ui' as ui;
import 'package:flutter/services.dart';
class CustomMarkerMaker {
   Future<Uint8List> getbytesfromAssets(String path, int width,int height) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: height,targetWidth: width );
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Uint8List> custommarkerfromasset(String path)  async{
      
      
    return await getbytesfromAssets(path, 50,50);
    
  }
}