import Foundation

public protocol EndPoint {
	var description: String { get } //This appears in the intrument window
	func path() -> String
	var jsonValue: Encodable? { get }
}
