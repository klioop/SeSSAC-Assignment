import UIKit

func makeURLPathParameters(with strings: [String] = []) -> String {
    let pathParameters = strings.joined(separator: "/")
    return pathParameters
}

print(makeURLPathParameters(with: ["movie", "day"]))
