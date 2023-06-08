import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:image_painter/image_painter.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

// class Triangle extends PaintContent {
//   Triangle();
//
//   Offset startPoint = Offset.zero;
//
//   Offset A = Offset.zero;
//   Offset B = Offset.zero;
//   Offset C = Offset.zero;
//
//   @override
//   void startDraw(Offset startPoint) => this.startPoint = startPoint;
//
//   @override
//   void drawing(Offset nowPoint) {
//     A = Offset(
//         startPoint.dx + (nowPoint.dx - startPoint.dx) / 2, startPoint.dy);
//     B = Offset(startPoint.dx, nowPoint.dy);
//     C = nowPoint;
//   }
//
//   @override
//   void draw(Canvas canvas, Size size, bool deeper) {
//     final Path path = Path()
//       ..moveTo(A.dx, A.dy)
//       ..lineTo(B.dx, B.dy)
//       ..lineTo(C.dx, C.dy)
//       ..close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   Triangle copy() => Triangle();
//
//   @override
//   Map<String, dynamic> toJson() {
//     // TODO: implement toJson
//     throw UnimplementedError();
//   }
// }
class EditorScreen extends StatefulWidget {
  const EditorScreen({Key? key}) : super(key: key);
  @override
  State<EditorScreen> createState() => _EditorScreenState();
}
class _EditorScreenState extends State<EditorScreen> {
  final _imageKey = GlobalKey<ImagePainterState>();
  final _key = GlobalKey<ScaffoldState>();

  void saveImage() async {
    final image = await _imageKey.currentState?.exportImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath =
        '$directory/sample/${DateTime
        .now()
        .millisecondsSinceEpoch}.png';
    final imgFile = File('$fullPath');
    imgFile.writeAsBytesSync(image!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey[700],
        padding: const EdgeInsets.only(left: 10),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Image Exported successfully.",
                style: TextStyle(color: Colors.white)),
            TextButton(
              onPressed: () => OpenFile.open("$fullPath"),
              child: Text(
                "Open",
                style: TextStyle(
                  color: Colors.blue[200],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // final DrawingController _drawingController = DrawingController();

  // Future<void> _getImageData() async {
  //   print((await _drawingController.getImageData())?.buffer.asInt8List());
  //   _drawingController.setPaintContent = SimpleLine();
  // }
  // final DrawingController _drawingController = DrawingController();
  //
  // @override
  // void dispose() {
  //   _drawingController.dispose();
  //   super.dispose();
  // }
  //
  // /// 获取画板数据 `getImageData()`
  // Future<void> _getImageData() async {
  //   final Uint8List? data =
  //   (await _drawingController.getImageData())?.buffer.asUint8List();
  //   if (data == null) {
  //     print('获取图片数据失败');
  //     return;
  //   }
  //   showDialog<void>(
  //     context: context,
  //     builder: (BuildContext c) {
  //       return Material(
  //         color: Colors.transparent,
  //         child:
  //         InkWell(onTap: () => Navigator.pop(c), child: Image.memory(data)),
  //       );
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text("Image Painter Example"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: saveImage,
          )
        ],
      ),
      body: ImagePainter.asset(
        "",
        key: _imageKey,
        scalable: true,
        initialStrokeWidth: 2,
        initialColor: Colors.green,
        initialPaintMode: PaintMode.line,
      ),
    );
    ////////////////////////////////////////////////////////////////
    // return Scaffold(
    //   resizeToAvoidBottomInset: false,
    //   backgroundColor: Colors.grey,
    //   appBar: AppBar(
    //     title: const Text('Drawing Test'),
    //     systemOverlayStyle: SystemUiOverlayStyle.light,
    //     actions: <Widget>[
    //       IconButton(icon: const Icon(Icons.check), onPressed: _getImageData)
    //     ],
    //   ),
    //   body: Column(
    //     children: <Widget>[
    //       Expanded(
    //         child: DrawingBoard(
    //           controller: _drawingController,
    //           background:
    //           Container(width: 400, height: 400, color: Colors.white),
    //           showDefaultActions: true,
    //           showDefaultTools: true,
    //           defaultToolsBuilder: (Type t, _) {
    //             return DrawingBoard.defaultTools(t, _drawingController)
    //               ..insert(
    //                 1,
    //                 DefToolItem(
    //                   icon: Icons.change_history_rounded,
    //                   isActive: t == Triangle,
    //                   onTap: () =>
    //                   _drawingController.setPaintContent = Triangle(),
    //                 ),
    //               );
    //           },
    //         ),
    //       ),
    //       const Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child: SelectableText(
    //           'https://github.com/xSILENCEx/flutter_drawing_board',
    //           style: TextStyle(fontSize: 10, color: Colors.white),
    //         ),
    //       ),
    //     ],
    //   ),
    //   // body: DrawingBoard(
    //   //   controller: _drawingController,
    //   //   background: Container(width: 600, height: 600, color: Colors.white),
    //   //   showDefaultActions: true,
    //   //   showDefaultTools: true,
    //   // ),
    // );

    /////////////////////////////////////////////////////////////////
  }
}

