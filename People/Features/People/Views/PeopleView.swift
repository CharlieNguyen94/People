import SwiftUI

struct PeopleView: View {

	@StateObject private var viewModel = PeopleViewModel()
	private let columns = Array(repeating: GridItem(.flexible()), count: 2)

    var body: some View {
		NavigationStack {
			ZStack {
				background
				if  viewModel.isLoading {
					ProgressView()
				} else {
					ScrollView {
						LazyVGrid(columns: columns, spacing: 16) {
							ForEach(viewModel.users, id: \.id) { user in
								NavigationLink(value: user.id) {
									PersonItemView(user: user)
								}
							}
						}
						.padding()
					}
				}
			}
			.navigationDestination(for: Int.self, destination: { userId in
				DetailView(viewModel: .init(userId: userId))
			})
			.navigationTitle("People")
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					create
				}
			}
			.onAppear {
				viewModel.fetchUsers()
			}
			.sheet(isPresented: $viewModel.showCreate) {
				CreateView()
			}
			.alert(
				isPresented: $viewModel.hasError,
				error: viewModel.error
			) {
				Button("Retry") {
					viewModel.fetchUsers()
				}
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
			viewModel.showCreate.toggle()
		} label: {
			Symbols
				.plus
				.font(.system(.headline, design: .rounded))
				.bold()
		}
		.disabled(viewModel.isLoading)
	}
}
