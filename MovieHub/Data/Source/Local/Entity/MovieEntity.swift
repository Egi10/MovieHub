//
//  MovieEntity.swift
//  MovieHub
//
//  Created by Julsapargi Nursam on 21/03/23.
//

import Foundation
import RealmSwift

class MovieEntity: Object {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var image = ""
    @Persisted var title = ""
    @Persisted var voteAverange = 0.0
    @Persisted var overview = ""
    @Persisted var popularity = 0.0
    @Persisted var release = ""
}
