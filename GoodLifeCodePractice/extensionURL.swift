//
//  extensionURL.swift
//  GoodLifeCodePractice
//
//  Created by Francis Tseng on 2017/9/29.
//  Copyright © 2017年 Francis Tseng. All rights reserved.
//

import Foundation

extension URL {
    func valueOf(queryParamaterName: String) -> String? {
        
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    
    }
}
