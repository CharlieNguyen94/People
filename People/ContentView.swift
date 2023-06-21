import SwiftUI

struct ContentView: View {
    var body: some View {
		VStack {
			Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
		.onAppear {
			print("Users Response")
			dump(
				try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
			)
			print("Single User Response")
			dump(
				try? StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
			)
		}
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
