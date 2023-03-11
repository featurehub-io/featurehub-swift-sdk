
import Foundation

internal class ClientEvalFeatureContext: ClientContext {
    let edge: EdgeService
    let internalRepo: InternalFeatureRepository

    public init(_ repo: InternalFeatureRepository, _ edge: EdgeService) {
        self.edge = edge
        internalRepo = repo
        super.init(repo)
    }

    override func build() async -> ClientContext {
        self
    }

    override func feature(_ key: String) -> RepositoryFeatureState? {
        internalRepo.feat(key)?.withContext(ctx: self)
    }
}

internal class ServerEvalFeatureContext: ClientContext {
    var oldHeader: String?
    let edge: EdgeService
    let internalRepo: InternalFeatureRepository

    public init(_ repo: InternalFeatureRepository, _ edge: EdgeService) {
        self.edge = edge
        internalRepo = repo
        super.init(repo)
    }

    override func build() async -> ClientContext {
        let newHeader = attributes.keys
                .sorted()
                .map { encodePair($0, attributes[$0]) }
                .compactMap({ $0 })
                .joined(separator: "&")

        print("new header is \(newHeader)")
        if (newHeader != oldHeader) || (oldHeader == nil) {
            oldHeader = newHeader
            internalRepo.notReady()
            print("waiting context change")
            await edge.context_change(new_header: newHeader)
            print("changed")
        }

        return self
    }

    private func encodePair(_ key: String, _ value: [String]?) -> String? {
        if value == nil {
            return nil
        }

        let k = key.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        let v = value?.compactMap({$0}).map( { $0.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) }).compactMap({$0}).joined(separator: ",") ?? ""

        return "\(k)=\(v)"
    }


    override func feature(_ key: String) -> RepositoryFeatureState? {
        internalRepo.feat(key)
    }
}
