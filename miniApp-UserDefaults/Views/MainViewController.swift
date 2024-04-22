import UIKit

final class MainViewController: UIViewController {
    // MARK: - Private properties
    
    private let titleLabel = UILabel()
    
    private let buttonsStackView = UIStackView()
    private let continueButton = UIButton()
    private let againButton = UIButton()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        layoutTitleLabel()
        layoutButtonsStackView()
        
        appearanceTitleLabel()
        configureButtonsStackView()
        configureButtons()
    }
    
    private func layoutTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func layoutButtonsStackView() {
        view.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        buttonsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func appearanceTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        titleLabel.text = "Добро пожаловать в игру!"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .darkGray
    }
    
    private func configureButtonsStackView() {
        [againButton, continueButton].forEach { buttonsStackView.addArrangedSubview($0) }
        
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 20
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.alignment = .fill
    }
    
    private func configureButtons() {
        for elem in [againButton, continueButton] {
            elem.backgroundColor = .systemBlue
            elem.setTitleColor(.white, for: .normal)
            elem.layer.cornerRadius = 10
        }
        againButton.setTitle("Новая игра", for: .normal)
        continueButton.setTitle("Продолжить", for: .normal)
        
        againButton.addTarget(self, action: #selector(tappedAgainButton), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(tappedContinueButton), for: .touchUpInside)
    }
    
    private func showAlertController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    @objc private func tappedAgainButton() {
        GameDefaultsManager.instance.removeGame()
        let vc = GameViewController()
        present(vc, animated: true)
    }

    @objc private func tappedContinueButton() {
        let counter = GameDefaultsManager.instance.getNumberOfAttempts()
        if counter == 0 {
            showAlertController(title: "Упс :(", message: "Ранее вы закончили игру, поэтому начните новую\nУдачи!")
        } else {
            let vc = GameViewController()
            present(vc, animated: true)
            vc.randomNumber = GameDefaultsManager.instance.loadGame()?.randomNumber ?? -1
            vc.counter = GameDefaultsManager.instance.loadGame()?.numberOfAttempts ?? -1
        }
    }
}
