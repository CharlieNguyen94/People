import SwiftUI

struct DetailView: View {

	@State private var userInfo: UserDetailResponse?

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
			do {
				userInfo = try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
			} catch {
				print(error)
			}
		}
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			DetailView()
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
		if let avatarAbsoluteString = userInfo?.data.avatar,
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
		if let supportAbsoluteString = userInfo?.support.url,
		   let supportUrl = URL(string: supportAbsoluteString),
		   let supportText = userInfo?.support.text {

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
			PillView(id: userInfo?.data.id ?? 0)
			detailRow(title: userInfo?.data.firstName ?? "-", subtitle: "<First Name Here>")
			detailRow(title: userInfo?.data.lastName ?? "-", subtitle: "<Last Name Here>")
			detailRow(title: userInfo?.data.email ?? "-", subtitle: "<Email Here>", withDivider: false)
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
