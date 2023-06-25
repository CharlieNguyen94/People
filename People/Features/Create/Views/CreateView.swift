import SwiftUI

struct CreateView: View {
	@Environment(\.dismiss) private var dismiss
	@StateObject var viewModel: CreateViewModel
	@FocusState private var focusedField: Field?

	private let successfulAction: () -> Void

	init(successfulAction: @escaping () -> Void) {
		self.successfulAction = successfulAction

		#if DEBUG

		if UITestingHelper.isUITesting {
			let mock: NetworkingManagerProvider = UITestingHelper.isCreateNetworkingSuccessful ?
			NetworkingManagerCreateSuccessMock() : NetworkingManagerCreateFailureMock()
			_viewModel = StateObject(wrappedValue: CreateViewModel(networkingManager: mock))
		} else {
			_viewModel = StateObject(wrappedValue: CreateViewModel())
		}

		#else
		_viewModel = StateObject(wrappedValue: CreateViewModel(successfulAction: {}))
		#endif
	}

    var body: some View {
		NavigationView {
			Form {
				Section {

					textfield("First name", text: $viewModel.person.firstName, equals: .firstName)
						.accessibilityIdentifier("firstNameTextField")

					textfield("Last name", text: $viewModel.person.lastName, equals: .lastName)
						.accessibilityIdentifier("lastNameTextField")

					textfield("Job", text: $viewModel.person.job, equals: .job)
						.accessibilityIdentifier("jobTextField")

				} footer: {
					if case .validation(let error) = viewModel.error,
					   let errorDescription = error.errorDescription {
						Text(errorDescription)
							.foregroundStyle(.red)
					}
				}

				Section {
					submit
				}
			}
			.disabled(viewModel.shouldDisable)
			.overlay {
				if viewModel.state == .submitting {
					ProgressView()
				}
			}
			.navigationTitle("Create")
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					done
				}
			}
			.onChange(of: viewModel.state) { formState in
				if formState == .successful {
					dismiss()
					successfulAction()
				}
			}
			.alert(
				isPresented: $viewModel.hasError,
				error: viewModel.error
			) {}
		}
    }
}

extension CreateView {
	enum Field: Hashable {
		case firstName
		case lastName
		case job
	}
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
		CreateView(successfulAction: {})
    }
}

private extension CreateView {

	var done: some View {
		Button("Done") {
			dismiss()
		}
		.disabled(viewModel.shouldDisable)
		.accessibilityIdentifier("doneButton")
	}

	var submit: some View {
		Button("Submit") {
			focusedField = nil
			Task {
				await viewModel.create()
			}
		}
		.accessibilityIdentifier("submitButton")
	}

	func textfield(_ placeholder: String, text: Binding<String>, equals: Field) -> some View {
		TextField(placeholder, text: text)
			.focused($focusedField, equals: equals)
	}
}
