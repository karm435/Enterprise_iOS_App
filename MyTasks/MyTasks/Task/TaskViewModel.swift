
import Foundation
import Dependency
import Network
import Models

public class TaskViewModel: ObservableObject {
	@Dependency(\.networkClient) var networkClient
	@Published var task: Todo = .placeholder
	@Published var isSaving: Bool = false
	
	var cannotSave: Bool {
		task.title.isEmpty || isSaving
	}
	
	@MainActor
	public func saveTask() async -> Void {
		isSaving = true
		
		defer {
			isSaving = false
		}
		do {
			try await networkClient.post(endPoint: TaskEndPoint.create(json: task))
		}
		catch {
			print(error.localizedDescription)
		}
	}
}
