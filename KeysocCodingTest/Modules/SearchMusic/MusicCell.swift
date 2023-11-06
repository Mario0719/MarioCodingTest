//
//  MusicCell.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/5.
//

import UIKit
import Kingfisher
import RxSwift

class MusicCell: UITableViewCell {
    
    @IBOutlet weak var albumArt: UIImageView! // 专辑封面
    @IBOutlet weak var songName: UILabel! // 歌曲名
    @IBOutlet weak var artist: UILabel! // 艺术家
    @IBOutlet weak var favoriteButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    var model: MusicModel! {
        didSet {
            self.albumArt.kf.setImage(with: URL(string: model.artworkUrl100), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            self.artist.text = model.collectionName
            self.songName.text = model.artistName
            self.favoriteButton.isSelected = model.isFavorite
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
