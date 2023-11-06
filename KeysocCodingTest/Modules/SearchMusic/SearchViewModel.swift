//
//  SearchViewModel.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/4.
//

import Foundation
import RxSwift
import ObjectMapper
import MJRefresh


class SearchViewModel {
    private let disposeBag = DisposeBag()
    
    var searchText = "" // 搜索文本
    
    var data = PublishSubject<[MusicModel]>()
    var dataList = [MusicModel]()
    
    private var pages = 1
    private var size = 20
    private var isNoMore = true
    
    // 国家类型 列表
    let countryList = [("美国".localized,"us"),("加拿大".localized,"ca"),("中国".localized,"CN"),("日本".localized,"JP"),("韩国".localized,"KR")]
    // 默认国家
    var currentCountry = ("美国".localized,"us") {
        didSet {
            self.limitList[0].1 = currentCountry
            self.loadLimit()
        }
    }
    
    // 媒体类型 列表
    let mediaList = [("全部".localized, "All"),("电影".localized, "movie"),("播客".localized, "podcast"),("音乐".localized, "music"),("音乐视频".localized, "musicVideo"),("有声读物".localized, "audiobook"),("短片".localized, "shortFilm"),("电视节目".localized, "tvShow"),("软件".localized, "software"),("电子书".localized, "ebook")]
    // 默认媒体
    var currentMedia = ("全部".localized, "All") {
        didSet {
            self.limitList[1].1 = currentMedia
            self.loadLimit()
        }
    }
    
    private var limitList: [(String, (String,String))]
    
    var countryData = PublishSubject<[(String,(String,String))]>()
    

    init() {
       limitList = [("国家".localized, currentCountry),("媒体类型".localized,currentMedia)]
    }
    
    
//    https://itunes.apple.com/search?term=jack+johnson&offset=20&limit=20
    private func getUrlString() -> String{
        "https://itunes.apple.com/search?country=\(currentCountry.1)&mediatype=\(currentMedia.1)"
    }

    // 刷新
    func refreshData(completed: @escaping (_ isNoMore: Bool) -> ()) {
        if searchText.isEmpty {
            completed(true)
            return
        }
        self.pages = 1
        let urlString = self.getUrlString() + "&term=\(searchText)&limit=20&offset=\(20*(self.pages-1))"
        let url = URL(string: urlString)
        URLSession.shared.rx.json(url: url!)
            .subscribe(onNext: { [weak self](data) in
            print("data === \(data)")
                let json = data as! [String: Any]
                let resultCount = json["resultCount"] as! Int
                let results = json["results"] as! [[String : Any]]
                self?.dataList.removeAll()
                for json in results {
                    self?.dataList.append(MusicModel(JSON: json)!)
                }
                self?.data.onNext(self?.dataList ?? [])
                self?.isNoMore = resultCount < 20
                self?.pages += 1
                completed(self?.isNoMore ?? true)
                print("data === \(String(describing: self?.dataList))")
        }, onError: { [weak self](error) in
            completed(self?.isNoMore ?? true)
        }).disposed(by: disposeBag)
    }
    
    // 加载更多
    func loadMoreData(completed: @escaping (_ isNoMore: Bool) -> ()) {
        if (searchText.isEmpty) {
            completed(true)
            return
        }
        let urlString = self.getUrlString() + "&term=\(searchText)&limit=20&offset=\(20*(self.pages-1))"
        let url = URL(string: urlString)
        URLSession.shared.rx.json(url: url!)
            .subscribe(onNext: { [weak self](data) in
            print("data === \(data)")
                let json = data as! [String: Any]
                let resultCount = json["resultCount"] as! Int
                let results = json["results"] as! [[String : Any]]
                for json in results {
                    self?.dataList.append(MusicModel(JSON: json)!)
                }
                self?.data.onNext(self?.dataList ?? [])
                self?.isNoMore = resultCount < 20
                self?.pages += 1
                completed(self?.isNoMore ?? true)
                print("data === \(String(describing: self?.dataList))")
        }, onError: { [weak self](error) in
            completed(self?.isNoMore ?? true)
        }).disposed(by: disposeBag)
    }
    
    
    // 收藏 音乐
    func Favorite(row: Int) {
        let music = self.dataList[row]
        music.isFavorite = true
        let trackId = music.trackId
        let predicate = NSPredicate(format: "id = \(trackId)", argumentArray: nil)
        //查询某条数据
        let array = RealmTools.objectsWithPredicate(object: MusicModel.self, predicate: predicate)
        if array!.count == 0 {
            RealmTools.add(music, task: {})
//                RealmHelper.addObject(object: music)
            self.data.onNext(self.dataList)
        }
    }
    
    // 加载首页 条件搜索
    func loadLimit() {
        self.countryData.onNext(self.limitList)
    }
    
    deinit {
        print("viewModel dispose")
    }
}

