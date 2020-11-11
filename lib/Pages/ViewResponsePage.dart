import 'dart:convert';

import 'package:Survey_App/models/app.dart';
import 'package:Survey_App/models/typography.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewResponsePage extends StatefulWidget {
  var sInfo;
  ViewResponsePage({Key key, this.sInfo}) : super(key: key);
  @override
  _ViewResponsePageState createState() => _ViewResponsePageState();
}

class _ViewResponsePageState extends State<ViewResponsePage> {
  bool isLoading = true;
  var body2;
  Future getResponse() async {
    var url = Provider.of<AppModel>(context, listen: false).getServerURL;
    Dio dio = new Dio();
    try {
      Response response = await dio.get(
        "$url/api/v1/response/${widget.sInfo['_id']}",
      );
      // var responseD = json.decode(response);
      setState(() {
        body2 = response.data['responses'];
      });
      setState(() {
        isLoading = false;
      });
    } on DioError catch (e) {
      // await clearFields();
      print("Errrrrrrr:${e}");
      String errorMsg = e.response.toString();
      return errorMsg;
    }
  }

  _getDataRows() {
    List<DataRow> rowList = [];
    for (int i = 0; i < body2.length; i++) {
      rowList.add(
        DataRow(cells: <DataCell>[]),
      );
    }
    for (int i = 0; i < body2.length; i++) {
      for (int j = 0; j < widget.sInfo['fields'].length; j++) {
        rowList[i]
            .cells
            .add(DataCell(Text(body2[i]['response'][j]['response'])));
      }
    }
    return rowList;
  }

  _getDataColumns() {
    List<DataColumn> dataColumn = [];
    for (int i = 0; i < widget.sInfo['fields'].length; i++) {
      dataColumn.add(
        DataColumn(
          label: Text(
            widget.sInfo['fields'][i]['fieldName'].toString(),
            style: TextStyle(color: primary, fontSize: 20),
          ),
        ),
      );
    }
    return dataColumn;
  }

  @override
  void didChangeDependencies() async {
    await this.getResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var body = widget.sInfo;
    return Scaffold(
      appBar: AppBar(
        title: Text(body['surveyTitle']),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(left: 10, top: 10, right: 10),
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: boldFont,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Text(widget.sInfo['surveyTitle']),
                    ),
                    Text(
                      "Description",
                      style: boldFont,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Text(widget.sInfo['surveyDesc']),
                    ),
                    Text(
                      "Submitted responses",
                      style: boldFont,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2, color: primary)),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                semanticsLabel: "Loading response",
                                semanticsValue: "adfasdf",
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: _getDataColumns(),
                                rows: _getDataRows(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () {},
                    color: primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Download as Excel file",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
