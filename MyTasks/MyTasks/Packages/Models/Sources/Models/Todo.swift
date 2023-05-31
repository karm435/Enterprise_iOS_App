public struct Todo: Encodable, Decodable {
	public let id: Int
	public let title: String
	public let isCompleted: Bool
}
