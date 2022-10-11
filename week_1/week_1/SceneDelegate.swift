//
//  SceneDelegate.swift
//  week_1
//
//  Created by 권오준 on 2022/10/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Property
    
    var window: UIWindow?
    let resignView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock")
        imageView.backgroundColor = .white
        
        return imageView
    }()
    
    
    // MARK: - Func

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("sceneDidDisconnect")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("sceneDidBecomeActive")
        
        self.resignView.removeFromSuperview()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("sceneWillResignActive")
        
        self.resignView.frame = UIScreen.main.bounds
        
        self.window?.rootViewController?.view.addSubview(self.resignView)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("sceneWillEnterForeground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("sceneDidEnterBackground")
    }


}

