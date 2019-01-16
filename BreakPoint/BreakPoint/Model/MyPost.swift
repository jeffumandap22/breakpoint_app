//
//  MyPost.swift
//  BreakPoint
//
//  Created by Jeffrey Umandap on 16/01/2019.
//  Copyright © 2019 Jeffrey Umandap. All rights reserved.
//

import Foundation

class MyPost {
    private var _post : String
    
    var post: String {
        return _post
    }
    
    init(post: String) {
        self._post = post
    }
}
