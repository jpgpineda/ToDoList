//
//  UIViewController+Ext.swift
//  ToDoList
//
//  Created by javier pineda on 29/01/24.
//

import UIKit

extension UIViewController {
    func showLoader() {
        guard let loaderViewController = ModuleManager.shared.onboardingDependency.makeLoaderViewController() else { return }
        addChild(loaderViewController)
        guard let loaderView = loaderViewController.view else { return }
        loaderView.tag = 100
        view.addSubview(loaderView)
        loaderViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loaderViewController.didMove(toParent: self)
    }
    
    func dismissLoader() {
        guard let loaderView = self.view.viewWithTag(100) else { return }
        loaderView.removeFromSuperview()
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ups!", message: message, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showConfirmation(title: String,
                          message: String,
                          cancel: String?,
                          confirm: String,
                          confirmAction: @escaping() -> Void) {
        let alert = UIAlertController(title: "Ups!", message: message, preferredStyle: .actionSheet)
        if let cancel = cancel {
            alert.addAction(UIAlertAction(title: cancel, style: .destructive, handler: nil))
        }
        
        alert.addAction(UIAlertAction(title: confirm, style: .default, handler: { _ in
            confirmAction()
        }))
        
        present(alert, animated: true)
    }
}
