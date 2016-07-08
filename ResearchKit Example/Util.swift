//
//  Util.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 7/8/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation

public func write(string: String, toNew file: String) {
    do {
        let path = try mainDir.appendingPathComponent(file)
        try string.write(to: path, atomically: true, encoding: String.Encoding.utf8)
    } catch let error as NSError {
        print("new string file writing error: \(error), \(error.userInfo)")
    }
}
