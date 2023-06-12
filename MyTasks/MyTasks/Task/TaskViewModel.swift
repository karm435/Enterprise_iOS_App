
import Foundation
import Dependency
import Network
import Models

public class TaskViewModel: ObservableObject {
	@Dependency(\.networkClient) var networkClient
	@Published var task: Todo = .placeholder
}
