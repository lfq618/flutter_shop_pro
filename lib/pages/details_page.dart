import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';
import './detail_pages/detail_top_area.dart';
import './detail_pages/detail_explain.dart';
import './detail_pages/detail_tabBar.dart';
import './detail_pages/detail_web_detail.dart';
import './detail_pages/detail_bottom.dart';

class DetailPage extends StatelessWidget {
  final String goodsId;
  DetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('商品详细信息'),
            ),
            body: FutureBuilder(
              future: _getGoodInfo(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        child: ListView(
                          children: <Widget>[
                            DetailTopArea(),
                            DetailExplainArea(),
                            DetailTabBar(),
                            DetailWebDetail()
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: DetailBottom(),
                      ),
                    ],
                  );
                } else {
                  return Text('加载中........');
                }
              },
            )));
  }

  Future _getGoodInfo(BuildContext context) async {
    await Provide.value<DetailInfoProvide>(context).getGoodsInfo(goodsId);
    return '加载完成';
  }
}
