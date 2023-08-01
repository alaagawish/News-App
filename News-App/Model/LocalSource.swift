//
//  LocalSource.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation
import RealmSwift

class LocalSource: Object {
    @Persisted var id: String = ""
    @Persisted var name: String = ""
    convenience init(id: String, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}
