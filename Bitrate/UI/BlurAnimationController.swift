//
//  BlurAnimationController.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 20/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//


import UIKit

final class BlurAnimatorController: NSObject, UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BlurAnimation.init(for: false)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BlurAnimation.init(for: true)
    }
    
    
    private final class BlurAnimation: NSObject, UIViewControllerAnimatedTransitioning {
        
        private let isDismiss: Bool
        
        init(for dismiss: Bool) {
            isDismiss = dismiss
            
            super.init()
        }
        
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)
            -> TimeInterval {
                return 1
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            let key: UITransitionContextViewKey = (isDismiss) ? .from : .to
            let tmp = transitionContext.view(forKey: key)
            
            guard let effectView = tmp as? UIVisualEffectView else {
                fatalError("Target VC must have UIVisualEffectView as root")
            }
            
            let containerView = transitionContext.containerView
            effectView.frame = containerView.bounds
            containerView.addSubview(effectView)
            
            if !self.isDismiss {
                effectView.effect = nil
            }
            
            let animations = {
                effectView.effect = self.isDismiss ? nil : UIBlurEffect.init(style: .light)
            }
            
            let duration = self.transitionDuration(using: transitionContext)
            
            UIView.animate(
                withDuration: duration,
                delay: 0.0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.0,
                options: [.curveEaseOut],
                animations: animations,
                completion: { completed in
                    transitionContext.completeTransition(completed)
            }
            )
        }
        
        
    }
}
