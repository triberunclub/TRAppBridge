extension TRAppBridge {
	public var appStore: AppStore {
		return application(AppStore.self)
	}

	public var facebook: Facebook {
		return application(Facebook.self)
	}
}
