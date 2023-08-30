//
//  UIApplication+.swift
//  MVPBasic
//
//  Created by Nguyễn Đức Tân on 03/08/2023.
//
import UIKit

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            return scene?.windows.first(where: {
                $0.isMember(of: UIWindow.self)
            })?.rootViewController?.topMostViewController()
        } else {
            return self.windows.first(where: {
                $0.isMember(of: UIWindow.self)
            })?.rootViewController?.topMostViewController()
        }
    }
}
