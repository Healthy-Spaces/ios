//
//  OnBoardingViewController.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/28/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit
import ResearchKit
import CoreGraphics

class OnBoardingViewController: UIViewController, UIPageViewControllerDelegate, UIWebViewDelegate {
    
    var pageViewController: UIPageViewController?
    var joinButton: UIButton? = nil
    var alreadyJoinedButton: UIButton? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FIXME: TEMPORARY DONE BUTTON
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(goToTasks))
        
        // Set background color to tint color
        self.view.backgroundColor = UIApplication.shared.keyWindow?.tintColor
        
        // Customize navigation bar
        self.navigationController?.navigationBar.barTintColor = UIApplication.shared.keyWindow?.tintColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.layer.borderColor = UIApplication.shared.keyWindow?.tintColor.cgColor
        self.navigationController?.navigationBar.barStyle = .black
        
        // Setup pageViewController
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController?.delegate = self
        
        let startingViewController: OnBoardingContentViewController = self.modelDataSource.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController?.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        
        self.pageViewController?.dataSource = self.modelDataSource
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview((self.pageViewController?.view)!)
        
        // Resize Web View
        let webView = view.subviews[0] as UIView
        webView.frame = CGRect(x: webView.frame.origin.x, y: 64, width: webView.frame.size.width, height: webView.frame.size.height - 150)
        
        // Add join button
        if self.joinButton == nil {
            self.joinButton = UIButton(type: .custom)
        }
        self.joinButton?.setTitle("Join Study", for: .normal)
        self.joinButton?.setTitleColor(UIApplication.shared.keyWindow?.tintColor, for: .highlighted)
        self.joinButton?.setBackgroundImage(imageWithColor(UIColor.white), for: .highlighted)
        self.joinButton?.backgroundColor = UIColor.clear
        self.joinButton?.layer.cornerRadius = 5
        self.joinButton?.layer.borderWidth = 1
        self.joinButton?.layer.borderColor = UIColor.white.cgColor
        self.joinButton?.frame.size.width = 160
        self.joinButton?.frame.size.height = 40
        self.joinButton?.sizeToFit()
        self.joinButton?.clipsToBounds = true
        self.joinButton?.addTarget(self, action: #selector(joinStudy), for: .touchUpInside)
        self.joinButton?.frame = CGRect(x: self.view.frame.size.width/2 - 80, y: self.view.frame.height * 0.87, width: 160, height: 40);
        self.view.addSubview(self.joinButton!)
        
        // Add already joined button
        if self.alreadyJoinedButton == nil {
            self.alreadyJoinedButton = UIButton(type: .custom)
        }
        self.alreadyJoinedButton?.setTitle("Already Joined?", for: .normal)
        self.alreadyJoinedButton?.setTitleColor(UIColor.lightText, for: .highlighted)
        self.alreadyJoinedButton?.addTarget(self, action: #selector(alreadyJoinedStudy), for: .touchUpInside)
        self.alreadyJoinedButton?.frame = CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.height * 0.95, width: 80, height: 20)
        self.alreadyJoinedButton?.sizeToFit()
        self.alreadyJoinedButton?.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        self.view.addSubview(self.alreadyJoinedButton!)
        
        // Align buttons
        self.joinButton?.center.x = self.view.center.x
        self.alreadyJoinedButton?.center.x = self.view.center.x
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if completedRegistration {
            completedRegistration = false
            goToTasks()
        }
    }
    
    var modelDataSource: OnBoardingDataSource {
        if _modelDataSource == nil {
            _modelDataSource = OnBoardingDataSource()
        }
        return _modelDataSource!
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == .linkClicked {
            UIApplication.shared.openURL(request.url!)
            return false
        } else {
            return true
        }
    }

    
    var _modelDataSource: OnBoardingDataSource? = nil
    
    //FIXME: TEMP FOR DONE BUTTON
    @objc func goToTasks() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        vc?.modalTransitionStyle = .flipHorizontal
        present(vc!, animated: true, completion: nil)
    }
    
    // Join Study method
    @objc func joinStudy() {
        let taskViewController = ORKTaskViewController(task: RegistrationTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    // Already joined study method
    @objc func alreadyJoinedStudy() {
        let loginStep = ORKLoginStep(identifier: "loginStep", title: "Login", text: "Please Login", loginViewControllerClass: LoginViewController.self)
        let loginTask = ORKOrderedTask(identifier: "loginTask", steps: [loginStep])
        let taskViewController = ORKTaskViewController(task: loginTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
}
