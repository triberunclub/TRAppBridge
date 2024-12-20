//
//  ActionGroup.swift
//  TRAppBridge
//
//  Created by Francesco Leoni on 20/12/24.
//

import Foundation

public enum ActionGroup {

	case showLocation(lat: Double, lng: Double)

	var apps: [AnyApplication?] {
		switch self {
		case .showLocation(let lat, let lng):
			return [AnyApplication(AppleMapsApplication(), action: .showCoordinates(lat: lat, lng: lng)),
							AnyApplication(GoogleMapsApplication(), action: .search(query: "\(lat),\(lng)")),
							AnyApplication(Waze(), action: .showLocation(lat: lat, lng: lng))]
		}
	}
}
