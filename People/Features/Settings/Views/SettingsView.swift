import SwiftUI

struct SettingsView: View {

	@AppStorage(UserDefaultKeys.hapticsEnabled) private var isHapticsEnabled = true

    var body: some View {
		Form {
			haptics
		}
		.navigationTitle("Settings")
		.embedInNavigation()
    }
}

private extension SettingsView {
	var haptics: some View {
		Toggle("Enable Haptics", isOn: $isHapticsEnabled)
	}
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
