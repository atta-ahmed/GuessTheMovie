//
//  MovieRequest.swift
//  GuessTheMovie
//
//  Created by Atta Ahmed on 13/10/2021.
//

import Foundation

class MovieRequest: RequestProtocol {
    var url: URL {
        URL(string: "https://gist.githubusercontent.com/i0sa/f5b878c5a35386fda952c350fc53fce9/raw/186811752752d29fbf5ee5418065daa689593ff5/complete-movie-title.json") ?? URL(fileURLWithPath: "")
    }
}
