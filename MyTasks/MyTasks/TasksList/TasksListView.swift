
import SwiftUI
import Models
import Network

struct TasksListView: View {
	@StateObject var viewModel: TasksListViewModel = .init()
	
	var body: some View {
		List {
			switch viewModel.state {
				case .loading:
					RedactedTasksListView()
				case let .display(tasks: tasks):
					if viewModel.isSearching {
						HStack {
							Spacer()
							ProgressView()
							Spacer()
						}
						.listRowBackground(Color.white)
						.listRowSeparator(.hidden)
						.id(UUID())
					} else {
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
					}
				case .error:
					Text("Error while fetching the data from api")
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
		.searchable(text: $viewModel.searchText)
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
            let _ = TasksContainer.shared.networkService.register {
                MockNetworkClient.tasksMockClient
            }
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



