import Foundation
import Dependency
import Models
import Network
import Combine
import SwiftUI

@MainActor
class TasksListViewModel: ObservableObject {
	@Dependency(\.networkClient) var networkClient
	@Published var state: State = .loading
	@Published var searchText: String = ""
	@Published var isSearching = false
	
	private var tasks: [Todo] = []
	private var cancelllables = Set<AnyCancellable>()
	private var searchTask: Task<Void, Never>? = nil
	init() {
		$searchText
			.debounce(for: .milliseconds(250), scheduler: DispatchQueue.main)
			.sink { [weak self] _ in
				if let searchTask = self?.searchTask {
					searchTask.cancel()
				}
				self?.search()
			}
			.store(in: &cancelllables)
			
	}
	
	public func onAppear() async {
		state = .loading
		do {
			tasks = try await networkClient.get(endPoint: TaskEndPoint.all)
			state = .display(tasks: tasks)
		}
		catch {
			state = .error(error: error)
			print(error)
		}
	}
	
	public func delete(_ indexes: IndexSet) async {
		if let index = indexes.first {
			do {
				try await networkClient.delete(endPoint: TaskEndPoint.delete(id: tasks[index].id))
				tasks.remove(at: index)
			} catch {
				print(error.localizedDescription)
			}
		}
	}
	
	private func search() {
		guard !searchText.isEmpty else {
			state = .display(tasks: tasks)
			return
		}
		isSearching = true
		
		searchTask = Task {
			try? Task.checkCancellation() // Check for cancellation before doing the heavy work
			try? await Task.sleep(for: .seconds(2)) // Or make api call
			
			let tasks = tasks.filter { $0.title.contains(searchText)}
			state = .display(tasks: tasks)
			withAnimation {
				isSearching = false
			}
		}
		
	}
}



extension TasksListViewModel {
	public enum State {
		case loading
		case error(error: Error)
		case display(tasks: [Todo])
	}
}

extension TasksListViewModel {
	static var preview: TasksListViewModel {
		let viewModel = TasksListViewModel()
		viewModel.state = .display(tasks: Todo.placeholderTasks)
		return viewModel
	}
}
