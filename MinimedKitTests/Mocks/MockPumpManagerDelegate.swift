//
//  MockPumpManagerDelegate.swift
//  MinimedKitTests
//
//  Created by Pete Schwamb on 9/5/22.
//  Copyright © 2022 LoopKit Authors. All rights reserved.
//

import Foundation
import LoopKit

class MockPumpManagerDelegate: PumpManagerDelegate {
    var automatedTreatmentState: LoopKit.AutomatedTreatmentState?
    
    var automaticDosingEnabled = true

    var historyFetchStartDate = Date()

    func pumpManagerBLEHeartbeatDidFire(_ pumpManager: PumpManager) {}

    func pumpManagerMustProvideBLEHeartbeat(_ pumpManager: PumpManager) -> Bool {
        return false
    }

    func pumpManagerWantsDeletion(_ pumpManager: PumpManager) async {}

    func pumpManagerPumpWasReplaced(_ pumpManager: PumpManager) {}

    func pumpManager(_ pumpManager: PumpManager, didUpdatePumpRecordsBasalProfileStartEvents pumpRecordsBasalProfileStartEvents: Bool) {}

    func pumpManager(_ pumpManager: PumpManager, didError error: PumpManagerError) {}

    var reportedPumpEvents: [(events: [NewPumpEvent], lastReconciliation: Date?)] = []
    
    func pumpManager(_ pumpManager: PumpManager, hasNewPumpEvents events: [NewPumpEvent], lastReconciliation: Date?, replacePendingEvents: Bool) async throws {
        reportedPumpEvents.append((events: events, lastReconciliation: lastReconciliation))
    }

    struct MockReservoirValue: ReservoirValue {
        let startDate: Date
        let unitVolume: Double
    }

    func pumpManager(_ pumpManager: PumpManager, didReadReservoirValue units: Double, at date: Date) async throws -> (newValue: ReservoirValue, lastValue: ReservoirValue?, areStoredValuesContinuous: Bool) {
        let reservoirValue = MockReservoirValue(startDate: date, unitVolume: units)
        return (newValue: reservoirValue, lastValue: nil, areStoredValuesContinuous: true)
    }

    func pumpManager(_ pumpManager: PumpManager, didAdjustPumpClockBy adjustment: TimeInterval) {}

    func pumpManagerDidUpdateState(_ pumpManager: PumpManager) {}

    func pumpManager(_ pumpManager: PumpManager, didRequestBasalRateScheduleChange basalRateSchedule: BasalRateSchedule) async throws { }

    func startDateToFilterNewPumpEvents(for manager: PumpManager) -> Date {
        return historyFetchStartDate
    }

    var detectedSystemTimeOffset: TimeInterval = 0

    func deviceManager(_ manager: DeviceManager, logEventForDeviceIdentifier deviceIdentifier: String?, type: DeviceLogEntryType, message: String, completion: ((Error?) -> Void)?) {}

    func pumpManager(_ pumpManager: PumpManager, didUpdate status: PumpManagerStatus, oldStatus: PumpManagerStatus) {}

    func issueAlert(_ alert: Alert) {}

    func retractAlert(identifier: Alert.Identifier) {}

    func doesIssuedAlertExist(identifier: LoopKit.Alert.Identifier) async throws -> Bool {
        return false
    }

    func lookupAllUnretracted(managerIdentifier: String) async throws -> [LoopKit.PersistedAlert] {
        return []
    }

    func lookupAllUnacknowledgedUnretracted(managerIdentifier: String) async throws -> [LoopKit.PersistedAlert] {
        return []
    }

    func recordRetractedAlert(_ alert: Alert, at date: Date) {}

}
