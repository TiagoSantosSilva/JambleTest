//
//  ProductListSearchBar.swift
//  JambleTest
//
//  Created by Tiago Silva on 14/01/2024.
//

import Combine
import UIKit

final class ProductListSearchBar: UIView {
    enum PassthroughAction {
        case reset
        case text(String)
    }
    
    // MARK: Internal Properties
    
    let passthroughSubject = PassthroughSubject<PassthroughAction, Never>()
    
    // MARK: Private Properties
    
    private var cancellables: Set<AnyCancellable> = []
    private let textField = ProductListSearchTextField()
    private let resetButton = RoundedButton(title: LocalizedStrings.reset)

    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: Internal Functions
    
    func reset() {
        textField.reset()
    }
    
    // MARK: Private Functions
    
    private func setup() {
        add(children: textField, resetButton)
        setupTextField()
        setupResetButton()
    }
    
    private func setupTextField() {
        textField.backgroundColor = .textField
        textField.clipsToBounds = true
        textField.layer.cornerRadius = Constants.TextField.cornerRadius
        textField.textSubject
            .debounce(for: .seconds(Constants.TextField.debounce), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.passthroughSubject.send(.text($0))
            }.store(in: &cancellables)
        textField.constraint(to: self, anchors: [.leading])
        textField.constraint(to: self, anchors: [.vertical])
        textField.trailingAnchor.constraint(equalTo: resetButton.leadingAnchor,
                                            constant: -Constants.TextField.padding).isActive = true
    }
    
    private func setupResetButton() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setContentCompressionResistancePriority(.init(Constants.ResetButton.contentPriority),
                                                            for: .horizontal)
        resetButton.setContentHuggingPriority(.init(Constants.ResetButton.contentPriority),
                                              for: .horizontal)
        resetButton.constraint(to: self, anchors: [.vertical])
        resetButton.constraint(to: self, anchors: [.trailing])
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func resetButtonTapped(_ sender: UIButton) {
        passthroughSubject.send(.reset)
    }
}

// MARK: - Constants

private extension ProductListSearchBar {
    enum Constants {
        enum TextField {
            static let padding: CGFloat = 8
            static let cornerRadius: CGFloat = 24
            static let debounce: Double = 0.3
        }
        
        enum ResetButton {
            static let contentPriority: Float = 1000
        }
    }
}

private final class ProductListSearchTextField: UIView {
    
    // MARK: Internal Properties
    
    let textSubject = PassthroughSubject<String, Never>()
    
    // MARK: Private Properties
    
    private let imageView = UIImageView()
    private let textField = UITextField()
    private let clearButton = UIButton()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: Internal Functions
    
    func reset() {
        textField.text = ""
        clearButton.isHidden = true
        textSubject.send("")
    }
    
    // MARK: Private Functions
    
    private func setup() {
        add(children: imageView, textField, clearButton)
        setupImageView()
        setupTextField()
        setupClearButton()
    }
    
    private func setupImageView() {
        imageView.image = .search
            .withTintColor(.secondaryLabel)
        imageView.constraint(to: self, anchors: [.leading], padding: Constants.padding)
        imageView.frame(height: Constants.frame, width: Constants.frame)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupTextField() {
        textField.placeholder = LocalizedStrings.search
        textField.constraint(to: self, anchors: [.vertical], padding: Constants.padding)
        textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,
                                           constant: Constants.padding).isActive = true
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        textField.font = .systemFont(ofSize: Constants.fontSize, weight: .medium)
        textField.tintColor = .label
    }
    
    private func setupClearButton() {
        clearButton.setImage(.xMarkFill, for: .normal)
        clearButton.tintColor = .secondaryLabel
        clearButton.frame(height: Constants.ClearButton.frame,
                          width: Constants.ClearButton.frame)
        clearButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor,
                                             constant: Constants.ClearButton.padding).isActive = true
        clearButton.constraint(to: self, anchors: [.trailing], padding: Constants.ClearButton.padding)
        clearButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        clearButton.isHidden = true
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Selectors
    
    @objc
    private func textFieldEditingChanged(_ sender: UITextField) {
        guard let text = textField.text else { return }
        clearButton.isHidden = text.isEmpty
        textSubject.send(text)
    }
    
    @objc
    private func clearButtonTapped(_ sender: UIButton) {
        reset()
    }
}

// MARK: Constants

private extension ProductListSearchTextField {
    enum Constants {
        static let padding: CGFloat = 8
        static let frame: CGFloat = 24
        static let fontSize: CGFloat = 17
        
        enum ClearButton {
            static let frame: CGFloat = 24
            static let padding: CGFloat = 8
        }
    }
}
