import UIKit

final class GameViewController: UIViewController {
    // MARK: - Private properties
    
    private let attemptsLabel = UILabel()
    private let numberTextFiled = UITextField()
    private let checkButton = UIButton()
    
    // MARK: - Lyfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupUI()
        print("open")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("close")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        layoutAttemptsLabel()
        layoutNumberTextField()
        layoutCheckButton()
        
        configureAttemptsLabel()
        configureNumberNextField()
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
    
    private func layoutCheckButton() {
        view.addSubview(checkButton)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        
        checkButton.topAnchor.constraint(equalTo: numberTextFiled.bottomAnchor, constant: 20).isActive = true
        checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkButton.widthAnchor.constraint(equalTo: numberTextFiled.widthAnchor, multiplier: 1.5).isActive = true
    }
    
    private func configureAttemptsLabel() {
        attemptsLabel.font = .systemFont(ofSize: 16, weight: UIFont.Weight.light)
        attemptsLabel.textColor = .black
        attemptsLabel.text = "Количество попыток: "
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
    
    @objc private func tappedCheckbutton() {}
}
