
import SwiftUI
import Models

struct TasksListView: View {
	@StateObject var viewModel: TasksListViewModel = .init()
	
	init(state: TasksListViewModel.State = .loading) {
		viewModel.state = state
	}
	
	var body: some View {
		List {
			switch viewModel.state {
				case .loading:
					RedactedTasksListView()
				case let .display(tasks: tasks):
					ForEach(tasks, id:\.id) { task in
						NavigationLink(value: task.id) {
							TaskRowView(task: task)
						}
					}
				case let .error(error: error):
					Text(error.localizedDescription)
						.listRowBackground(Color.red)
			}
		}
		.task {
			await viewModel.onAppear()
		}
		.navigationTitle(Text("My Tasks"))
	}
}

struct TasksListView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			Group {
				TasksListView()
			}
		}
	}
}


