public struct Todo: Encodable, Decodable {
	public let id: Int
	public let title: String
	public let isCompleted: Bool
}

extension Todo {
	public static var placeholder: Todo {
		Todo(id: Int.random(in: 1..<1000), title: "Sample Task", isCompleted: false)
	}
	
	public static var placeholderTasks: [Todo] {
		[.placeholder, .placeholder, Todo(id: 999999, title: "Done task", isCompleted: true), .placeholder,
		 .placeholder, .placeholder, Todo(id: 999989, title: "Done task", isCompleted: true),
		 .placeholder, .placeholder, Todo(id: 999799, title: "Done task", isCompleted: true),
		 .placeholder, .placeholder, Todo(id: 997999, title: "Done task", isCompleted: true),.placeholder]
	}
}
