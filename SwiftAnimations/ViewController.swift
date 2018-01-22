//
//  BasicAnimationViewController.swift
//  SwiftAnimations
//
//  Created by Samuele Perricone on 18/01/2018.
//

import UIKit



protocol Animatable: class {
    
    func animate()
}



class BaseAnimationViewController: UIViewController, Animatable {
    
    func animate() {}
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.animate()
    }
}

class BasicAnimationViewController: BaseAnimationViewController {
    
    override func animate() {
        
        // https://www.hackingwithswift.com/example-code/uikit/how-to-animate-views-using-animatewithduration
        
        let viewToAnimate = RoundBoxView(withCenter: CGPoint(x: self.view.frame.midX, y: self.view.frame.midY))
        
        self.view.addSubview(viewToAnimate)
        
        // self.simpleAnimation1(viewToAnimate: viewToAnimate)
        // self.simpleAnimation2(viewToAnimate: viewToAnimate)
        // self.simpleAnimation3(viewToAnimate: viewToAnimate)
        // self.simpleAnimation4(viewToAnimate: viewToAnimate)
        // self.simpleAnimation5(viewToAnimate: viewToAnimate)
    }
    
    //
    //  Simple Animation
    //
    func simpleAnimation1(viewToAnimate: UIView) {
        
        UIView.animate(withDuration: 2) {
            
            viewToAnimate.alpha = 0
        }
    }
    
    //
    //  Simple Animation with removeFromSubview on completion
    //
    func simpleAnimation2(viewToAnimate: UIView) {
        
        UIView.animate(withDuration: 1, animations: {
            
            viewToAnimate.transform = CGAffineTransform.identity.scaledBy(x: 4, y: 4)
            
        }) { _ in
            
            viewToAnimate.removeFromSuperview()
        }
    }
    
    //
    //  Simple Animation with easing
    //
    func simpleAnimation3(viewToAnimate: UIView) {
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            
            viewToAnimate.transform = CGAffineTransform.identity.scaledBy(x: 4, y: 4)
            
        }) { _ in
            
            viewToAnimate.removeFromSuperview()
        }
    }
    
    //
    //  Simple Animation with custom easing
    //
    func simpleAnimation4(viewToAnimate: UIView) {
        
        // see https://medium.com/@RobertGummesson/a-look-at-uiview-animation-curves-part-3-edde651b6a7a
        // to understand how controlPoints work
        
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        // let timingFunction = CAMediaTimingFunction(controlPoints: 5/6, 0.2, 2/6, 0.9)
        
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(timingFunction)
        
        UIView.animate(withDuration: 1) {
            
            viewToAnimate.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5).rotated(by: CGFloat(Double.pi / 4))
        }
        
        CATransaction.commit()
    }
    
    
    //
    //  Simple Animation with auto-repeat
    //
    func simpleAnimation5(viewToAnimate: UIView) {
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [UIViewAnimationOptions.autoreverse, .repeat], animations: {
            
            viewToAnimate.alpha = 0
        })
    }
}


class AnimatablePropertiesViewController : BaseAnimationViewController {
    
