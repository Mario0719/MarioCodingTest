//
//  JJBaseViewController.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/2.
//
//  所有ViewController的基类，集成高频率事件触发、视图控制的实现。
import UIKit
import Toast_Swift
import SnapKit
import RxSwift
import RxCocoa

class JJBaseViewController: UIViewController {

    lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.


        
    }
    
    deinit {
        print("销毁")
    }


}

/// 简化 常用方法
extension JJBaseViewController {
    

}


