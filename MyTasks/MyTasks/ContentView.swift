
import SwiftUI

struct ContentView: View {
	@StateObject private var routerPath: RouterPath = .init()
	
    var body: some View {
		NavigationStack(path: $routerPath.path) {
            TasksListView()
				.withAppRouter()
				.environmentObject(routerPath)
        }
        .padding()
		
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
