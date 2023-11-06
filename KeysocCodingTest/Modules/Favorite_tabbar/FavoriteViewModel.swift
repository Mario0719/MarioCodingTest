//
//  FavoriteViewModel.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/5.
//

import Foundation
import RxSwift
import ObjectMapper
import MJRefresh


class FavoriteViewModel {
    private let disposeBag = DisposeBag()
    
    
    var data = PublishSubject<[MusicModel]>()
    var dataList = [MusicModel]()
    
    
    init() {

        
    }
    
    
    func getFavoriteFromDB() {
        let queryArray = RealmTools.objects(MusicModel.self) as! [MusicModel]
        
        self.dataList.removeAll()
        self.dataList.append(contentsOf: queryArray)
        self.data.onNext(self.dataList)
    }
    
    func delFavorite(indexPath: IndexPath) {
        let model = self.dataList[indexPath.row]
//        RealmHelper.deleteObject(object: model)
        RealmTools.delete(model, task: {})
        
        self.dataList.remove(at: indexPath.row)
        print(self.dataList)
        self.data.onNext(self.dataList)
        
    }
    
    
   
    
    deinit {
        print("viewModel dispose")
    }
}

