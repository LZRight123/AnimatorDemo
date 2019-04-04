# AnimatorDemo
以前，假设我们想在视图大小之前添加淡入，之后加入淡出，我们必须编写如下内容：

```
UIView.animate(withDuration: duration, animations: {
view.alpha = 1
}) { (_) in
UIView.animate(withDuration: self.duration, animations: {
view.bounds.size = CGSize(width: 200, height: 200)
view.frame.origin = CGPoint(x: 0, y: 100)
}, completion: { (_) in
UIView.animate(withDuration: self.duration, animations: {
view.alpha = 0
}, completion: nil)
})
}

```
现在，我们用声明式的API

```
view.animate([
.fadeIn(),
.resize(to: CGSize(width: 200, height: 200)),
.fadeOut()
])
```
之前我们想在view1动画结束后，执行view2的动画，代码如下：

```
UIView.animate(withDuration: duration, animations: {
view1.frame = CGRect(x: 200, y: 100, width: 70, height: 200)
}) { _ in
UIView.animate(withDuration: self.duration, animations: {
view1.alpha = 0
}, completion: { _ in
UIView.animate(withDuration: self.duration, animations: {
view2.frame = CGRect(x: 200, y: 300, width: 30, height: 250)
}, completion: { _ in
UIView.animate(withDuration: self.duration, animations: {
view2.alpha = 0
}, completion: nil)
})
})
}
```

现在:

```
Animator.animation(
view1.animate(
.custom(duration: duration, closure: { $0.frame = CGRect(x: 200, y: 100, width: 70, height: 200) }),
.fadeOut(duration)
),
view2.animate(
.custom(duration: duration, closure: { $0.frame = CGRect(x: 200, y: 300, width: 30, height: 250) }),
.fadeOut(duration)
)
)
```

![image](https://github.com/LZRight123/AnimatorDemo/blob/master/AnimatorExcample/AnimatorExcample/AnimatorUML.jpg)
