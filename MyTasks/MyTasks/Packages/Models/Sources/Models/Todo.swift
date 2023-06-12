import Foundation

public struct Todo: Encodable, Decodable {
	public var id: UUID
	public var title: String
	public var isCompleted: Bool
}

extension Todo {
	public static var placeholder: Todo {
		Todo(id: UUID(), title: "Untitled", isCompleted: false)
	}
	
	public static var placeholderTasks: [Todo] {
		[.placeholder, .placeholder, Todo(id: UUID(), title: "Done task", isCompleted: true), .placeholder,
		 .placeholder, .placeholder, Todo(id: UUID(), title: "Done task", isCompleted: true),
		 .placeholder, .placeholder, Todo(id: UUID(), title: "Done task", isCompleted: true),
		 .placeholder, .placeholder, Todo(id: UUID(), title: "Done task", isCompleted: true),.placeholder]
	}
}
