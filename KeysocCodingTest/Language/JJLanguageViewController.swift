//
//  JJLanguageViewController.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/2.
//

import UIKit

class JJLanguageViewController: JJBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let languageList = [("English","en"),("中文(简体)","zh-Hans"),("中文(繁體)","zh-Hant")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension JJLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell") ?? UITableViewCell(style: .default, reuseIdentifier: "LanguageCell")
        let language = languageList[indexPath.row]
        cell.textLabel?.text = language.0
        cell.accessoryType = language.1 == LanguageManager.shared.currentLanguage ? .checkmark : .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let name = languageList[indexPath.row].1
        
        //切换语言 并 重启应用
        if (LanguageManager.shared.currentLanguage != name) {
            view.makeToastActivity(.center)
            
            LanguageManager.shared.currentLanguage = name
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                UIView.animate(withDuration: 0.4) {
                    UIApplication.shared.keyWindow?.alpha = 0
                }completion: { isFinished in
                    UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                    UIView.animate(withDuration: 0.4) {
                        UIApplication.shared.keyWindow?.alpha = 1
                    }
                }
            }
        }
        
    }
}
