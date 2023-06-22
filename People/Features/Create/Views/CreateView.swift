import SwiftUI

struct CreateView: View {
	@Environment(\.dismiss) private var dismiss
	@StateObject private var viewModel = CreateViewModel()

    var body: some View {
		NavigationView {
			Form {
				textfield("First name", text: $viewModel.person.firstName)
				textfield("Last name", text: $viewModel.person.lastName)
				textfield("Job", text: $viewModel.person.job)

				Section {
					submit
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
				}
			}
			.alert(
				isPresented: $viewModel.hasError,
				error: viewModel.error
			) {}
		}
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
		CreateView()
    }
}

private extension CreateView {

	var done: some View {
		Button("Done") {
			dismiss()
		}
	}

	var submit: some View {
		Button("Submit") {
			viewModel.create()
		}
	}

	func textfield(_ placeholder: String, text: Binding<String>) -> some View {
		TextField(placeholder, text: text)
	}
}
