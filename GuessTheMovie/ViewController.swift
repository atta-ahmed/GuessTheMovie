//
//  ViewController.swift
//  CompleteTheMovieTitle
//
//  Created by Osama Gamal on 25/05/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet var anwerButtons: [UIButton]!

    var viewModel: GuessTheMovieViewModel = GuessTheMovieViewModel()
    var movieObject: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchMovieList() {
            self.movieObject = self.viewModel.movie
            DispatchQueue.main.async {
                self.showQuestion()
            }
        }
    }


    func showQuestion() {
        let movieTitle = viewModel.replaceAstrikteToMovieName(movieName: movieObject?.name ?? "")
        movieTitleLabel.text = movieTitle

        movieImageView.image = UIImage(named: movieObject?.image ?? "")
        let answers = viewModel.setUpAnswers(answers: movieObject?.wrongAnswers ?? [])

        anwerButtons.enumerated().forEach({ (index, button) in
            button.setTitle(answers[index], for: .normal)
        })
        
    }

    @IBAction func selectAnswer(_ sender: UIButton) {
        if viewModel.checkAnswer(answer: sender.titleLabel?.text ?? "") {
            // true
            print("------- true ------ ")
        } else {
            // false
            print("------- false-------")
        }
    }
}
