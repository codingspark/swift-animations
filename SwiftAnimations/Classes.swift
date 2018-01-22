//
//  Classes.swift
//  SwiftAnimations
//
//  Created by Samuele Perricone on 21/01/2018.
//

import UIKit

class RoundBoxView : UIView {
    
    init(withCenter center: CGPoint) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        self.center = center
        
        self.backgroundColor = UIColor.orange
        
        self.layer.cornerRadius = 16
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CircleBoxView : RoundBoxView {
    
    override init(withCenter center: CGPoint) {
        
        super.init(withCenter: center)
        
        self.layer.cornerRadius = 50
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ImageBoxView : RoundBoxView {
    
    let imageView = UIImageView(image: UIImage(named: "sample.jpg"))
    
    override var frame: CGRect {
        
        didSet {
            
            self.imageView.frame = self.bounds
            
            self.imageView.layer.cornerRadius = self.layer.cornerRadius
        }
    }
    
    override init(withCenter center: CGPoint) {
        
        super.init(withCenter: center)
        
        self.addSubview(self.imageView)
        
        self.imageView.frame = self.bounds
        
        self.imageView.layer.cornerRadius = self.layer.cornerRadius
        
        self.imageView.contentMode = .scaleAspectFill
        
        self.imageView.clipsToBounds = true
        
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SmartDeviceBoxView : CircleBoxView {
    
    let imageView = UIImageView(image: UIImage(named: "plant.png"))
    
    override var frame: CGRect {
        
        didSet {
            
            self.imageView.frame = self.bounds
            
            self.imageView.layer.cornerRadius = self.layer.cornerRadius
        }
    }
    
    override init(withCenter center: CGPoint) {
        
        super.init(withCenter: center)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.imageView)
        
        self.imageView.frame = self.bounds
        
        self.imageView.layer.cornerRadius = self.layer.cornerRadius
        
        self.imageView.contentMode = .scaleAspectFill
        
        self.imageView.clipsToBounds = true
        
        self.layer.shadowRadius = 32
        
        self.layer.shadowOpacity = 0.8
        
        self.clipsToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class PulseLayer: CALayer, CAAnimationDelegate {
    
    
    let radius: CGFloat = 240.0
    
    
    override init() {
        
        super.init()
        
        self.contentsScale = UIScreen.main.scale
        
        self.opacity = 0.0
        
        self.backgroundColor = UIColor.clear.cgColor
        
        self.borderColor = UIColor.green.cgColor
        
        self.borderWidth = 8.0
        
        self.bounds = CGRect(x: 0.0, y: 0.0, width: 2 * self.radius, height: 2 * self.radius)
        
        self.cornerRadius = self.radius
        
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        
        scaleAnimation.fromValue = 0.0
        
        scaleAnimation.toValue = 1.0
        
        scaleAnimation.duration = 3.0
        
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        
        opacityAnimation.duration = 3.0
        
        opacityAnimation.fromValue = 1.0
        
        opacityAnimation.toValue = 0.0
        
        opacityAnimation.isRemovedOnCompletion = true
        
        opacityAnimation.delegate = self
        
        
        let animationGroup = CAAnimationGroup()
        
        animationGroup.duration = 3.0
        
        animationGroup.repeatCount = 0
        
        animationGroup.isRemovedOnCompletion = true
        
        animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        
        animationGroup.animations = [scaleAnimation, opacityAnimation]
        
        
        self.add(animationGroup, forKey: "pulse")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        self.removeAllAnimations()
        
        self.removeFromSuperlayer()
    }
}



class MaterialButton: UIButton {
    
    
    private var touchOverlay = UIView()
    
    
    override var frame: CGRect {
        
        didSet {
            
            self.touchOverlay.frame = self.bounds
        }
    }
    
    override var bounds: CGRect {
        
        didSet {
            
            self.touchOverlay.frame = self.bounds
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.isExclusiveTouch = true
        
        
        self.backgroundColor = UIColor.clear
        
        
        self.touchOverlay.frame = self.bounds
        
        self.touchOverlay.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        
        self.touchOverlay.isHidden = true
        
        self.addSubview(self.touchOverlay)
        
        
        self.touchOverlay.layer.cornerRadius = 12
        
        self.layer.cornerRadius = 12
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        
        self.showOverlay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
        
        self.hideOverlay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesCancelled(touches, with: event)
        
        self.hideOverlay()
    }
    
    
    fileprivate func showOverlay() {
        
        self.touchOverlay.alpha = 0.0
        
        self.bringSubview(toFront: self.touchOverlay)
        
        self.touchOverlay.isHidden = false
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            
            self.touchOverlay.alpha = 1.0
            
            self.transform = CGAffineTransform(scaleX: 0.99, y: 0.99).translatedBy(x: 0, y: 4)
        })
    }
    
    fileprivate func hideOverlay() {
        
        self.bringSubview(toFront: self.touchOverlay)
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            
            self.touchOverlay.alpha = 0.0
            
            self.transform = CGAffineTransform.identity
            
        }) { _ in
            
            self.touchOverlay.isHidden = true
        }
    }
}
