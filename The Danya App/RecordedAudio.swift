//
//  RecordedAudio.swift
//  The Danya App
//
//  Created by Gershy Lev on 9/8/17.
//  Copyright © 2017 Gershy Lev. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathURL: URL!
    var title: String!
    
    init(filePath: URL, title: String) {
        filePathURL = filePath
        self.title = title
    }
}
