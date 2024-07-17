//
//  File.swift
//  
//
//  Created by al on 15.07.2024.
//

import Foundation


extension HKWorkoutSession {
    
}

HKHealthStore.isHealthDataAvailable


do {
    // Check that Health data is available on the device.
    if HKHealthStore.isHealthDataAvailable() {

        // Asynchronously request authorization to the data.
        try await healthStore.requestAuthorization(toShare: allTypes, read: allTypes)
    }
} catch {

    // Typically, authorization requests only fail if you haven't set the
    // usage and share descriptions in your app's Info.plist, or if
    // Health data isn't available on the current device.
    fatalError("*** An unexpected error occurred while requesting authorization: \(error.localizedDescription) ***")
}
