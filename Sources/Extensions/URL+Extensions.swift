import Foundation

extension URL {
    
    func appending(_ queryItem: String, value: String?) -> URL {
        return appending(URLQueryItem(name: queryItem, value: value))
    }
    
    func appending(_ queryItem: URLQueryItem) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + [queryItem]
        
        return urlComponents.url ?? absoluteURL
    }
    
    func valueOfQueryItem(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParameterName })?.value
    }
}
