import Foundation

public protocol BuilderProviderProtocol {

    associatedtype ResponseType: Decodable
    associatedtype ModelType

    func build(response: ResponseType) throws -> ModelType
}
