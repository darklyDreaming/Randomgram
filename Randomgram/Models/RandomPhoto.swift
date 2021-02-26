//
//  RandomPhoto.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 07.02.2021.
//

import Foundation


struct RandomPhoto: Decodable {
    
    let id: String
    let urls: Urls
    let width: Int
    let height: Int
    
    struct Urls: Decodable {
        let raw, full, regular, small: String
        let thumb: String
    }
}

