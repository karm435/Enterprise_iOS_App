
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TasksListView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
