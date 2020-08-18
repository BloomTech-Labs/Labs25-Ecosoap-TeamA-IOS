//
//  SceneDelegate.swift
//  LabsScaffolding
//
//  Created by Spencer Curtis on 6/17/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit
import OktaAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    var appCoordinator: AppFlowCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: windowScene)
        appCoordinator = AppFlowCoordinator(window: window!)
        appCoordinator?.start()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }

        appCoordinator?.oktaAuth.receiveCredentials(fromCallbackURL: url) { [weak self] result in
            let notificationName: Notification.Name
            do {
                try result.get()
                guard (try? self?.appCoordinator?.oktaAuth.credentialsIfAvailable()) != nil
                    else { return }
                notificationName = .oktaAuthenticationSuccessful
            } catch {
                notificationName = .oktaAuthenticationFailed
            }
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: notificationName, object: nil)
            }
        }
    }
}
