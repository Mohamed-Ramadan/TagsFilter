//
//  TagsFilterViewController.swift
//  UnionCoop
//
//  Created by Mohamed Ramadan on 08/08/2021.
//

import UIKit

protocol TagsFilterViewControllerDelegate {
    func filterTags(with min: Int, tagged: String)
}

class TagsFilterViewController: UIViewController {
    //MARK: - Identifier
    static let identifier = "TagsFilterViewController"
    
    //MARK: - outlets
    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var taggedTextField: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    
    //MARK: - Variables
    var viewModel: TagsFilterViewModel
    var delegate: TagsFilterViewControllerDelegate?
    
    //MARK: - Initialize
    init(with viewModel: TagsFilterViewModel, delegate: TagsFilterViewControllerDelegate? = nil) {
        // Set View Model
        self.viewModel = viewModel
        self.delegate = delegate
        
        super.init(nibName: TagsFilterViewController.identifier, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.setupTextFields()
        self.setupFilterButton()
        self.bindViewModel()
    }
     
    
    //MARK: Class Methods
    private func setupTextFields() {
        self.minTextField.text = "\(self.viewModel.min)"
        self.taggedTextField.text = self.viewModel.tagged
        
        self.minTextField.addTarget(self, action: #selector(didChangeMinTextField(_:)), for: .editingChanged)
        self.taggedTextField.addTarget(self, action: #selector(didChangeTaggedTextField(_:)), for: .editingChanged)
    }
    
    
    private func setupFilterButton() {
        self.filterButton.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        self.viewModel.error = { errorMsg in
            let alertView = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
        
        self.viewModel.applyFilter = {
            guard let delegate = self.delegate else {
                return
            }
             
            delegate.filterTags(with: self.viewModel.min, tagged: self.viewModel.tagged)
            self.navigationController?.popViewController(animated: true) 
        }
    }
    
    @objc func didChangeMinTextField(_ textField: UITextField) {
        guard let minInput = self.minTextField.text, let minValue = Int(minInput) else {
            return
        }
        
        self.viewModel.didChangeMin(min: minValue)
    }
    
    @objc func didChangeTaggedTextField(_ textField: UITextField) {
        guard let taggedInput = self.taggedTextField.text else {
            return
        }
        
        self.viewModel.didChangeTagged(tagged: taggedInput)
    }
    
    @objc func didTapFilterButton() {
        self.viewModel.didTapFilterButton()
    }
}
