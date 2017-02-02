//
//  AppDelegate+MovieFan-ios.swift
//  MovieFan-ios
//
//  Created by Xmartlabs SRL ( https://xmartlabs.com )
//  Copyright © 2016 'Xmartlabs SRL'. All rights reserved.
//

import Alamofire
import Crashlytics
import Eureka
import Foundation

extension AppDelegate {

    func setupCrashlytics() {
        // Fabric.with([Crashlytics.self])
        // Fabric.sharedSDK().debug = Constants.Debug.crashlytics
    }

    // MARK: Alamofire notifications
    func setupNetworking() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AppDelegate.requestDidComplete(_:)),
            name: Alamofire.Notification.Name.Task.DidComplete,
            object: nil)
    }

    func requestDidComplete(_ notification: Notification) {
        guard let task = notification.userInfo?[Notification.Key.Task] as? URLSessionTask, let _ = task.response as? HTTPURLResponse else {
            DEBUGLog("Request object not a task")
            return
        }
    }

    /**
     Set up your Eureka default row customization here
     */
    func stylizeEurekaRows() {

        let genericHorizontalMargin = CGFloat(50)
        BaseRow.estimatedRowHeight = 58

        EmailRow.defaultRowInitializer = {
            $0.placeholder = NSLocalizedString("E-mail Address", comment: "")
            $0.placeholderColor = .gray
        }

        EmailRow.defaultCellSetup = { cell, _ in
            cell.layoutMargins = UIEdgeInsets.zero
            cell.contentView.layoutMargins.left = genericHorizontalMargin
            cell.height = { 58 }
        }
    }
    
    func setupDecoders() {
        Date.decoder = Date.decoder(using: Constants.Formatters.MovieDbAPIDateFormatter)
    }
}
