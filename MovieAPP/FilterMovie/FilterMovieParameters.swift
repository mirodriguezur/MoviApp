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
    public var operatorRange: String
    public let average: String
    
    public init(language: String, forAdults: Bool, operatorName: Int, average: String) {
        self.forAdults = String(forAdults)
        self.operatorRange = String(operatorName)
        self.average = average
        self.language = language
    }
    
    public mutating func setupValidParameters() {
        setupValidLanguage()
        setupValidOperatorRange()
    }
    
    private mutating func setupValidLanguage () {
        var validLanguage = ""
        switch self.language {
        case "English":
            validLanguage = "en"
        case "Spanish":
            validLanguage = "es"
        case "Korean":
            validLanguage = "ko"
        default:
            validLanguage = "en"
        }
        language = validLanguage
    }
    
    private mutating func setupValidOperatorRange () {
        var validOperatorRange = ""
        switch self.operatorRange {
        case "0":
            validOperatorRange = "gte"
        case "1":
            validOperatorRange = "lte"
        default:
            validOperatorRange = "lte"
        }
        operatorRange = validOperatorRange
        
    }
}
