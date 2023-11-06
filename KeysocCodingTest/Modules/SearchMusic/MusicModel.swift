//
//  MusicModel.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/4.
//

import Foundation
import ObjectMapper
import RealmSwift

class MusicModel: Object, Mappable, Codable {
    
    @objc dynamic var isFavorite = false
    @objc dynamic var id: Int = 0
    @objc dynamic var wrapperType: String = ""
    @objc dynamic var kind: String = ""
    @objc dynamic var artistId: Int = 0
    @objc dynamic var collectionId: Int = 0
    @objc dynamic var trackId: Int = 0
    @objc dynamic var artistName: String = ""
    @objc dynamic var collectionName: String = ""
    @objc dynamic var trackName: String = ""
    @objc dynamic var collectionCensoredName: String = ""
    @objc dynamic var trackCensoredName: String = ""
    @objc dynamic var collectionArtistName: String = ""
    @objc dynamic var artistViewUrl: String = ""
    @objc dynamic var collectionViewUrl: String = ""
    @objc dynamic var trackViewUrl: String = ""
    @objc dynamic var previewUrl: String = ""
    @objc dynamic var artworkUrl30: String = ""
    @objc dynamic var artworkUrl60: String = ""
    @objc dynamic var artworkUrl100: String = ""
    @objc dynamic var collectionPrice: Double = 0.0
    @objc dynamic var trackPrice: Double = 0.0
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var collectionExplicitness: String = ""
    @objc dynamic var trackExplicitness: String = ""
    @objc dynamic var discCount: Int = 0
    @objc dynamic var discNumber: Int = 0
    @objc dynamic var trackCount: Int = 0
    @objc dynamic var trackNumber: Int = 0
    @objc dynamic var trackTimeMillis: Int = 0
    @objc dynamic var country: String  = ""
    @objc dynamic var currency: String = ""
    @objc dynamic var primaryGenreName: String = ""
    @objc dynamic var isStreamable: Bool = false
    @objc dynamic var collectionArtistId: Int = 0
    @objc dynamic var collectionArtistViewUrl: String = ""
    @objc dynamic var trackRentalPrice: Double = 0
    @objc dynamic var contentAdvisoryRating: String  = ""
    @objc dynamic var shortDescription: String = ""
    @objc dynamic var longDescription: String = ""
    
    override init() {
        
    }

    required init?(map: ObjectMapper.Map) {
        
    }

    
    func mapping(map: ObjectMapper.Map) {
        id <- map["trackId"]
        wrapperType <- map["wrapperType"]
        kind <- map["kind"]
        artistId <- map["artistId"]
        collectionId <- map["collectionId"]
        trackId <- map["trackId"]
        artistName <- map["artistName"]
        collectionName <- map["collectionName"]
        trackName <- map["trackName"]
        collectionCensoredName <- map["collectionCensoredName"]
        trackCensoredName <- map["trackCensoredName"]
        collectionArtistName <- map["collectionArtistName"]
        artistViewUrl <- map["artistViewUrl"]
        collectionViewUrl <- map["collectionViewUrl"]
        trackViewUrl <- map["trackViewUrl"]
        previewUrl <- map["previewUrl"]
        artworkUrl30 <- map["artworkUrl30"]
        artworkUrl60 <- map["artworkUrl60"]
        artworkUrl100 <- map["artworkUrl100"]
        collectionPrice <- map["collectionPrice"]
        trackPrice <- map["trackPrice"]
        releaseDate <- map["releaseDate"]
        collectionExplicitness <- map["collectionExplicitness"]
        trackExplicitness <- map["trackExplicitness"]
        discCount <- map["discCount"]
        discNumber <- map["discNumber"]
        trackCount <- map["trackCount"]
        trackNumber <- map["trackNumber"]
        trackTimeMillis <- map["trackTimeMillis"]
        country <- map["country"]
        currency <- map["currency"]
        primaryGenreName <- map["primaryGenreName"]
        isStreamable <- map["isStreamable"]
        collectionArtistId <- map["collectionArtistId"]
        collectionArtistViewUrl <- map["collectionArtistViewUrl"]
        trackRentalPrice <- map["trackRentalPrice"]
        contentAdvisoryRating <- map["contentAdvisoryRating"]
        shortDescription <- map["shortDescription"]
        longDescription <- map["longDescription"]

    }
    override static func primaryKey() -> String? {
        return "id"
    }
//    override static func ignoredProperties() -> [String] {
//        return ["isFavorite"]
//    }
    
}

