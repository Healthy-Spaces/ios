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

// MARK: - Customizable Strings (Probably need to be localized)
let dailyNotificationTitle = "Want to fill out a survey?"
let dailyNotificationBody = "You should!"
let dailyNotificationAction = "Take me there!"

// MARK: - Variables
let mainDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let networkingQueue = DispatchQueue(label: networkingQueueName)
let fileAccessQueue = DispatchQueue(label: fileAccessQueueName)
let location = Location()

// MARK: - Globals
var authenticated = false
var completedRegistration = false
