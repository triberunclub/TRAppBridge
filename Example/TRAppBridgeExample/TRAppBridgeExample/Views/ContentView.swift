//
//  ContentView.swift
//  TRAppBridgeExample
//
//  Created by Luigi Aiello on 10/10/24.
//

import SwiftUI

struct ContentView: View {
	// MARK: Wrapped Properties

	@State private var result: String = ""
	@ObservedObject private var viewModel = ContentViewModel()

	// MARK: Body

	var body: some View {
		VStack(spacing: 20) {
			Text("TRAppBridge Example")
				.font(.largeTitle)

			Button("Open Facebook") {
				viewModel.openFacebook()
			}

			Button("Open Facebook Profile") {
				viewModel.openFacebookProfile()
			}

			Button("Check if Facebook is installed") {
				viewModel.checkFacebookInstalled()
			}

			Text(viewModel.result)
				.padding()
				.background(Color.gray.opacity(0.2))
				.cornerRadius(8)
		} //: VSTACK
		.padding()
	}
}

// MARK: Previews

#Preview {
	ContentView()
}
