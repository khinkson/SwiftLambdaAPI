import Foundation
import AWSLambdaEvents
import AWSLambdaRuntime

@main
struct SwiftLambdaAPI: AsyncLambdaHandler {

    typealias In = APIRequest
    typealias Out = APIResponse

    /// For more on how to make this more useful with a database
    /// See part 2 of the Swift In The Cloud Series where we
    /// introduce AWS DynamoDB integration
    /// https://www.flue.cloud/swift-server-cloud/
    
    /// Used to initialize any larger objects that have longish startup times
    /// but are typically reused with each request. Init once, and reused until the Lambda
    /// goes away. Eg: a DynamoDB client. This method is only invoked once per instance lifetime.
    /// - Parameter context: contains the event loop and logger etc. if needed
    public init(context: Lambda.InitializationContext) async throws {}

    /// Each incoming request invokes handle and expects a response in return.
    /// - Parameters:
    ///   - event: the type of event. Use String get the raw incoming data. If given a Decodable type,
    ///   it will be decoded for you. Use the typealias for 'In' above to set the type
    ///   - context: additional data passed to the lambda eg: logger, eventLoop, requestId etc.
    /// - Returns: a response as a Codable type, typealiased as 'Out' above
    func handle(event: In, context: Lambda.Context) async throws -> Out {
        var response : Out = .init(statusCode: .internalServerError)
        let path = event.context.http.path
        let method = event.context.http.method
        
        do {
            switch (method, path) {
            case (.GET, "/hello"):
                let helloResponse: HelloResponse = .init(title: "Hello", description: "We said hello.")
                let helloBody: String = try JSONEncoder.jsonAPI().encodeAsString(helloResponse)
                return .init(statusCode: .ok, body: helloBody)
                
            default:
                response = .init(statusCode: .notFound)
            }
        } catch {
            context.logger.error("Something went very wrong: \(error)")
            return response
        }
        return response
    }

    /// Used on objects that need to be cleanly shutdown on the main thread or bad things might happen.
    /// Eg: awsClient
    /// - Parameter context: contains the event loop and logger if needed
    public func syncShutdown(context: Lambda.ShutdownContext) throws {}
    
    struct HelloResponse: Encodable {
        let title: String
        let description: String?
        let created: Date
        let id: UUID
        let region: String?
        
        init(title: String, description: String? = nil, created: Date = .init()) {
            self.id = .init()
            self.title = title
            self.description = description
            self.created = created
            region = Lambda.env("AWS_REGION")
        }
    }
}
