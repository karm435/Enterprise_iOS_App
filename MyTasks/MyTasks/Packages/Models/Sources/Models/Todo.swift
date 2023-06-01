public struct Todo: Encodable, Decodable {
	public let id: Int
	public let title: String
	public let isCompleted: Bool
}

extension Todo {
	public static var placeholder: Todo {
		Todo(id: Int.random(in: 1..<100), title: "Sample Task", isCompleted: false)
	}
	
	public static var placeholderTasks: [Todo] {
		[.placeholder, .placeholder, .placeholder, .placeholder, .placeholder, .placeholder,.placeholder,
			.placeholder, .placeholder, .placeholder, .placeholder, .placeholder, .placeholder,.placeholder]
	}
}
