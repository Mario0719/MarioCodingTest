//
//  JJFavoriteViewController.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/2.
//

import UIKit
import RxSwift

class JJFavoriteViewController: JJBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = FavoriteViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.getFavoriteFromDB()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "收藏夹".localized
        setupUI()
        binding()
        
        
    }
    
    func setupUI() {

        
        tableView.register(UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "musicCell")
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 100
        
    }
    
    func binding() {
        

        viewModel.data.bind(to: tableView.rx.items(cellIdentifier: "musicCell")) {index,music,cell in
            let musicCell = cell as! MusicCell
            musicCell.model = music
            musicCell.selectionStyle = .none
            
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(MusicModel.self).subscribe(onNext: {music in
            print("你选中的歌曲信息\(music)")

        }).disposed(by: disposeBag)
        
        
        tableView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
            self?.viewModel.delFavorite(indexPath: indexPath)
        }).disposed(by: disposeBag)
        
        


    }

}
