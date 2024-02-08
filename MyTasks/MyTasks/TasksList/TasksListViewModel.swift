import Foundation
import Models
import Network
import Combine
import SwiftUI
import Factory


class TasksListViewModel: ObservableObject {
    @Injected(\TasksContainer.networkService) var networkClient: NetworkClientProtocol
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
                guard let self = self else {return}
				if let searchTask = self.searchTask {
					searchTask.cancel()
				}
                Task {
                 await self.search()
                }
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
			state = .error
			print(error)
		}
	}
    @MainActor
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
    @MainActor
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
    public enum State: Equatable {
		case loading
		case error
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
