
import SwiftUI

struct TaskView: View {
	@StateObject private var viewModel: TaskViewModel = .init()
	
    var body: some View {
		Form {
			TextField("Title", text: $viewModel.task.title)
		}
		.navigationTitle("New Task")
		.navigationBarTitleDisplayMode(.inline)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			TaskView()
		}
    }
}
