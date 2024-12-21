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

	var id: String {
		switch self {
		case .showLocation: return "0"
		case .sendEmail: return "1"
		}
	}

	var apps: [AnyApplication?] {
		switch self {
		case .showLocation(let lat, let lng):
			return [AnyApplication(AppleMapsApplication(), action: .showCoordinates(lat: lat, lng: lng)),
							AnyApplication(GoogleMapsApplication(), action: .search(query: "\(lat),\(lng)")),
							AnyApplication(Waze(), action: .showLocation(lat: lat, lng: lng))]

		case let .sendEmail(recipient, subject, body):
			return [AnyApplication(AppleMail(), action: .send(recipient: recipient, subject: subject, body: body)),
							AnyApplication(GoogleMail(), action: .send(recipient: recipient, subject: subject, body: body)),
							AnyApplication(Outlook(), action: .send(recipient: recipient, subject: subject, body: body)),
							AnyApplication(YahooMail(), action: .send(recipient: recipient, subject: subject, body: body)),
							AnyApplication(SparkMail(), action: .send(recipient: recipient, subject: subject, body: body))]
		}
	}
}
