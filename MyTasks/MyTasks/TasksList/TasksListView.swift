
import SwiftUI
import Models

struct TasksListView: View {
	@StateObject var viewModel: TasksListViewModel = .init()
	
	var body: some View {
		List {
			switch viewModel.state {
				case .loading:
					RedactedTasksListView()
				case let .display(tasks: tasks):
					ForEach(tasks, id:\.id) { task in
						TaskRowView(task: task)
					}
				case let .error(error: error):
					Text(error.localizedDescription)
						.listRowBackground(Color.red)
			}
		}
		.task {
			await viewModel.onAppear()
		}
	}
}

struct TasksListView_Previews: PreviewProvider {
	static var previews: some View {
		TasksListView()
	}
}

