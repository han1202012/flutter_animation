import 'package:flutter/material.dart';

void main() {
  runApp(AnimationApp());
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

  /// 动画状态
  AnimationStatus animationStatus;

  /// 动画值
  /// 动画运行过程中, 动画计算出来的值
  double animationValue;


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
    ).animate(animationController)


    /// 3 . 添加动画值监听器
    /// 该用法与 animation.addListener 效果是等价的
    /// 这种写法比较简洁
    /// 类似于链式调用, 上一行代码表达式必须是 animation, 结尾不能有分号
    /// 特别注意 : 动画如果生效, 必须在监听器中调用 setState 方法
    ..addListener(() {

      /// 调用 setState 方法后, 更新相关状态值后, 自动调用 build 方法重构组件界面
      setState(() {
        // 获取动画执行过程中的值
        animationValue = animation.value;
      });

    })

    /// 4 . 添加动画状态监听器
    /// 设置动画状态监听器
    ..addStatusListener((status) {
      /// 调用 setState 方法后, 更新相关状态值后, 自动调用 build 方法重构组件界面
      setState(() {
        /// 获取动画状态
        animationStatus = status;
      });
    });

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

          
          Text("动画状态 : $animationStatus", textDirection: TextDirection.ltr,),

          Text("动画值 : ${animationValue?.round()}", textDirection: TextDirection.ltr,),

          // 动画的主体组件
          // 6 . 布局组件中使用动画的值 , 以达到动画效果
          Container(
            /// 设置距离顶部 20 像素
            margin: EdgeInsets.only(top: 50),
            height: animationValue,
            width: animationValue,
            decoration: BoxDecoration(color: Colors.red),
          ),


        ],
      ),
    );
  }

}