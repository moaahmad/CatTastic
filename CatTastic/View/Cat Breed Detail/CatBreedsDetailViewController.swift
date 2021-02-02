//
//  CatBreedsDetailViewController.swift
//  CatTastic
//
//  Created by Mohammed Ahmad on 29/1/21.
//
import UIKit

final class CatBreedsDetailViewController: BaseViewController {
    // MARK: - Static Properties
    static let screenHeight = UIScreen.main.bounds.height
    
    // MARK: - IBOutlets
    @IBOutlet private(set) var headerView: UIView!
    @IBOutlet private(set) var headerImageView: UIImageView!
    @IBOutlet private(set) var contentStackView: UIStackView!
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var originLabel: UILabel!
    @IBOutlet private(set) var favouriteImage: UIImageView! {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                              action: #selector(favouriteImageTapped))
            favouriteImage.isUserInteractionEnabled = true
            favouriteImage.addGestureRecognizer(tapGestureRecognizer)
            favouriteImage.tintColor = viewModel.isAlreadyFavourite ? .systemRed : .tertiaryLabel
        }
    }
    @IBOutlet private(set) var aboutLabel: UILabel!
    @IBOutlet private(set) var lifeSpanLabel: UILabel!
    @IBOutlet private(set) var weightLabel: UILabel!
    @IBOutlet private(set) var temperamentLabel: UILabel!
    @IBOutlet private(set) var wikipediaButton: UIButton!

    // MARK: - Internal Properties
    var viewModel: CatBreedDetailViewModel!
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationBarTransparent()
        configureUI(with: viewModel.catBreed)
        styleUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.popViewController(animated: false)
    }
    
    // MARK: - IBActions
    @IBAction private func didTapWikipediaButton() {
        guard let urlString = viewModel.catBreed.wikipediaURL,
              let url = URL(string: urlString),
              coordinator != nil else {
            coordinator?.presentOkAlert(title: "wiki_error_title".localized(),
                                        message: "wiki_error_message".localized(),
                                        alertTitle: "okay_action_title".localized())
            return
        }
        coordinator?.presentSafariVC(with: url)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

// MARK: - Functions
extension CatBreedsDetailViewController {
    func configureUI(with catBreed: CatBreed) {
        configureImageView(for: catBreed)
        titleLabel.text = catBreed.name
        originLabel.text = catBreed.origin
        aboutLabel.text = catBreed.description
        lifeSpanLabel.text = catBreed.lifeSpan
        weightLabel.text = catBreed.weight?.metric
        temperamentLabel.text = catBreed.temperament
    }
    
    func styleUI() {
        guard let image = headerImageView.image else { return }
        let hasUrl = viewModel.catBreed.image?.url != nil
        wikipediaButton.backgroundColor = hasUrl ? image.averageColor : .tintGreen
    }
    
    @objc func favouriteImageTapped() {
        viewModel.updateFavourites { [weak self] isFavourite in
            self?.favouriteImage.tintColor = isFavourite ? .systemRed : .tertiaryLabel
        }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    private func configureImageView(for catBreed: CatBreed) {
        guard let catImage = catBreed.image,
              catImage.url != nil else {
            headerImageView.image = UIImage(named: "placeholder")
            return
        }
        headerImageView.setImage(for: catImage.url)
    }
}
