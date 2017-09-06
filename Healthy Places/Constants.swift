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
let tasksCompletedFile  = "tasksCompleted"
/* tasksCompleted File Structure:
    For each survey:
        [a] = name of survey
        [b] = last TaskStatus
        [c] = date of last TaskStatus ^^
        [d] = UUID if started, but not finished
 
   Find x, y, z by using two for-loops
 */
let remindersTimeFile   = "remindersTime"
let locationDataFile    = "locationData"
let logDataFile         = "logData"
let retryFile           = "retry"

// MARK: - Customizable Strings (Probably need to be localized)
let dailyNotificationTitle = "Feel like filling out a survey? (Title)"
let dailyNotificationBody = "Feel like filling out a survey?"
//let dailyNotificationAction = "View"

// MARK: - Variables
let mainDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let networkingQueue = DispatchQueue(label: networkingQueueName)
let fileAccessQueue = DispatchQueue(label: fileAccessQueueName)
let location = Location()

// MARK: - Globals
var authenticated = false
let securityTimeout = 900 // 15 minutes in seconds
var completedRegistration = false

// MARK: - HealthKit Types (Sorted alphabetically)
let readDataTypes:Set<HKObjectType> = Set(arrayLiteral:
    HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
    HKObjectType.quantityType(forIdentifier: .bloodGlucose)!,
    HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
    HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!,
    HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)!,
    HKObjectType.quantityType(forIdentifier: .flightsClimbed)!,
    HKObjectType.quantityType(forIdentifier: .heartRate)!,
    HKObjectType.quantityType(forIdentifier: .height)!,
    HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!,
    HKObjectType.characteristicType(forIdentifier: .biologicalSex)!,
    HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
    HKObjectType.categoryType(forIdentifier: .appleStandHour)!,
    HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)!,
    HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
    HKObjectType.quantityType(forIdentifier: .bodyMass)!,
    HKQuantityType.workoutType()
)

// MARK: - Data Types

// GENERAL

enum TaskStatus: Int {
    case notStarted
    case started
    case finished
}

enum informationShare: NSNumber {
    case all
    case onlyOSU
    case onlyOnDevice
}

// BASELINE SURVEY

// Ethnicity
enum Ethnicity: Int {
    case caucasion
    case black
    case filipino
    case chinese
    case nativeAmerican
    case hispanic
    case southAsian
    case japanese
    case middleEastern
    case southeastAsian
    case unknown
}

// Marital Status
enum MaritalStatus: Int {
    case married
    case single
    case divorced
    case widowed
}

// Education
enum Education: Int {
    case lessThanHighSchool
    case someHighSchool
    case completedHighSchool
    case someCollege
    case completedCollege
    case someUniversity
    case completedUniversity
    case masters
    case phd
}

// TODO: Income

// Own/Rent Home
enum HomeOwnership: Int {
    case own
    case rent
}

// Home Description
enum HomeDescription: Int {
    case detached
    case duplex
    case apartment
    case mobileHome
    case other
}

// Home Influence
enum HomeInfluence: Int {
    case housing
    case proximity
    case school
    case entertainment
    case social
    case publicTransportation
    case friends
    case neighborhood
    case characterOfHouse
    case other
}

// Commute 
enum Commute: Int {
    case bike
    case driver
    case passenger
    case publicTransit
    case taxi
    case other
}

// GREENSPACE SURVEY

enum GreenspaceInfluence: Int {
    case noInfluence
    case physicalActivity
    case airPollution
    case reducingNoise
    case reducingHeat
    case stress
    case increaseSocialConnections
}

enum View: Int {
    case noView
    case water
    case greenspace
    case urban
}

enum GreenspaceTypes: Int {
    case parks
    case streetTrees
    case otherStreetVegetation
    case publicLawnsOpenSpaces
    case yourYard
}
