import Foundation

public protocol BuilderProviderProtocol {

  associatedtype ResponseType: RequestDecodable
  associatedtype ModelType

  func build(response: ResponseType) throws -> ModelType
}
