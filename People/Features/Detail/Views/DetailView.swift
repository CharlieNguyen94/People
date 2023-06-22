import SwiftUI

struct DetailView: View {

	@StateObject var viewModel: DetailViewModel

    var body: some View {
		ZStack {
			background
			ScrollView {
				VStack(alignment: .leading, spacing: 18) {
					avatar
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
		.navigationTitle("Details")
		.onAppear {
			viewModel.fetchDetails()
		}
		.alert(
			isPresented: $viewModel.hasError,
			error: viewModel.error
		) {}
    }
}

struct DetailView_Previews: PreviewProvider {

	private static var previewUserId: Int {
		let users = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
		return users.data.first!.id
	}

    static var previews: some View {
		NavigationView {
			DetailView(viewModel: .init(userId: previewUserId))
		}
    }
}

private extension DetailView {

	var background: some View {
		Theme.background
			.ignoresSafeArea(edges: .top)
	}

	@ViewBuilder
	var avatar: some View {
		if let avatarAbsoluteString = viewModel.userDetails?.data.avatar,
		   let avatarUrl = URL(string: avatarAbsoluteString) {

			AsyncImage(url: avatarUrl) { image in
				image
					.resizable()
					.scaledToFill()
					.frame(height: 248)
					.clipped()
			} placeholder: {
				ProgressView()
			}
			.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
		}
	}

	@ViewBuilder
	var link: some View {
		if let supportAbsoluteString = viewModel.userDetails?.support.url,
		   let supportUrl = URL(string: supportAbsoluteString),
		   let supportText = viewModel.userDetails?.support.text {

			Link(destination: supportUrl) {
				VStack(alignment: .leading, spacing: 8) {
					Text(supportText)
						.foregroundColor(Theme.text)
						.font(.system(.body, design: .rounded))
						.fontWeight(.semibold)
						.multilineTextAlignment(.leading)
					Text(supportAbsoluteString)
				}
				Spacer()
				Symbols
					.link
					.font(.system(.title3, design: .rounded))
			}
		}
	}
}

private extension DetailView {

	var general: some View {
		VStack(alignment: .leading, spacing: 8) {
			PillView(id: viewModel.userDetails?.data.id ?? 0)
			detailRow(title: "First Name", subtitle: viewModel.userDetails?.data.firstName ?? "-")
			detailRow(title: "Last Name", subtitle: viewModel.userDetails?.data.lastName ?? "-")
			detailRow(title: "Email", subtitle: viewModel.userDetails?.data.email ?? "-", withDivider: false)
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
