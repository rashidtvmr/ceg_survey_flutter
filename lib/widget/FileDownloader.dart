import 'dart:io';
import 'package:Survey_App/models/app.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:file_utils/file_utils.dart';
import 'dart:math';

class FileDownloader extends StatefulWidget {
  var sInfo;
  FileDownloader({Key key, this.sInfo}) : super(key: key);

  @override
  _FileDownloaderState createState() => _FileDownloaderState();
}

class _FileDownloaderState extends State<FileDownloader> {
  // "$url/api/v1/response/${widget.sInfo['_id']}",
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  Permission permission1 = Permission.WriteExternalStorage;
  var _onPressed;
  static final Random random = Random();
  Directory externalDir;

  // void _onPressed() {
  //   downloadFile();
  // }

  @override
  void initState() {
    super.initState();
    print("teseting........." + widget.sInfo['_id']);
    downloadFile();
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    bool checkPermission1 =
        await SimplePermissions.checkPermission(permission1);
    // print(checkPermission1);
    if (checkPermission1 == false) {
      await SimplePermissions.requestPermission(permission1);
      checkPermission1 = await SimplePermissions.checkPermission(permission1);
    }
    if (checkPermission1 == true) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      var randid = random.nextInt(10000);

      try {
        FileUtils.mkdir([dirloc]);
        var url = Provider.of<AppModel>(context, listen: false).getServerURL;
        final imgUrl = "/api/v1/response/files/${widget.sInfo['_id']}";
        print("uuuuuuuuuu" + url + imgUrl);
        await dio.download(url, imgUrl,
            onReceiveProgress: (receivedBytes, totalBytes) {
          setState(() {
            downloading = true;
            progress =
                ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
          });
        });
      } catch (e) {
        print(e);
      }

      setState(() {
        downloading = false;
        progress = "Download Completed.";
        path = dirloc + randid.toString() + ".pdf";
        print("paaaaaaaath:" + path);
      });
    } else {
      setState(() {
        progress = "Permission Denied!";
        _onPressed = () {
          downloadFile();
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('File Downloader'),
        ),
        body: Center(
          child: downloading
              ? Container(
                  height: 120.0,
                  width: 200.0,
                  child: Card(
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Downloading File: $progress',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(path),
                    MaterialButton(
                      child: Text('Request Permission Again.'),
                      onPressed: _onPressed,
                      disabledColor: Colors.blueGrey,
                      color: Colors.pink,
                      textColor: Colors.white,
                      height: 40.0,
                      minWidth: 100.0,
                    ),
                  ],
                ),
        ),
      );
}
