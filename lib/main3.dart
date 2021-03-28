import 'package:flutter/material.dart';

void main() {
  runApp(AnimationApp());
}

/// 1. 定义动画组件, 动画的组件封装在该组件中
/// 使用 AnimatedWidget 快速实现一个动画
class AnimatedApp extends AnimatedWidget{

  /// 构造函数
  AnimatedApp({Key key, Animation<double> animation})
      :super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    /// 获取动画
    Animation<double> animation = listenable;
    return Column(
      children: [
        Text("动画状态 : ${animation.status}", textDirection: TextDirection.ltr,),

        Text("动画值 : ${animation.value.round()}", textDirection: TextDirection.ltr,),

        // 动画的主体组件
        // 布局组件中使用动画的值 , 以达到动画效果
        Container(
          /// 设置距离顶部 20 像素
          margin: EdgeInsets.only(top: 50),
          height: animation.value,
          width: animation.value,
          decoration: BoxDecoration(color: Colors.red),
        ),
      ],
    );

  }
}

/// 动画示例主界面组件
/// 该组件是有状态的, 因此需要定义 StatefulWidget 组件
class AnimationApp extends StatefulWidget{
  @override
  _AnimationAppState createState() => _AnimationAppState();
}

/// 为 StatefulWidget 组件创建 State 类
/// 每个 StatefulWidget 都需要一个配套的 State 类
class _AnimationAppState extends State<AnimationApp>
    with SingleTickerProviderStateMixin{

  /// 动画类
  Animation<double> animation;
  /// 动画控制器
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    /// 2. 初始化动画控制器
    animationController = AnimationController(
      // 动画绘制到屏幕外部时, 减少消耗
      vsync: this,
      // 动画持续时间 2 秒
      duration: Duration(seconds: 3),
    );


    /// 3 . 构造 Tween 补间动画 ,
    /// 设置动画控制器 AnimationController 给该补间动画
    /// 动画的值是正方形组件的宽高
    animation = Tween<double>(
      begin: 0,
      end: 300
    ).animate(animationController);

  }

  /// 该方法与 initState 对应
  @override
  void dispose() {

    /// 释放动画控制器
    animationController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Container(

      /// 设置距离顶部 20 像素
      margin: EdgeInsets.only(top: 100),

      child: Column(
        children: [

          GestureDetector(
            // 5 . 点击按钮开启动画
            onTap: (){
              /// 按钮点击事件
              /// 首先将动画初始化
              animationController.reset();

              /// 正向执行动画, 即从初始值执行到结束值
              animationController.forward();

            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.green,
              height: 50,
              child: Text(
                // 显示文本
                "动画开始",
                /// 文字方向 : 从左到右
                textDirection: TextDirection.ltr,
              ),
            ),
          ),

          // 动画的主体组件
          // 4 . 创建动画组件, 传入动画对象 animation
          AnimatedApp(animation: animation,),


        ],
      ),
    );
  }

}