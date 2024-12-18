extension TRAppBridge {
	public var appStore: AppStoreApplication {
		return application(AppStoreApplication.self)
	}

	public var facebook: FacebookApplication {
		return application(FacebookApplication.self)
	}
}
