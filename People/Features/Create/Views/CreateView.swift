import SwiftUI

struct CreateView: View {
	@Environment(\.dismiss) private var dismiss
	@StateObject var viewModel: CreateViewModel
	@FocusState private var focusedField: Field?

    var body: some View {
		NavigationView {
			Form {
				Section {
					textfield("First name", text: $viewModel.person.firstName)
						.focused($focusedField, equals: .firstName)

					textfield("Last name", text: $viewModel.person.lastName)
						.focused($focusedField, equals: .lastName)

					textfield("Job", text: $viewModel.person.job)
						.focused($focusedField, equals: .job)
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
					viewModel.successfulAction()
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
		CreateView(viewModel: .init(successfulAction: {}))
    }
}

private extension CreateView {

	var done: some View {
		Button("Done") {
			dismiss()
		}
		.disabled(viewModel.shouldDisable)
	}

	var submit: some View {
		Button("Submit") {
			focusedField = nil
			viewModel.create()
		}
	}

	func textfield(_ placeholder: String, text: Binding<String>) -> some View {
		TextField(placeholder, text: text)
	}
}
