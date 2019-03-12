//
//  UIViewController+.swift
//  TodoList
//
//  Created by Huy on 3/10/19.
//  Copyright © 2019 Long. All rights reserved.
//

import UIKit
extension UIViewController {
    
    
    var appDelegate: AppDelegate? {
        
        guard let app = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return app
    }
    
    func showLoadingView(_ show: Bool, frame: CGRect? = nil) {
        if let blurView = self.view.subviews.first(where: {$0 is BlurLoadingView}) {
            blurView.isHidden = !show
            if show {
                blurView.bringSubviewToFront(self.view)
            }
        } else {
            let blurLoadingView = BlurLoadingView()
            view.addSubview(blurLoadingView)
            blurLoadingView.bringSubviewToFront(self.view)
        }
    }
}


class BlurLoadingView: UIView {
    var circleView: CircleView!
    let heightCircle: CGFloat = 76.0
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: WIDTH_DEVICE, height: HEIGHT_DEVICE)
            self.init(frame: frame)
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        setupUI()
    }
    
    func setupUI() {
        //add blur
            self.addBlurEffect()
        //add circleview
        let point = CGPoint.init(x: (WIDTH_DEVICE - heightCircle)/2, y: (self.frame.height - heightCircle)/2)
        let frame =  CGRect.init(origin: point , size: CGSize.init(width: heightCircle, height: heightCircle))
        circleView = CircleView.init(frame: frame)
        circleView.apply {
            $0.setUpAnimation(in: circleView.layer, size: circleView.frame.size)
        }
        self.addSubview(circleView)
    }
}


class CircleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor = UIColor.gray) {
        let beginTime: Double = 0.5
        let strokeStartDuration: Double = 1.2
        let strokeEndDuration: Double = 0.7
        
        let circleShapeLayer: CAShapeLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath()
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.apply {
            $0.byValue = Float.pi * 2
            $0.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        }
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.apply {
            $0.duration = strokeEndDuration
            $0.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
            $0.fromValue = 0
            $0.toValue = 1
        }
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.apply {
            $0.duration = strokeStartDuration
            $0.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
            $0.fromValue = 0
            $0.toValue = 1
            $0.beginTime = beginTime
        }
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.apply {
            $0.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
            $0.duration = strokeStartDuration + beginTime
            $0.repeatCount = .infinity
            $0.isRemovedOnCompletion = false
            $0.fillMode = CAMediaTimingFillMode.forwards
        }
        
        path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                    radius: size.width / 2,
                    startAngle: -(.pi / 2),
                    endAngle: .pi + .pi / 2,
                    clockwise: true)
        
        let frame = CGRect(
            x: (layer.bounds.width - size.width) / 2,
            y: (layer.bounds.height - size.height) / 2,
            width: size.width,
            height: size.height
        )
        circleShapeLayer.apply {
            $0.fillColor = nil
            $0.strokeColor = color.cgColor
            $0.lineWidth = 2
            $0.backgroundColor = nil
            $0.path = path.cgPath
            $0.frame = frame
            $0.add(groupAnimation, forKey: "animation")
        }
        
        layer.addSublayer(circleShapeLayer)
    }
}

public protocol Applicable {}

public extension Applicable {
    
    @discardableResult
    func apply(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: Applicable {}
