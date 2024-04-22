import UIKit

final class GameViewController: UIViewController {
    // MARK: - Private properties
    
    private let attemptsLabel = UILabel()
    private let numberTextFiled = UITextField()
    private let checkButton = UIButton()
    private let errorLabel = UILabel()
    
    // MARK: - Variables

    var randomNumber = GameDefaultsManager.instance.getRandomNumber()
    var counter = GameDefaultsManager.instance.getNumberOfAttempts()
    
    // MARK: - Lyfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        layoutAttemptsLabel()
        layoutNumberTextField()
        layoutErrorLabel()
        layoutCheckButton()
        
        configureAttemptsLabel()
        configureNumberNextField()
        configureErrorLabel()
        configureCheckButton()
    }
    
    private func layoutAttemptsLabel() {
        view.addSubview(attemptsLabel)
        attemptsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        attemptsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        attemptsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func layoutNumberTextField() {
        view.addSubview(numberTextFiled)
        numberTextFiled.translatesAutoresizingMaskIntoConstraints = false
        
        numberTextFiled.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        numberTextFiled.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        numberTextFiled.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
    }
    
    private func layoutErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        errorLabel.topAnchor.constraint(equalTo: numberTextFiled.bottomAnchor, constant: 3).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func layoutCheckButton() {
        view.addSubview(checkButton)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        
        checkButton.topAnchor.constraint(equalTo: numberTextFiled.bottomAnchor, constant: 30).isActive = true
        checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkButton.widthAnchor.constraint(equalTo: numberTextFiled.widthAnchor, multiplier: 1.5).isActive = true
    }
    
    private func configureAttemptsLabel() {
        attemptsLabel.font = .systemFont(ofSize: 16, weight: UIFont.Weight.light)
        attemptsLabel.textColor = .black
        attemptsLabel.text = "Количество попыток: \(counter)"
    }
    
    private func configureNumberNextField() {
        numberTextFiled.borderStyle = .roundedRect
        numberTextFiled.keyboardType = .numberPad
        numberTextFiled.placeholder = "Цифра?"
    }
    
    private func configureCheckButton() {
        checkButton.setTitle("Проверить", for: .normal)
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.backgroundColor = .systemGreen
        checkButton.layer.cornerRadius = 10
        
        checkButton.addTarget(self, action: #selector(tappedCheckbutton), for: .touchUpInside)
    }
    
    private func configureErrorLabel() {
        errorLabel.text = "* Попробуйте еще ..."
        errorLabel.textColor = .systemRed
        errorLabel.font = .systemFont(ofSize: 12, weight: UIFont.Weight.light)
        errorLabel.isHidden = true
    }
    
    private func showAlertController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    @objc private func tappedCheckbutton() {
        guard let text = numberTextFiled.text, !text.isEmpty else { return }
        guard let number = Int(text) else { return }
        
        counter += 1
        
        let game = Game(randomNumber: randomNumber, numberOfTextField: number, numberOfAttempts: counter)
        attemptsLabel.text = "Количество попыток: \(counter)"
        
        if randomNumber != number {
            GameDefaultsManager.instance.saveGame(game)
            errorLabel.isHidden = false
        } else {
            errorLabel.text = "* Успешно!"
            errorLabel.textColor = .systemGreen
            if counter == 2 {
                showAlertController(title: "Успех!", message: "Вы отгадали число со \(counter) попытки")
            } else {
                showAlertController(title: "Успех!", message: "Вы отгадали число с \(counter) попытки")
            }
            GameDefaultsManager.instance.removeGame()
        }
        print(game.randomNumber)
        numberTextFiled.text = ""
    }
}
