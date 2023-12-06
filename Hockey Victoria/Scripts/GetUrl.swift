//
//  GetUrl.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import Foundation

func GetUrl(url: String) -> ([String], String) {
    guard let myUrl = URL(string: url)
    else {
        return ([], url)
    }
    do {
        guard let html = fetchData(from: myUrl)
        else {
            return ([], url)
        }
        let delimiters: Set<Character> = ["<", ">"]
        return (html.split(whereSeparator: { delimiters.contains($0) }).map(String.init), "")
    }
}

func fetchData(from url: URL) -> String? {
    var result: String?
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        defer { semaphore.signal() }
        if let error = error {
            print("Error: \(error)")
            return
        }
        if let data = data, let htmlString = String(data: data, encoding: .utf8) {
            result = htmlString
        }
    }.resume()
    semaphore.wait()
    return result
}