    override func animate() {
        
        // Setup
        
        var y : CGFloat = 0.2
        
        for i in 1...8 {
            
            let x : CGFloat = i % 2 == 0 ? 0.75 : 0.25
            
            self.view.addSubview(RoundBoxView(withCenter: CGPoint(x: self.view.frame.width * x, y: self.view.frame.height * y)))
            
            // self.view.addSubview(ImageBoxView(withCenter: CGPoint(x: self.view.frame.width * x, y: self.view.frame.height * y)))
            
            if i % 2 == 0 { y += 0.15 }
        }
        
        
        //
        // Alpha
        //
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [UIViewAnimationOptions.autoreverse, .repeat], animations: {
            
            self.view.subviews[0].alpha = 0.15
        })
        
        
        //
        // CornerRadius
        //
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [UIViewAnimationOptions.autoreverse, .repeat], animations: {
            
            self.view.subviews[1].layer.cornerRadius = 50
        })
        
        
        //
        // Scale
        //
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [UIViewAnimationOptions.autoreverse, .repeat], animations: {
            
            self.view.subviews[2].transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        })
        
        
        //
        // Rotation
        //
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [UIViewAnimationOptions.autoreverse, .repeat], animations: {
            
            self.view.subviews[3].transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi))
        })
        
        
        //
        // Color
        //
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [UIViewAnimationOptions.autoreverse, .repeat], animations: {
            
            self.view.subviews[4].backgroundColor = UIColor(red:0.08, green:0.54, blue:0.75, alpha:1.00)
        })
        
        
        
        //
        // Mask animation
        //
        
        let startPath = UIBezierPath()
        
        startPath.move(to: CGPoint(x: -20, y: 0.0))
        startPath.addLine(to: CGPoint(x: 20, y: 0))
        startPath.addLine(to: CGPoint(x: 40, y: 100))
        startPath.addLine(to: CGPoint(x: 0, y: 100))
        
        startPath.close()
        
        let shape = CAShapeLayer()
        
        shape.path = startPath.cgPath
        
        view.layer.addSublayer(shape)
        
        self.view.subviews[5].layer.mask = shape
        
        
        let endPath = UIBezierPath()
        
        endPath.move(to: CGPoint(x: 100, y: 0.0))
        endPath.addLine(to: CGPoint(x: 140, y: 0))
        endPath.addLine(to: CGPoint(x: 180, y: 100))
        endPath.addLine(to: CGPoint(x: 140, y: 100))
        
        endPath.close()
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        
        pathAnimation.toValue = endPath.cgPath
        pathAnimation.duration = 0.75
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pathAnimation.autoreverses = true
        pathAnimation.repeatCount = .greatestFiniteMagnitude
        
        shape.add(pathAnimation, forKey: "pathAnimation")
        
        
        //
        // Shadow
        //
        
        let shadowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        
        shadowAnimation.fromValue = 32
        shadowAnimation.toValue = 4
        shadowAnimation.duration = 2
        shadowAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        shadowAnimation.autoreverses = true
        shadowAnimation.repeatCount = .greatestFiniteMagnitude
        
        self.view.subviews[6].layer.shadowColor = UIColor.black.cgColor
        self.view.subviews[6].clipsToBounds = false
        self.view.subviews[6].layer.shadowRadius = 32
        self.view.subviews[6].layer.shadowOpacity = 0.8
        self.view.subviews[6].layer.add(shadowAnimation, forKey: "shadowRadius")
        
        
        
        //
        // Frame
        //
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [UIViewAnimationOptions.autoreverse, .repeat], animations: {
            
            self.view.subviews[7].frame = CGRect(x: -100, y: self.view.frame.height - 100, width: self.view.frame.width + 200, height: 200)
            self.view.subviews[7].layer.cornerRadius = 0
            
        })
        
        //        UIView.animate(withDuration: 1.5, delay: 0, options: [UIViewAnimationOptions.autoreverse, .repeat], animations: {
        //
        //            self.view.subviews[7].frame = self.view.bounds
        //            self.view.subviews[7].layer.cornerRadius = 0
        //            (self.view.subviews[7] as! ImageBoxView).imageView.layer.cornerRadius = 0
        //
        //        })
    }
}

class BounceBounceViewController : BaseAnimationViewController {
    
    override func animate() {
        
        let viewToAnimate = RoundBoxView(withCenter: CGPoint(x: self.view.frame.midX, y: self.view.frame.midY))
        
        self.view.addSubview(viewToAnimate)
        
        // self.bounceAnimation1(viewToAnimate: viewToAnimate)
        // self.bounceAnimation2(viewToAnimate: viewToAnimate)
        // self.bounceAnimation3(viewToAnimate: viewToAnimate)
    }
    
