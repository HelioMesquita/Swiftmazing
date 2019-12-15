//
//  CustomView.swift
//  Visual
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//
//
//import UIKit
//
//
//public protocol CustomViewProtocol {
//    associatedtype CustomView: UIView
//}
//
//extension CustomViewProtocol where Self: UIViewController {
//
//    public var customView: CustomView {
//        guard let customView = view as? CustomView else {
//            fatalError("Expected view to be of type \(CustomView.self) but got \(type(of: view)) instead")
//        }
//        return customView
//   }
//
//}
//
//class CustomViewController2: UIViewController, CustomViewProtocol {
//
//    typealias CustomView = UITableView
//
//
//}
//
//
//
////import UIKit
////
////public class BaseViewController: UIViewController {
////
////    override public func viewDidLoad() {
////        super.viewDidLoad()
////        view.backgroundColor = UIColor(named: "background")
////    }
////}
//
//class CustomViewController<CustomView: UIView>: UIViewController {
//
//    var customView: CustomView {
//        return view as! CustomView
//    }
//
//    override func loadView() {
//        view = CustomView()
//    }
//}
////
////final class MyViewController: CustomViewController<MyView> {
////    override func loadView() {
////        super.loadView()
////        customView.delegate = self
////    }
////}
