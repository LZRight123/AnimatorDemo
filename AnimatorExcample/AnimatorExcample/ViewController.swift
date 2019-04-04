//
//  ViewController.swift
//  AnimatorExcample
//
//  Created by 梁泽 on 2019/4/4.
//  Copyright © 2019 梁泽. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate let duration: TimeInterval = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        originAnimation()
        animatorAnimation()
        groupAnimation()
    }
    
}

extension ViewController {
    //先淡出 再放大成 200 200 ，再淡入
    fileprivate func originAnimation() {
        let view = UIView(frame: CGRect(x: 0, y: 100, width: 50, height: 50))
        view.backgroundColor = .red
        view.alpha = 0
        self.view.addSubview(view)
        
        
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
    }
    
    fileprivate func animatorAnimation() {
        let view = UIView(frame: CGRect(x: 0, y: 300, width: 50, height: 50))
        view.backgroundColor = .blue
        view.alpha = 0
        self.view.addSubview(view)
        
        view.animate([
            .fadeIn(),
            .resize(to: CGSize(width: 200, height: 200)),
            .fadeOut()
            ])
    }
    
    fileprivate func groupAnimation() {
        let view1 = UIView(frame: CGRect(x: 200, y: 100, width: 50, height: 50))
        view1.backgroundColor = .blue
        let view2 = UIView(frame: CGRect(x: 200, y: 300, width: 50, height: 50))
        view2.backgroundColor = .red
        view.addSubview(view1)
        view.addSubview(view2)
        
        
//        Animation.custom(duration: duration, closure: { $0.frame = CGRect(x: 200, y: 100, width: 70, height: 200) })
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
    }
}



