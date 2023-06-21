import SwiftUI

struct DetailView: View {
    var body: some View {
		ZStack {
			background
			ScrollView {
				VStack(alignment: .leading, spacing: 18) {
					Group {
						general
						link
					}
					.padding(.horizontal, 8)
					.padding(.vertical, 16)
					.background(
						Theme.detailBackground,
						in: RoundedRectangle(cornerRadius: 16, style: .continuous)
					)
				}
				.padding()
			}
		}
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

private extension DetailView {

	var background: some View {
		Theme.background
			.ignoresSafeArea(edges: .top)
	}

	var link: some View {
		Link(destination: URL(string: "https://reqres.in/#support-heading")!) {
			VStack(alignment: .leading, spacing: 8) {
				Text("Support Reqres")
					.foregroundColor(Theme.text)
					.font(.system(.body, design: .rounded))
					.fontWeight(.semibold)
				Text("https://reqres.in/#support-heading")
			}
			Spacer()
			Symbols
				.link
				.font(.system(.title3, design: .rounded))
		}
	}
}

private extension DetailView {

	var general: some View {
		VStack(alignment: .leading, spacing: 8) {
			PillView(id: 0)
			detailRow(title: "First Name", subtitle: "<First Name Here>")
			detailRow(title: "Last Name", subtitle: "<Last Name Here>")
			detailRow(title: "Email", subtitle: "<Email Here>", withDivider: false)
		}
	}

	@ViewBuilder
	func detailRow(title: String, subtitle: String, withDivider: Bool = true) -> some View {
		Text(title)
			.font(.system(.body, design: .rounded))
			.fontWeight(.semibold)
			.foregroundColor(Theme.text)

		Text(subtitle)
			.font(.system(.subheadline, design: .rounded))
			.foregroundColor(Theme.text)

		if withDivider {
			Divider()
		}
	}
}
