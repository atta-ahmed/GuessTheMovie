//
//  GuessTheMovieViewModel.swift
//  GuessTheMovie
//
//  Created by Atta Ahmed on 13/10/2021.
//

import Foundation

protocol GuessTheMovieProtocol {
    func fetchMovieList(completion: @escaping ()-> Void)
    var movie: Movie { get }
}

class GuessTheMovieViewModel: GuessTheMovieProtocol {

    var netWorkClient: NetworkClient
    var movieList: [Movie] = []
    var trueAnswer: String = ""

    init(netWorkClient: NetworkClient = NetworkClient()) {
        self.netWorkClient = netWorkClient
    }

    /// fetch data
    func fetchMovieList(completion: @escaping ()-> Void) {
        netWorkClient.get(request: MovieRequest()) { (result) in
            switch result {
            case .failure(let error):
                print(error)

            case .success(let response):
                guard let responseObject = try? JSONDecoder().decode([Movie].self, from: response) else {
                    return }
                print("==>",  responseObject)
                self.movieList = responseObject
            }
            completion()
        }
    }

    /// add astrerik to movie name
    func replaceAstrikteToMovieName(movieName: String) -> String {
        if movieName.isEmpty { return "" }
        var movieNameArray = movieName.split(separator: " ")
        let randomInt = Int.random(in: 0..<movieNameArray.count)
        /// save true answer word
        trueAnswer = String(movieNameArray[randomInt])

        movieNameArray.remove(at: randomInt)
        movieNameArray.insert("*******", at: randomInt)

        return movieNameArray.joined(separator: " ")
    }
    ///
    func checkAnswer(answer: String) -> Bool {
        return answer == trueAnswer
    }

    func setUpAnswers(answers: [String]) -> [String] {
        var answersArray = answers
        answersArray.append(trueAnswer)
        return answersArray.shuffled()
    }

    var movie: Movie {
        let randomInt = Int.random(in: 0..<movieList.count)
        return movieList[randomInt]
    }


}