    func bounceAnimation1(viewToAnimate: UIView) {
        
        // Spring Animations
        
        UIView.animate(withDuration: 1.5, delay: 1.5, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            
            viewToAnimate.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 200)
        })
    }
    
    func bounceAnimation2(viewToAnimate: UIView) {
        
        // Spring Animations nested
        
        UIView.animate(withDuration: 2, delay: 1.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            
            viewToAnimate.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 200)
            
        }) { _ in
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                
                viewToAnimate.alpha = 0
                
            }) { _ in
                
                viewToAnimate.removeFromSuperview()
            }
        }
    }
    
    func bounceAnimation3(viewToAnimate: UIView) {
        
        // Nesting Animations
        
        UIView.animate(withDuration: 1.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            
            viewToAnimate.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 200)
            
        }) { _ in
            
            UIView.animate(withDuration: 1.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                
                viewToAnimate.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -200)
                
            }) { _ in
                
                UIView.animate(withDuration: 1.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                    
                    viewToAnimate.transform = CGAffineTransform.identity  
                })
            }
        }
    }
}

class KeyframesViewController : BaseAnimationViewController {
    
    // https://equaleyes.com/blog/2017/12/21/ios-learn-to-properly-chain-uiview-animations-with-animatekeyframes/
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.label.frame = self.view.bounds
        
        self.label.textColor = UIColor.orange
        
        self.label.text = "🏋🏻‍♂️\nWORKOUT COMPLETED!\n☠️"
        
        self.label.font = UIFont.boldSystemFont(ofSize: 36)
        
        self.label.numberOfLines = 0
        
        self.label.alpha = 1.0
        
        self.label.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        
        self.label.textAlignment = .center
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture(recognizer:))))
        
        self.view.addSubview(self.label)
    }
    
    
    @objc func tapGesture( recognizer: UITapGestureRecognizer) {
        
        self.label.layer.removeAllAnimations()
    }
    
    override func animate() {
        
        // self.recursiveAnimations()
        self.keyframeAnimation()
    }
    
    
    //
    // Recursive animations
    //
    func recursiveAnimations() {
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.label.alpha = 0.1
            self.label.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            
        }) { _ in
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.label.alpha = 1.0
                self.label.transform = CGAffineTransform(scaleX: 1.25, y: 1.25).rotated(by: CGFloat(Double.pi / 6))
                
            }) { _ in
                
                UIView.animate(withDuration: 0.25, animations: {
                    
                    self.label.alpha = 1.0
                    self.label.transform = CGAffineTransform(scaleX: 0.75, y: 0.75).rotated(by: -CGFloat(Double.pi / 6))
                    
                }) { _ in
                    
                    self.recursiveAnimations()
                }
            }
        }
    }
    
    
    //
    //  Keyframes
    //
    func keyframeAnimation() {
        
        let duration = 1.5
        
        // calculationModePaced, calculationModeLinear, calculationModeDiscrete, calculationModeCubic, calculationModeCubicPaced
        
        UIView.animateKeyframes(withDuration: duration, delay: 1.0, options: [.repeat, .autoreverse, .calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0 / duration, relativeDuration: 0.25 / duration) {
                
                self.label.alpha = 0.1
                self.label.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25 / duration, relativeDuration: 0.25 / duration) {
                
                self.label.alpha = 1.0
                self.label.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            }
            
//            UIView.addKeyframe(withRelativeStartTime: 0.5 / duration, relativeDuration: 0.25 / duration) {
//
//                self.label.transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi) * 0.1)
//            }
//            
//            UIView.addKeyframe(withRelativeStartTime: 0.75 / duration, relativeDuration: 0.25 / duration) {
//
//                self.label.transform = CGAffineTransform.identity.rotated(by: -CGFloat(Double.pi) * 0.1)
//            }
            
        })
    }
    
}

class SayWowViewController : BaseAnimationViewController {
    
    // Just say about Lottie to convert great animation made in Adobe AfterEffect
    // https://airbnb.design/introducing-lottie/
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func animate() {
        
        
        let imageView = UIImageView(frame: self.view.bounds)
        
        imageView.image = UIImage(named: "beast.jpg")
        
        imageView.alpha = 0
        
        imageView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9).translatedBy(x: 20, y: 0)
        
