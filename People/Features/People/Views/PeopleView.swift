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
					.refreshable {
						Task {
							await viewModel.fetchUsers()
						}
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
			.task {
				if !viewModel.hasAppeared {
					await viewModel.fetchUsers()
					viewModel.hasAppeared = true
				}
			}
			.sheet(isPresented: $viewModel.showCreate) {
				CreateView(viewModel: .init(successfulAction: {
					haptic(.success)
					withAnimation(.spring().delay(0.25)) {
						viewModel.shouldShowSuccess.toggle()
					}
				}))
			}
			.overlay {
				if viewModel.shouldShowSuccess {
					CheckmarkPopoverView()
						.transition(.scale.combined(with: .opacity))
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
								withAnimation(.spring()) {
									viewModel.shouldShowSuccess.toggle()
								}
							}
						}
				}
			}
			.alert(
				isPresented: $viewModel.hasError,
				error: viewModel.error
			) {
				Button("Retry") {
					Task {
						await viewModel.fetchUsers()
					}
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
