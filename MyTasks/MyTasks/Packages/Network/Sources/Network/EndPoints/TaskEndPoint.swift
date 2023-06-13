import Foundation
import Models

public enum TaskEndPoint: EndPoint {
	case all
	case get(id: UUID)
	case delete(id: UUID)
	case update(json: Todo)
	case create(json: Todo)
	
	public func path() -> String {
		switch self {
			case .all:
				return "todos"
			case .get(let id):
				return "todos/\(id)"
			case .delete(let id):
				return "todos/\(id)"
			case .update:
				return "todos"
			case .create:
				return "todos"
		}
	}
	
	public var description: String {
		switch self {
			case .all:
				return "All Tasks"
			case .get(let id):
				return "Get Task with id\(id)"
			case .delete(let id):
				return "Delete Task with id \(id)"
			case .update:
				return "Update Task"
			case .create:
				return "Create Task"
		}
	}
	
	public var jsonValue: Encodable? {
		switch self {
			case let .update(json):
				return json
			case let .create(json):
				return json
			default:
				return nil
		}
	}
}
