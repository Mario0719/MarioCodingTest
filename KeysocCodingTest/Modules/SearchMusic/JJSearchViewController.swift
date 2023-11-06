//
//  JJSearchViewController.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/4.
//

import UIKit
import RxSwift
import MJRefresh
import RxCocoa

class JJSearchViewController: JJBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    var viewModel: SearchViewModel!
    
    static func initWithViewModel(vm: SearchViewModel) -> JJSearchViewController{
        let viewController = JJSearchViewController(nibName: "JJSearchViewController", bundle: nil)
        viewController.viewModel = vm
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        binding()
        
    }
    
    func setupUI() {
        let search = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIDevice.getScreenWidth()/2+60, height: UIDevice.xp_navigationBarHeight()))
        self.navigationItem.titleView  = search
        search.placeholder = "搜索歌曲、专辑或艺术家".localized
        search.becomeFirstResponder()
        self.searchBar = search
        search.delegate = self
        
        tableView.register(UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "musicCell")
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 100
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.viewModel.refreshData(completed: { isNoMore in
                self?.tableView.mj_header?.endRefreshing()
                if isNoMore {
                    self?.tableView.mj_footer?.endRefreshingWithNoMoreData()
                }
            })
        })

        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
            self?.viewModel.loadMoreData(completed: { isNoMore in
                if isNoMore {
                    self?.tableView.mj_footer?.endRefreshingWithNoMoreData()
                }else {
                    self?.tableView.mj_footer?.endRefreshing()
                }
            })
        })
        
        
    }
    
    func binding() {
        

        
        searchBar.rx.text.orEmpty.subscribe(onNext: { [weak self](str) in
            self?.viewModel.searchText = str
        }).disposed(by: disposeBag)

        

        

        viewModel.data.bind(to: tableView.rx.items(cellIdentifier: "musicCell")) {index,music,cell in
            let musicCell = cell as! MusicCell
            musicCell.model = music
        }.disposed(by: disposeBag)
        
        

        tableView.rx.itemSelected.subscribe(onNext: {[weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: false)
            let music = self?.viewModel.dataList[indexPath.row]
            if (music?.isFavorite == true) {
                self?.view.makeToast("已收藏",position: .center)
                return
            }
            self?.viewModel.Favorite(row: indexPath.row)
        }).disposed(by: disposeBag)
        
        


    }

    

    deinit {
        print("dealloc")
    }

}
extension JJSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.refreshData { isNoMore in
            if isNoMore {
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }else {
                self.tableView.mj_header?.endRefreshing()
            }
        }
        searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
    }
}

