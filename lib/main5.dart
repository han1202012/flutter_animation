import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

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
    return SizedBox(
      width: width,

      /// 这里定义核心组件 Hero 组件 , 传入 tag 标识 , 与 Hero 动画作用的组件
      child: Hero(tag: imageUrl, child: Material(
        color: Colors.transparent,
        /// 按钮
        child: InkWell(
          /// 按钮点击事件
          onTap: onTap,
          child: Image.network(imageUrl, fit: BoxFit.contain,),
        ),
      ),),
    );
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
