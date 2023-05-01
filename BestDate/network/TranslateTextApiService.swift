//
//  TranslateTextApiService.swift
//  BestDate
//
//  Created by Евгений on 22.08.2022.
//

import Foundation

class TranslateTextApiService : NetworkRequest {
    static var shared = TranslateTextApiService()

    private let key: String = "9b770114-c5bb-cc0d-de5c-c7c2cdbad9c6:fx"
    private let BaseURL: String = "https://api-free.deepl.com/"

    func translate(text: String, lang: String, completion: @escaping (Bool, String) -> Void) {
        let request = createRequest(text: text, lang: lang)

        makeRequest(request: request, type: TranslationResponse.self) { response in
            completion(!(response?.translations?.isEmpty == true), response?.translations?.first?.text ?? text)
        }
    }

    private func createRequest(text: String, lang: String) -> URLRequest {
        let escapedText = String(describing: text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? text)

        let puth = "v2/translate?auth_key=\(key)&text=\(escapedText)&target_lang=\(lang.uppercased())"

        let url = URL(string: "\(BaseURL)\(puth)")
        var request = URLRequest(url: url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"

        print("POST \(BaseURL)\(puth)")
        return request
    }
}
