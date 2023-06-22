import SwiftUI

struct PeopleView: View {

	private let columns = Array(repeating: GridItem(.flexible()), count: 2)
	@State private var users = [User]()
	@State private var showCreate = false

    var body: some View {
		NavigationView {
			ZStack {
				background
				ScrollView {
					LazyVGrid(columns: columns, spacing: 16) {
						ForEach(users, id: \.id) { user in
							NavigationLink {
								DetailView()
							} label: {
								PersonItemView(user: user)
							}
						}
					}
					.padding()
				}
			}
			.navigationTitle("People")
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					create
				}
			}
			.onAppear {
				do {
					let result = try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
					users = result.data
				} catch {
					print(error)
				}
			}
			.sheet(isPresented: $showCreate) {
				CreateView()
			}
		}
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}

private extension PeopleView {

	var background: some View {
		Theme.background
			.ignoresSafeArea(edges: .top)
	}

	var create: some View {
		Button {
			showCreate.toggle()
		} label: {
			Symbols.plus
				.font(.system(.headline, design: .rounded))
				.bold()
		}
	}
}
