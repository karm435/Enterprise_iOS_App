import Foundation
import Models
import SwiftUI

public enum RouterDestinations: Hashable {
	case taskUpdate(id: UUID)
	case taskUpdateWithTask(task: Todo)
}

@MainActor
public class RouterPath: ObservableObject {
	@Published public var path: [RouterDestinations] = []
	
	public init() {}
	
	public func navigate(to: RouterDestinations) {
		path.append(to)
	}
}

@MainActor
extension View {
	func withAppRouter() -> some View {
		navigationDestination(for: RouterDestinations.self) { destination in
			switch destination {
				case let .taskUpdate(id):
					TaskUpdateView(id: id)
				case let .taskUpdateWithTask(task):
					TaskUpdateView(task: task)
			}
		}
	}
}
