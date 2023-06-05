
import Foundation
import Dependency
import Network

private struct NetworkClientKey: DependencyKey {
	static var currentValue: NetworkClientProtocol = NetworkClient()
}

extension DependencyValues {
	var networkClient: NetworkClientProtocol {
		get { Self[NetworkClientKey.self] }
		set { Self[NetworkClientKey.self] = newValue }
	}
}
