import SwiftUI

struct CreateView: View {
	@Environment(\.dismiss) private var dismiss

    var body: some View {
		NavigationView {
			Form {
				textfield("First name", text: .constant(""))
				textfield("Last name", text: .constant(""))
				textfield("Job", text: .constant(""))

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

		}
	}

	func textfield(_ placeholder: String, text: Binding<String>) -> some View {
		TextField(placeholder, text: text)
	}
}
