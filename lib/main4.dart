import 'package:flutter/material.dart';

void main() {
  runApp(AnimationApp());
}

/// 3 . 定义纯组件, 动画应用与该组件上
class AnimationWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return // 动画的主体组件
      // 布局组件中使用动画的值 , 以达到动画效果
      Container(
        decoration: BoxDecoration(color: Colors.red),
      );
  }
}

/// 4 . 将组件与动画结合起来
class AnimationTransition extends StatelessWidget{
  /// 构造方法
  AnimationTransition({this.child, this.animation});

  /// 动画作用的组件
  final Widget child;
  /// 动画
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    /// AnimatedBuilder 会自动监听 animation 的变化
    /// 然后渲染 child 组件上的动画
    return Column(
      children: [
        Text("动画状态 : ${animation.status}", textDirection: TextDirection.ltr,),

        Text("动画值 : ${animation.value?.round()}", textDirection: TextDirection.ltr,),

        Container(height: 50,),

        AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Container(
            height: animation.value,
            width: animation.value,
            child: child,
          ),
          child: child,
        )
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

    /// 1. 初始化动画控制器
    animationController = AnimationController(
      // 动画绘制到屏幕外部时, 减少消耗
      vsync: this,
      // 动画持续时间 2 秒
      duration: Duration(seconds: 3),
    );

    /// 2 . 构造 Tween 补间动画 ,
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
    return
      Column(
        children: [

          Container(height: 50,),

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

          Container(height: 50,),

          AnimationTransition(animation: animation, child: AnimationWidget())

        ],

      );

  }

}