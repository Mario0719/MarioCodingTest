//
//  JJHomeViewController.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/2.
//

import UIKit
import RxSwift

class JJHomeViewController: JJBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUI()
        binding()
    }
    
    
    func setUI() {
        
        
        let customView = UIButton(type: .custom)
        customView.frame = CGRect(x: 0, y: 0, width: UIDevice.getScreenWidth()/2+80, height: UIDevice.xp_navigationBarHeight())
        customView.backgroundColor = .lightGray
        customView.setTitle("搜索歌曲、专辑或艺术家".localized, for: .normal)
        customView.setImage(UIImage(named: "search"), for: .normal)
        
        customView.titleLabel?.textAlignment = .center
        customView.layer.cornerRadius = customView.height/2
    
        self.navigationItem.titleView  = customView
        
        customView.rx.tap.subscribe({ _ in
            self.navigationController?.pushViewController(JJSearchViewController.initWithViewModel(vm: self.viewModel), animated: false)
        }).disposed(by: disposeBag)
        
        
        let lanButton = UIButton(type: .custom)
        lanButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        lanButton.setImage(UIImage(named: "Language"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: lanButton)
        
        lanButton.rx.tap.subscribe({ _ in
            self.navigationController?.pushViewController(JJLanguageViewController(nibName: "JJLanguageViewController", bundle: nil), animated: true)
        }).disposed(by: disposeBag)
        
        
        
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        tableView.rowHeight = 60
        tableView.estimatedRowHeight = 60
    }
    

    
    func binding() {
        

        viewModel.countryData.bind(to: tableView.rx.items(cellIdentifier: "HomeCell")) {index,obj,cell in
            let homeCell = cell as! HomeCell
            homeCell.lab_title.text = obj.0
            homeCell.accessoryType = .disclosureIndicator
            homeCell.lab_subTitle?.text = (obj.1).0
            
        }.disposed(by: self.disposeBag)
        
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            self.tableView.deselectRow(at: indexPath, animated: false)
            
            let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            if indexPath.row == 0 {
                for item in self.viewModel.countryList {
                    let action = UIAlertAction(title: item.0, style: .default) { _ in
                        self.viewModel.currentCountry = item
                    }
                    sheet.addAction(action)
                }
            }else {
                for item in self.viewModel.mediaList {
                    let action = UIAlertAction(title: item.0, style: .default) { _ in
                        self.viewModel.currentMedia = item
                    }
                    sheet.addAction(action)
                }
            }
            let cancel = UIAlertAction(title: "取消".localized, style: .cancel)
            sheet.addAction(cancel)
            self.present(sheet, animated: true)
//            self?.tableView.reloadData()
        }).disposed(by: self.disposeBag)
        
        
        
        
        self.viewModel.loadLimit()


    }


}
