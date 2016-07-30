//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Pratyush Varchaswee on 9/12/15.
//  Copyright (c) 2015 Pratyush. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    
    init(filePathUrl: NSURL!,title: String!) {
        self.filePathUrl=filePathUrl
        self.title=title
        
    }
}
