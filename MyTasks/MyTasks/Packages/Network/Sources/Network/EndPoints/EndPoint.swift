import Foundation

public protocol EndPoint {
	func path() -> String
	var jsonValue: Encodable? { get }
}
