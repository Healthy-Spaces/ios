//
//  Constants.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 6/23/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: - Strings
let networkingQueueName = "com.samuellichlyter.networking"
let fileAccessQueueName = "com.samuellichlyter.fileaccess"
let authStatusFile      = "authStatus"
let authDateFile        = "authDate"
let locationDataFile    = "locationData"
let logDataFile         = "logData"

// MARK: - Variables
let mainDir = FileManager.default.urlsForDirectory(.documentDirectory, inDomains: .userDomainMask).first!
let networkingQueue = DispatchQueue(label: networkingQueueName)
let fileAccessQueue = DispatchQueue(label: fileAccessQueueName)
let location = Location()

// MARK: - Globals
var authenticated = false
