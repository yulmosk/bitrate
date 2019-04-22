//
//  PopupController.swift
//  Bitrate
//
//  Created by Yulia Moskaleva on 20/04/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import UIKit

struct PopupAction {
    let title: String
    let handler: ((PopupAction) -> Void)?
}

final class PopupController: UIViewController {
    
    @IBOutlet weak var effectView: UIVisualEffectView!
    @IBOutlet weak var contentView: ShadowView!
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var stackViewButtons: UIStackView!
    
    private let animator = BlurAnimatorController()
    
    private var popupActions: [PopupAction] = []
    
    public convenience init(_ message: String, actions: [PopupAction]) {
        self.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overFullScreen
        modalPresentationCapturesStatusBarAppearance = true
        transitioningDelegate = animator
        
        loadViewIfNeeded()
        
        labelTitle.text = message
        
        for (index, action) in actions.enumerated() {
            let button = UIButton.defaultButton(with: action.title.uppercased())
            button.tag = index
            
            button.addTarget(
                self, action: #selector(handleActionButton), for: .touchUpInside
            )
            stackViewButtons.addArrangedSubview(button)
        }
        popupActions.append(contentsOf: actions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let y = 1.2 * contentView.center.y / 0.5
        
        let layer = contentView.layer
        layer.transform = CATransform3DMakeTranslation(0, -y, 0)
        
        animateAlong { (_) in
            layer.transform = CATransform3DIdentity
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let layer = contentView.layer
        let y = 1.1 * contentView.center.y / 0.5
        
        animateAlong { (_) in
            layer.transform = CATransform3DMakeTranslation(0, y, 0)
        }
    }
    
    private func animateAlong(
        _ actions: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void
        ) {
        if let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: actions, completion: nil)
        }
    }
    
    @objc private func handleActionButton(_ sender: UIButton) {
        let action = popupActions[sender.tag]
        self.dismiss(animated: true) {
            if let handler = action.handler {
                handler(action)
                
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

extension PopupController {
    class func present(
        for error: Error?,
        on vc: UIViewController,
        completion: (() -> Void)? = nil)
    {
        if let error = error {
            present(with: error.localizedDescription, on: vc, completion: completion)
        }
    }
    
    class func present(
        with message:String,
        on vc: UIViewController,
        completion: (() -> Void)? = nil)
    {
        guard vc.presentedViewController == nil else { return }
        
        let action = PopupAction(
            title: "I got it", handler: nil
        )
        let popupVC = PopupController.init(message, actions: [action])
        vc.present(popupVC, animated: true, completion: completion)
    }
}
