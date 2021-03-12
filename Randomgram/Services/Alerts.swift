//
//  Alerts.swift
//  Randomgram
//
//  Created by Yulia Tsyrkunova on 12.03.2021.
//

import Foundation
import UIKit

enum AlertsType {
    
    case lostConnection, connectionRecovered
    
}

class Alerts {
    
    private var alert: UIAlertController?
    
    func createAlert(type: AlertsType) -> UIAlertController? {
        
        alert = nil
        
        switch type {
        case .lostConnection:
            alert = createLostConnectionAlert()
        case .connectionRecovered:
            alert = createConnectionRecoveredAlert()
        }
        
        return alert
    }
    
    private func createLostConnectionAlert() -> UIAlertController {
        let alert = UIAlertController(title: Constants.AlertsTexts.lostConnectionAlertTitle, message: Constants.AlertsTexts.lostConnectionAlertText, preferredStyle: .alert)
        return alert
    }
    
    private func createConnectionRecoveredAlert() -> UIAlertController {
        let alert = UIAlertController(title: Constants.AlertsTexts.recoveredConnectionAlertTitle, message: Constants.AlertsTexts.recoveredConnectionAlertText, preferredStyle: .alert)
        return alert
    }
    
}