        self.view.addSubview(imageView)
        
        
        let messageLabel = UILabel(frame: CGRect(x: 20, y: self.view.bounds.height / 2, width: self.view.bounds.width - 40, height: self.view.bounds.height / 2))
        
        messageLabel.text = "Welcome to the Jungle"
        
        messageLabel.textColor = UIColor.white
        
        messageLabel.alpha = 0
        
        messageLabel.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 40)
        
        messageLabel.font = messageLabel.font.withSize(32)
        
        self.view.addSubview(messageLabel)
        
        
        UIView.animate(withDuration: 1, delay: 2, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            imageView.transform = CGAffineTransform.identity
            imageView.alpha = 1
            
        })
        
        UIView.animate(withDuration: 0.7, delay: 2.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            messageLabel.transform = CGAffineTransform.identity
            messageLabel.alpha = 1
            
        }) { _ in
            
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}

class MoreContentViewController : BaseAnimationViewController {
    
    // UILabel alternation
    
    // Expanding Button
    
    private let container = UIView()
    
    private let labelA = UILabel()
    
    private let labelB = UILabel()
    
    private let button = UIButton()
    
    private let buttons = [UIButton(), UIButton(), UIButton()]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.container.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: 44)
        
        self.container.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.height - 100)
        
        self.container.layer.cornerRadius = 8
        
        self.container.backgroundColor = UIColor.blue
        
        self.container.clipsToBounds = true
        
        
        self.labelA.frame = self.container.bounds
        
        self.labelA.textColor = UIColor.white
        
        self.labelA.text = "Downloading..."
        
        self.labelA.font = UIFont.boldSystemFont(ofSize: 23)
        
        self.labelA.numberOfLines = 0
        
        self.labelA.alpha = 0.0
        
        self.labelA.textAlignment = .center
        
        self.container.addSubview(self.labelA)
        
        
        self.labelB.frame = self.container.bounds
        
        self.labelB.textColor = UIColor.white
        
        self.labelB.text = "3 minutes remaining"
        
        self.labelB.font = UIFont.boldSystemFont(ofSize: 23)
        
        self.labelB.numberOfLines = 0
        
        self.labelB.alpha = 0.0
        
        self.labelB.textAlignment = .center
        
        self.container.addSubview(self.labelB)
        
        
        
        self.view.addSubview(self.container)
        
        
        self.button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        self.button.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        
        self.button.layer.cornerRadius = 22
        
        self.button.backgroundColor = UIColor.orange
        
        self.button.layer.borderWidth = 2
        
        self.button.layer.borderColor = UIColor.darkGray.cgColor
        
        self.view.addSubview(self.button)
        
        self.button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        
        
        for button in self.buttons {
            
            button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            button.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
            button.layer.cornerRadius = 22
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.black.cgColor
            button.alpha = 0
            button.addTarget(self, action: #selector(applyColor(button:)), for: .touchUpInside)
            
            self.view.addSubview(button)
        }
        
        self.buttons[0].backgroundColor = UIColor.orange
        self.buttons[1].backgroundColor = UIColor.green
        self.buttons[2].backgroundColor = UIColor.darkGray
    }
    
    @objc func changeColor() {
        
        //
        // Stagger Animation
        //
        
        var delay = 0.0
        
        for button in self.buttons {
            
            UIView.animate(withDuration: 0.4, delay: delay, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                button.alpha = 1
                
                if let index = self.buttons.index(of: button), index == 0 {
                    
                    button.transform = CGAffineTransform.identity.translatedBy(x: -100, y: 0)
                }
                else if let index = self.buttons.index(of: button), index == 1 {
                    
                    button.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -100)
                }
                else if let index = self.buttons.index(of: button), index == 2 {
                    
                    button.transform = CGAffineTransform.identity.translatedBy(x: 100, y: 0)
                }
                
            })
            
            delay += 0.15
        }
        
        self.button.isEnabled = false
        
        UIView.animate(withDuration: 0.4, delay: delay, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.button.transform = CGAffineTransform.identity.scaledBy(x: 0.2, y: 0.2)
            
        })
    }
    
    @objc func applyColor(button: UIButton) {
        
        var color = UIColor.orange
        
        if let index = self.buttons.index(of: button), index == 0 {
            
            color = UIColor.orange
        }
        else if let index = self.buttons.index(of: button), index == 1 {
            
            color = UIColor.green
        }
        else if let index = self.buttons.index(of: button), index == 2 {
            
            color = UIColor.darkGray
        }
        
        UIView.animate(withDuration: 0.7, animations: {
            
            self.view.backgroundColor = color
            self.button.transform = CGAffineTransform.identity
            
        }) { _ in
            
            self.button.isEnabled = true
        }
        
        var delay = 0.0
        
        for button in self.buttons {
            
            UIView.animate(withDuration: 0.4, delay: delay, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                button.alpha = 0
                button.transform = CGAffineTransform.identity
                
            })
            
            delay += 0.15
        }
    }
    
    override func animate() {
        
        
        let duration = 5.5
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: [.repeat], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0 / duration, relativeDuration: 0.5 / duration) {
                
                self.labelA.alpha = 1
                self.labelB.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 2 / duration, relativeDuration: 0.5 / duration) {
                
                self.labelA.alpha = 0
                self.labelB.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 2.5 / duration, relativeDuration: 0.5 / duration) {
                
                self.labelA.alpha = 0
                self.labelB.alpha = 1
            }
            
            UIView.addKeyframe(withRelativeStartTime: 5 / duration, relativeDuration: 0.5 / duration) {
                
                self.labelA.alpha = 0
                self.labelB.alpha = 0
            }
            
        }, completion: nil)
    }
}

