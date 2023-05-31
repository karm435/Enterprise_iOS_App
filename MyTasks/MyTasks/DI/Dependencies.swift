
import Foundation
import Dependency
import Network

private struct NetworkClientKey: DependencyKey {
	static var currentValue: NetworkClient = NetworkClient()
}

extension DependencyValues {
	var networkClient: NetworkClient {
		get { Self[NetworkClientKey.self] }
		set { Self[NetworkClientKey.self] = newValue }
	}
}
