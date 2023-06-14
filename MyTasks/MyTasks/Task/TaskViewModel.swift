
import Foundation
import Dependency
import Network
import Models
import SwiftUI

public class TaskViewModel: ObservableObject {
	@Dependency(\.networkClient) var networkClient
	@Published var task: Todo = .placeholder
	@Published var isSaving: Bool = false
	@Published var state: TaskViewModel.ViewState = .loading
	
	private var taskId: UUID? = nil
	
	init() { }
	
	init(task: Todo) {
		self.task = task
	}
	
	init(id: UUID) {
		// We should not fetch data here. Init should be light as it might call multiple times
		taskId = id
	}
	
	var cannotSave: Bool {
		task.title.isEmpty || isSaving
	}
	
	@MainActor
	public func saveTask(isUpdating: Bool = false) async -> Void {
		isSaving = true
		
		defer {
			isSaving = false
		}
		do {
			if isUpdating {
				try await networkClient.put(endPoint: TaskEndPoint.update(json: task))
			} else {
				try await networkClient.post(endPoint: TaskEndPoint.create(json: task))
			}
		}
		catch {
			state = .error(error: error)
		}
	}
	
	@MainActor
	public func fetchTask() async {
		guard let taskId else { return }
		state = .loading
		do {
			task = try await networkClient.get(endPoint: TaskEndPoint.get(id: taskId))
			withAnimation(.easeIn(duration: 1)) {
				state = .display
			}
			
		}
		catch {
			state = .error(error: error)
		}
	}
}

extension TaskViewModel {
	enum ViewState {
		case loading
		case error(error: Error)
		case display
	}
}
