import SwiftUI

@main
struct PeopleApp: App {
    var body: some Scene {
        WindowGroup {
			TabView {
				PeopleView()
					.tabItem {
						Symbols.person
						Text("Home")
					}
				SettingsView()
					.tabItem {
						Symbols.gear
						Text("Settings")
					}
			}
        }
    }
}
