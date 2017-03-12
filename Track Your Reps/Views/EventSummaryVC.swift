///
/// EventSummary.swift
///

import UIKit

class EventSummaryVC: UIViewController {
    
    var event: Event?
    
    var eventTitleLabel = UILabel()
    var eventSummaryLabel = UILabel()
    
    var marginsGuide: UILayoutGuide {
        return view.layoutMarginsGuide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Layout

extension EventSummaryVC {
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        setupTitleLabel()
        setupSummaryLabel()
        [eventTitleLabel, eventSummaryLabel].forEach { view.addSubview($0) }
        setupLabelConstraints()
    }
    
    func setupTitleLabel() {
        eventTitleLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        eventTitleLabel.text = event?.question.uppercased()
        eventTitleLabel.textAlignment = .center
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupSummaryLabel() {
        eventSummaryLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        eventSummaryLabel.text = event?.eventDescription
        eventSummaryLabel.textAlignment = .center
        eventSummaryLabel.numberOfLines = 0
    }
    
    
    func setupLabelConstraints() {
        [eventTitleLabel, eventSummaryLabel].forEach { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 20).isActive = true
            label.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.8).isActive = true
        }
        eventTitleLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: 80).isActive = true
        eventSummaryLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 20).isActive = true
    }
}
