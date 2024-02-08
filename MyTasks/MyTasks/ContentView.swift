
import SwiftUI

struct ContentView: View {
	@StateObject private var routerPath: RouterPath = .init()
	
    var body: some View {
		NavigationStack(path: $routerPath.path) {
            VStack {
                NavigationLink(destination: SampleUI()) {
                    Text("Sample UI")
                }
                
                NavigationLink(destination: SampleUI2()) {
                    Text("Sample UI2")
                }
                //TasksListView()
                   
            }
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
