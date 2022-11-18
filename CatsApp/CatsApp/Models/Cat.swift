//
//  Cat.swift
//  CatsApp
//
//  Created by Michael Sweeney on 11/16/22.
//

import UIKit

struct Cat: Codable {
    let _id: String

    func imageURL() -> String {
        return "https://cataas.com/cat/\(_id)"
    }
}