class ContextFeedbackViewController : BaseAnimationViewController {
    
    // https://www.youtube.com/watch?v=DNr5D7DSMr8
    
    // consider the proximity of a external sensor to react and show something in the interface, such as the presence of a bluetooth device nearby
    // or checking the time you can dark your screen like google maps
    //
    // the advice is always give a smooth transition to the user and give a visual feedback of what is happening
    
    
    let sensor = SmartDeviceBoxView(withCenter: CGPoint.zero)
    
    let switcher = UISwitch()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.sensor.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        self.sensor.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        
        self.view.addSubview(self.sensor)
        
        self.switcher.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.height * 0.75)
        
        self.view.addSubview(self.switcher)
        
        self.switcher.addTarget(self, action: #selector(switched), for: UIControlEvents.valueChanged)
        
    }
    
    @objc func switched() {
        
        if self.switcher.isOn {
            
            self.pulse()
        }
    }
    
    func pulse() {
        
        let pulse = PulseLayer()
        
        pulse.position = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        
        self.view.layer.addSublayer(pulse)
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            if self.switcher.isOn {
                
                self.pulse()
            }
        }
    }
}

class SeekAttentiondViewController : BaseAnimationViewController {
    
    // State change to seek attention, like 'tada' animation
    
    // UILabel have troubles with animations
    // http://nshint.io/blog/2015/07/04/how-to-animate-uilabel-properties/
    
    
    private let container = UIView()
    
    private let label = UILabel()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.container.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        
        self.container.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        
        self.container.layer.cornerRadius = 12
        
        self.container.clipsToBounds = true
        
        self.container.backgroundColor = UIColor.darkGray
        
        
        self.label.frame = self.container.bounds
        
        self.label.textColor = UIColor.white
        
        self.label.font = UIFont.boldSystemFont(ofSize: 40)
        
        self.label.textAlignment = .center
        
        self.label.isUserInteractionEnabled = true
        
        self.view.addSubview(self.container)
        
