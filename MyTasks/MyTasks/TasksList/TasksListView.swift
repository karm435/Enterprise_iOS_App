
import SwiftUI
import Models
import Dependency
import Network

struct TasksListView: View {
	@StateObject var viewModel: TasksListViewModel = .init()
	
	var body: some View {
		List {
			switch viewModel.state {
				case .loading:
					RedactedTasksListView()
				case let .display(tasks: tasks):
					ForEach(tasks, id:\.id) { task in
						NavigationLink(value: RouterDestinations.taskUpdate(id: task.id)) {
							TaskRowView(task: task)
						}
					}
					.onDelete { indexes in
						Task {
							await viewModel.delete(indexes)
						}
					}
				case let .error(error: error):
					Text(error.localizedDescription)
						.listRowBackground(Color.red)
			}
		}
		.listStyle(.plain)
		.background(.white)
		.navigationBarTitleDisplayMode(.large)
		.task {
			await viewModel.onAppear()
		}
		.refreshable {
			await viewModel.onAppear()
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				NavigationLink {
					TaskCreateView()
				} label: {
					Image(systemName: "plus")
				}
			}
		}
		.navigationTitle(Text("My Tasks"))
	}
}

struct TasksListView_Previews: PreviewProvider {
	struct PreviewWithData: View {
		init() {
			DependencyValues[\.networkClient] = MockNetworkClient.tasksMockClient
		}
		
		var body: some View {
			TasksListView()
		}
	}
	
	static var previews: some View {
		Group {
			NavigationStack {
				PreviewWithData()
			}
			
			NavigationStack {
				PreviewWithData()
					.preferredColorScheme(.dark)
			}
		}
	}
}

struct TasksListView_PreviewsError: PreviewProvider {
	
	struct PreviewWithError: View {
		init() {
			DependencyValues[\.networkClient] = MockNetworkClient.errorClient
		}
		
		var body: some View {
			TasksListView()
		}
	}
	
	static var previews: some View {
		Group {
			NavigationStack {
				PreviewWithError()
					.preferredColorScheme(.dark)
			}
			
			NavigationStack {
				PreviewWithError()
			}
		}
	}
}


