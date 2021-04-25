//
//  SelectorViewController.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 23/04/21.
//

import Flutter
import UIKit
import Visual

class SelectorViewController: UIViewController {
    
    struct Project {
        let name: String
        let image: String
    }
    
    let projects: [Project] = [
       Project(name: "Swiftmazing", image: "AppIcon"),
       Project(name: "Dartmazing", image: "Dart")
   ]
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        return stackView
    }()

    override open func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        title = "Select the project"
        view.backgroundColor = UIColor.Design.background
    }

    private func configureViews() {
        addDescriptionStackView()
        addProjects()
    }

    private func addDescriptionStackView() {
        view.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            containerStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        ])
    }
    
    private func addProjects() {
        projects.forEach { (project) in
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: project.image), for: .normal)
            button.setTitle(project.name, for: .normal)
            button.setTitleColor(UIColor.Design.title, for: .normal)
            let methodName = project.name.lowercased()
            let method = Selector(methodName)
            if responds(to: method) {
                button.addTarget(self, action: method, for: .touchUpInside)
            }
            containerStackView.addArrangedSubview(button)
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    
    @objc func swiftmazing() {
        let viewController = FeedViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func dartmazing() {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        flutterViewController.modalPresentationStyle = .fullScreen
        
        let dartmazingChannel = FlutterMethodChannel(name: "channel.swiftmazing", binaryMessenger: flutterViewController.binaryMessenger)
        
        dartmazingChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "dismissFlutter":
                flutterViewController.dismiss(animated: true)
            
            case "openNativeScreen":
                let nativeScreenWithBack = NativeScreenWithBack()
                flutterViewController.present(nativeScreenWithBack, animated: true)

            default:
                break
            }
        })
        
        present(flutterViewController, animated: true)
    }

}

class NativeScreenWithBack: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Design.background

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.Design.title, for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func back() {
        self.dismiss(animated: true)
    }
    
}
