import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:math' as math;

void main() {
  runApp(
    MaterialApp(
      home: HeroAnimation(),
    )
  );
}

/// Hero 组件 , 跳转前后两个页面都有该组件
class HeroWidget extends StatelessWidget{
  /// 构造方法
  const HeroWidget({Key key, this.imageUrl, this.width, this.onTap}) : super(key: key);

  /// Hero 动画之间关联的 ID , 通过该标识
  /// 标识两个 Hero 组件之间进行动画过渡
  /// 同时该字符串也是图片的 url 网络地址
  final String imageUrl;
  /// 点击后的回调事件
  final VoidCallback onTap;
  /// 宽度
  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      /// 按钮
      child: InkWell(
        /// 按钮点击事件
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, size){
            return Image.network(
              imageUrl,
              fit: BoxFit.contain,);
          },
        ),
      ),
    );
  }
}

/// Hero 组件 , 径向动画扩展
class RadialExpansion extends StatelessWidget {

  final double maxRadius;

  /// 该值需要动态计算
  final clipRectSize;
  final Widget child;

  const RadialExpansion({
    Key key,
    this.maxRadius,
    this.child
  }) : clipRectSize = 2.0 * (maxRadius / math.sqrt2), super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: clipRectSize,
        height: clipRectSize,
        child: ClipRect(
          child: child,
        ),
      ),
    );
  }
}

class RadialExpansionDemo extends StatelessWidget {

  /// 最小半径
  static const double kMinRadius = 32.0;
  /// 最大半径
  static const double kMaxRadius = 128.0;

  /// 动画差速器
  static const opacityCurve = Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}





class HeroAnimation extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // 时间膨胀系数 , 用于降低动画运行速度
    timeDilation = 10.0;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hero 动画演示( 跳转前页面 )"),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          alignment: Alignment.bottomRight,
          child: HeroWidget(
            imageUrl: "https://img-blog.csdnimg.cn/20210329101628636.jpg",
            width: 300,
            // 点击事件 , 这里点击该组件后 , 跳转到新页面
            onTap: (){

              print("点击事件触发, 切换到新界面");

              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context){
                        /// 跳转到的新界面再此处定义
                        return MaterialApp(
                          home: Scaffold(
                            appBar: AppBar(
                              title: Text("Hero 动画演示( 跳转后页面 )"),
                            ),
                            body: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.topLeft,
                              child: HeroWidget(
                                imageUrl: "https://img-blog.csdnimg.cn/20210329101628636.jpg",
                                width: 100,
                                onTap: (){
                                  /// 退出当前界面
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        );
                      }
                  )
              );
            },
          ),
        ),
      ),
    );
  }
}
