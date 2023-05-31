import Foundation
import Dependency
import Models


class TasksListViewModel: ObservableObject {
	@Dependency(\.networkClient) var networkClient
	
	@Published var task: [Todo] = []
	
	public func onAppear() {
		
	}
}
