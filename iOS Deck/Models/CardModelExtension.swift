// Created for iOS Deck in 2020
// Using Swift 5.0

import Foundation
import NCCommunication
import MobileCoreServices

extension NCCommunicationDeckCards: NSItemProviderReading, NSItemProviderWriting {
    public static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> NCCommunicationDeckCards {
        let decoder = JSONDecoder()
        let decodedCard = try decoder.decode(NCCommunicationDeckCards.self, from: data)
        return decodedCard
    }
    
    public static var writableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeData as String]
    }
    
    public func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        
        return progress
    }
    
    public static var readableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeData as String]
    }
}

extension NCCommunicationDeckCards {
    static func ==(lhs: NCCommunicationDeckCards, rhs: NCCommunicationDeckCards) -> Bool {
        let title = lhs.title == rhs.title
        let desc = lhs.desc == rhs.desc
        let order = lhs.order == rhs.order
        return title && desc && order
    }
    
    static func !=(lhs: NCCommunicationDeckCards, rhs: NCCommunicationDeckCards) -> Bool {
        return !(lhs == rhs)
    }
}
