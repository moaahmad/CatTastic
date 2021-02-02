//
//  MockServer.swift
//  CatTasticTests
//
import Foundation

public final class MockServer {
    public static func loadLocalJSON(_ fileName: String) -> Data {
        if let filePath = Bundle(for: MockServer.self).path(forResource: fileName, ofType: "json") {
            do {
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                return data
            } catch {
                fatalError("Mock data was not present in bundle")
            }
        }
        fatalError("Mock data was not present in bundle")
    }
}