        self.container.addSubview(self.label)
        
        
        self.refresh()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
            DispatchQueue.main.async {
                
                self.refresh()
            }
        }
        
        
        let button = MaterialButton()
        
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        button.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.height * 0.75)
        
        button.backgroundColor = UIColor.orange
        
        self.view.addSubview(button)
        
        
        button.setTitle("PRESS ME", for: UIControlState.normal)
        
        
        //                button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        //
        //                button.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.height * 0.75)
        //
        //                button.setTitle("BUY", for: UIControlState.normal)
        //
        //                button.addTarget(self, action: #selector(buy(button:)), for: .touchUpInside)
    }
    
    @objc func buy(button: UIButton) {
        
        UIView.animate(withDuration: 0.5) {
            
            button.setTitle("INSTALL", for: UIControlState.normal)
            button.bounds = CGRect(x: 0, y: 0, width: 200, height: 50)
        }
    }
    
    func refresh() {
        
        let value = 45 + Int(arc4random_uniform(140))
        
        self.label.text = "\(value) bpm"
        
        if value > 130 {
            
            self.animateWarning()
        }
        else {
            
            self.animateNormal()
        }
    }
    
    func animateNormal() {
        
        UIView.animate(withDuration:0.5) {
            
            self.container.backgroundColor = UIColor.darkGray
        }
    }
    
    func animateWarning() {
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            
            self.container.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.container.backgroundColor = UIColor.red
            
        }, completion: {(success: Bool) in
            
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
                
                self.container.transform = CGAffineTransform.identity
                
            }, completion: nil)
        })
    }
}

/**
 *  Demostrates what happen when we apply a fade animation to a blurred UIView using a UIVisualEffect.
 */
class BlurringViewController : BaseAnimationViewController {
    
    
    private let blurEffectView = UIVisualEffectView()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        
        self.view.addSubview(self.blurEffectView)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exit)))
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.blurEffectView.frame = self.view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.8, delay: 0, options: .allowUserInteraction, animations: {
            
            self.view.backgroundColor = UIColor.clear
            
            self.blurEffectView.effect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        })
    }
    
    @objc func exit() {
        
        self.dismiss(animated: true)
    }
}

/**
 *  Demostrates how to use UIViewPropertyAnimator combined with UIPanGestureRecognizer to control the position
 *  of a UIView using the animation timeline.
 */
class GestureViewController : BaseAnimationViewController {
    
    // https://www.youtube.com/watch?v=-BiGO7CJZ7Q&t=112s
    
    // https://medium.com/@daniel_larsson/interactive-animations-with-uiviewpropertyanimator-284580951c62
    
    // https://developer.apple.com/documentation/uikit/uiviewpropertyanimator
    
    private var panGestureRecognizer : UIPanGestureRecognizer?
    
    private var animator : UIViewPropertyAnimator?
    
    private let messageLabel = UILabel()
    
    
    override func animate() {
        
        self.messageLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 40, height: 300)
        
        self.messageLabel.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        
        self.messageLabel.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -self.view.frame.height)
        
        self.messageLabel.clipsToBounds = true
        
        self.messageLabel.backgroundColor = UIColor.red
        
        self.messageLabel.layer.cornerRadius = 12
        
        self.messageLabel.layer.shadowOpacity = 0.2
        
        self.messageLabel.layer.shadowColor = UIColor.black.cgColor
        
        self.messageLabel.layer.shadowRadius = 12
        
        self.messageLabel.text = "ERROR"
        
        self.messageLabel.textColor = UIColor.white
        
        self.messageLabel.textAlignment = .center
        
        self.messageLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        self.messageLabel.isUserInteractionEnabled = true
        
        self.view.addSubview(self.messageLabel)
        
        
        UIView.animate(withDuration: 1.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            
            self.messageLabel.transform = CGAffineTransform.identity
            
        }) { _ in }
        
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(drag(recognizer:)))
        
        self.messageLabel.addGestureRecognizer(panGestureRecognizer)
        
        self.panGestureRecognizer = panGestureRecognizer
    }
    
    @objc func drag(recognizer: UIPanGestureRecognizer) {
        
        if recognizer.state == .began {
            
            if let animator = self.animator, animator.isRunning {
                
                return
            }
            
            self.animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.8, animations: {
                
                self.messageLabel.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -self.view.frame.height).scaledBy(x: 0.5, y: 0.5)
                self.messageLabel.alpha = 0
            })
        }
        else if recognizer.state == .changed {
            
            if let animator = self.animator, animator.isRunning {
                
                return
            }
            
            let translation = recognizer.translation(in: self.view.superview).y
            
            if translation > 0 {
                
                return
            }
            
            var progress = abs(translation / self.view.frame.height)
            
            progress = max(0.001, min(0.999, progress))
            
            self.animator?.fractionComplete = progress
        }
        else {
            
            // ended or cancelled
            
            recognizer.isEnabled = false
            
            let translation = abs(recognizer.translation(in: self.view.superview).y)
            
            if translation > self.view.frame.height * 0.4 {
                
                // Go out
                
                self.animator?.isReversed = false
                
                self.animator?.addCompletion({ _ in
                    
                    recognizer.isEnabled = true
                })
            }
            else {
                
                // Return to start position
                
                self.animator?.isReversed = true
                
                self.animator?.addCompletion({ _ in
                    
                    recognizer.isEnabled = true
                })
            }
            
            self.animator?.continueAnimation(withTimingParameters: UISpringTimingParameters(dampingRatio: 0.8, initialVelocity: CGVector(dx: 0, dy: 0)), durationFactor: 1.0)
        }
    }
}

