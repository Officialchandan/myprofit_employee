import 'dart:async';
import 'dart:typed_data';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

/// Convert to image format.
class ImageConverter {
  /// toImage
  static Future<Uint8List> toImage(
      {required RenderSignaturePad renderSignaturePad}) async {
    return Uint8List.fromList(<int>[0]);
  }
}
