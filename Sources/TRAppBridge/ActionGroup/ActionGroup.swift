//
//  ActionGroup.swift
//  TRAppBridge
//
//  Created by Francesco Leoni on 20/12/24.
//

import Foundation

public enum ActionGroup: Identifiable {

	case showLocation(lat: Double, lng: Double)
	case sendEmail(recipient: String, subject: String, body: String)
	case openMailApp

	public var id: String {
		switch self {
		case .showLocation: return "0"
		case .sendEmail: return "1"
		case .openMailApp: return "2"
		}
	}

	var apps: [AnyApplication?] {
		switch self {
		case .showLocation(let lat, let lng):
			return [.appleMaps(action: .showCoordinates(lat: lat, lng: lng)),
							.googleMaps(action: .search(query: "\(lat),\(lng)")),
							.waze(action: .showLocation(lat: lat, lng: lng))]

		case let .sendEmail(recipient, subject, body):
			return [.appleMail(action: .send(recipient: recipient, subject: subject, body: body)),
							.googleMail(action: .send(recipient: recipient, subject: subject, body: body)),
							.outlook(action: .send(recipient: recipient, subject: subject, body: body)),
							.yahooMail(action: .send(recipient: recipient, subject: subject, body: body)),
							.sparkMail(action: .send(recipient: recipient, subject: subject, body: body))]

		case .openMailApp:
			return [.appleMailOpener(action: .open),
							.googleMail(action: .open),
							.outlook(action: .open),
							.yahooMail(action: .open),
							.sparkMail(action: .open)]
		}
	}

	var baseApps: [BaseApplication?] {
		apps.map { BaseApplication(anyApplication: $0) }
	}
}

public enum BaseActionGroup: Identifiable {

	case showLocation
	case sendEmail
	case openMailApp

	public var id: String {
		switch self {
		case .showLocation: return "0"
		case .sendEmail: return "1"
		case .openMailApp: return "2"
		}
	}

	public var apps: [BaseApplication?] {
		let action: ActionGroup

		switch self {
		case .showLocation: action = .showLocation(lat: 0, lng: 0)
		case .sendEmail: action = .sendEmail(recipient: "", subject: "", body: "")
		case .openMailApp: action = .openMailApp
		}

		return action.baseApps
	}
}
