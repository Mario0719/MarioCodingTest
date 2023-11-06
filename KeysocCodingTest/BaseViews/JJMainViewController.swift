//
//  JJMainViewController.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/2.
//

import UIKit

class JJMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let views = self.viewControllers!
//        let sources = [("首页".localized,"tabbar_home_nor","tabbar_home_sel"),
//                       ("收藏夹".localized,"tabbar_shop_nor","tabbar_shop_sel"),
//                       ("我的".localized,"tabbar_user_nor","tabbar_user_sel")]
        let sources = [("首页".localized,"tabbar_home_nor","tabbar_home_sel"),
                       ("收藏夹".localized,"tabbar_shop_nor","tabbar_shop_sel")]
        
        for i in 0...(views.count - 1) {
            let navigation = views[i]
            let source = sources[i]
            navigation.tabBarItem = UITabBarItem(title: source.0, image: UIImage(named: source.1), selectedImage: UIImage(named: source.2))
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
