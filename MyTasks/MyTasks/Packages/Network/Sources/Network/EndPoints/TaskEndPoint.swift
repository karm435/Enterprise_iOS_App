import Models

public enum TaskEndPoint: EndPoint {
	case all
	case get(id: String)
	case delete(id: String)
	case update(json: Todo)
	case create(json: Todo)
	
	public func path() -> String {
		switch self {
			case .all:
				return "todos"
			case .get(let id):
				return "task/\(id)"
			case .delete(let id):
				return "task/\(id)"
			case .update:
				return "todos"
			case .create:
				return "todos"
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
