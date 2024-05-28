//
//  FilterMovieParameters.swift
//  MovieAPP
//
//  Created by Michael Alexander Rodriguez Urbina on 26/05/24.
//

import Foundation

public struct FilterMovieParameters {
    public var language: String
    public let forAdults: String
    public var operatorName: String
    public let average: String
    
    public init(language: String, forAdults: Bool, operatorName: Int, average: String) {
        self.forAdults = String(forAdults)
        self.operatorName = String(operatorName)
        self.average = average
        self.language = language
    }
    
    public mutating func setupValidParameters() {
        setupValidLanguage()
        setupValidOperatorName()
    }
    
    private mutating func setupValidLanguage () {
        let languageMap = ["English": "en", 
                           "Spanish": "es",
                           "Korean": "ko",
                           "French": "fr",
                           "German": "de",
                           "Italian": "it",
                           "Portuguese": "pt",
                           "Russian": "ru",
                           "Japanese": "ja"]
                language = languageMap[self.language] ?? "en"
    }
    
    private mutating func setupValidOperatorName () {
        let operatorNameMap = ["0": "gte", 
                                "1": "lte"]
                operatorName = operatorNameMap[self.operatorName] ?? "lte"
        
    }
}
