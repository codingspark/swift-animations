//
//  MasterViewController.swift
//  SwiftAnimations
//
//  Created by Samuele Perricone on 18/01/2018.
//

import UIKit

typealias Closure = (() -> UIViewController)

class MasterViewController: UITableViewController {
    
    
    var sections: [String] = ["Animate your view, UIView", "Build animation with a purpose", "Beyond 🚀"]
    
    var titles: [String: [String]] = [
        "Animate your view, UIView": [
            "🕐 Basic Animation 🤓",
            "🕑 Animatable Properties",
            "🕒 Bounce Bounce",
            "🕓 Use keyframes 🔑🔑🔑"
        ],
        "Build animation with a purpose": [
            "🕔 Say Wow 😲",
            "🕕 More Content on the screen",
            "🕖 Context Feedback ⌚️",
            "🕗 Visual Feedback",
            "🕘 Blurring"
        ],
        "Beyond 🚀": [
            "🕙 Gesture Animation☝🏻",
            "🕚 Bonus ⭐️",
            "🕛 Thanks 🍾"
        ]
    ]
    
    var controllers : [String: [Closure]] = [
        "Animate your view, UIView": [
            { return BasicAnimationViewController() },
            { return AnimatablePropertiesViewController() },
            { return BounceBounceViewController() },
            { return KeyframesViewController() }
        ],
        "Build animation with a purpose": [
            { return SayWowViewController() },
            { return MoreContentViewController() },
            { return ContextFeedbackViewController() },
            { return SeekAttentiondViewController() },
            { return BlurringViewController() },
        ],
        "Beyond 🚀": [
            { return GestureViewController() },
            { return BonusViewController() },
            { return ThanksViewController() }
        ]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sections[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.titles[self.sections[section]]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.titles[self.sections[indexPath.section]]![indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let closure = self.controllers[self.sections[indexPath.section]]![indexPath.row]
        
        let controller = closure()
        
        if controller is BlurringViewController {
            
            controller.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            
            controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            self.navigationController?.present(controller, animated: true, completion: nil)
        }
        else {
        
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