/**
 *
 *  Demostrate how to use CADisplayLink for realtime drawing or chart
 *
 */
class BonusViewController : BaseAnimationViewController {
    
    private let labelA = UILabel()
    
    private let shape : CAShapeLayer = CAShapeLayer()
    
    private var phase : Double = 0
    
    
    override func animate() {
        
        self.view.layer.addSublayer(shape)
        
        self.shape.strokeColor = UIColor.orange.cgColor
        
        self.shape.lineWidth = 4
        
        self.shape.fillColor = UIColor.clear.cgColor
        
        let animationTimer = CADisplayLink(target: self, selector: #selector(updateTime))
        
        //                if #available(iOS 10.0, *) {
        //                    animationTimer.preferredFramesPerSecond = 1
        //                }
        //
        //                self.labelA.frame = self.view.bounds
        //
        //                self.labelA.textColor = UIColor.darkGray
        //
        //                self.labelA.text = "\(String(format: "%.0f", self.phase))"
        //
        //                self.labelA.font = UIFont.boldSystemFont(ofSize: 100)
        //
        //                self.labelA.textAlignment = .center
        //
        //                self.view.addSubview(self.labelA)
        
        
        animationTimer.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        
        
        
    }
    
    @objc func updateTime() {
        
        let amplitude : CGFloat = 0.1
        
        let multiplier = 2.0
        
        let degrees = 360.0 * multiplier
        
        let origin = CGPoint(x: 0, y: self.view.frame.height * 0.5)
        
        let path = UIBezierPath()
        
        for angle in stride(from: 0.0, through: degrees, by: 5.0) {
            
            let x = origin.x + CGFloat(angle / degrees) * self.view.frame.width
            
            let y = origin.y - CGFloat(sin((angle + self.phase)/180.0 * Double.pi)) * self.view.frame.height * amplitude
            
            if angle == 0.0 {
                
                path.move(to: CGPoint(x: x, y: y))
            }
            else {
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        self.shape.path = path.cgPath
        //
        //                let animation = CATransition()
        //
        //                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        //
        //                animation.type = kCATransitionFade
        //
        //                animation.duration = 0.8 // 0.2
        //
        //                self.labelA.layer.add(animation, forKey: kCATransitionFade)
        //
        //                self.labelA.text = "\(String(format: "%.0f", self.phase))"
        
        self.phase += 5.0
    }
}

class ThanksViewController : BaseAnimationViewController {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.darkGray
    }
    
    override func animate() {
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        let label = UILabel(frame: self.view.bounds)
        
        label.textColor = UIColor.orange
        
        label.text = "Thanks"
        
        label.font = UIFont.boldSystemFont(ofSize: 72)
        
        label.numberOfLines = 0
        
        label.alpha = 0.0
        
        label.textAlignment = .center
        
        self.view.addSubview(label)
        
        let duration = 1.2
        
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0 / duration, relativeDuration: 0.4) {
                
                label.alpha = 1.0
            }
            
        }, completion: nil)
    }
}
