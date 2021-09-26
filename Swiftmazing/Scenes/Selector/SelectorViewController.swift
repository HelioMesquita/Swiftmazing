//
//  SelectorViewController.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 26/09/21.
//

import UIKit
import Visual
import Flutter
import WebKit

class SelectorViewController: UIViewController {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [swiftmazingBtn,
                                                       dartmazingNativeBtn,
                                                       dartmazingWebBtn,
                                                       ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var swiftmazingBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Swiftmazing", for: .normal)
        button.addTarget(self, action: #selector(openSwiftmazing), for: .touchUpInside)
        return button
    }()
    
    lazy var dartmazingNativeBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Dartmazing Native", for: .normal)
        button.addTarget(self, action: #selector(openDartmazingNative), for: .touchUpInside)
        return button
    }()
    
    lazy var dartmazingWebBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Dartmazing Web", for: .normal)
        button.addTarget(self, action: #selector(openDartmazingWeb), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if (!isBeingPresented && presentedViewController != nil) {
                presentedViewController?.dismiss(animated: true)
            }
        }
    }

    
    @objc func openSwiftmazing() {
        let viewController = FeedViewController()
        let navigationController = BaseNavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    @objc func openDartmazingNative() {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        flutterViewController.modalPresentationStyle = .fullScreen
        present(flutterViewController, animated: true)
    }
    
    @objc func openDartmazingWeb() {
        let viewController = UIViewController()
        let wkWebView = WKWebView()
        wkWebView.allowsBackForwardNavigationGestures = false
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(wkWebView)
        NSLayoutConstraint.activate([
            wkWebView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            wkWebView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            wkWebView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            wkWebView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
        ])
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true) {
            let url = URL(string: "https://dartmazing.web.app/")!
            wkWebView.load(URLRequest(url: url))
        }
    }

}
