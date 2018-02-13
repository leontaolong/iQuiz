//
//  QuizCategory.swift
//  iQuiz
//
//  Created by LEON LOONG on 2/13/18.
//  Copyright © 2018 leontaolong. All rights reserved.
//

import Foundation
import UIKit

class QuizCategory {
    var imgName: String
    var title: String
    var desc: String

    init(_ imgName: String, _ title: String, _ desc: String) {
        self.imgName = imgName
        self.title = title
        self.desc = desc
    }
}
