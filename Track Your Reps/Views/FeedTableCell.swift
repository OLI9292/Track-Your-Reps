///
/// FeedTableCell.swift
///

import UIKit

class FeedTableCell: UITableViewCell {
    
    let eventQuestionLabel = UITextView()
    let eventTimeLabel = UILabel()
    let eventDescriptionLabel = UILabel()
    let repActionLabel = UILabel()
    
    var event: Event? {
        didSet {
            guard let event = event else { return }
            repActionLabel.attributedText = event.memberPositions
            eventTimeLabel.text = formatDate(event.date)
            switch event.isBill {
            case true:
                setUpBill(event)
            case false:
                setUpNonBill(event)
            }
            
        }
    }
    
    var labels: [UILabel] {
        return [eventDescriptionLabel, repActionLabel]
    }
    
    static let reuseID = "events"
    
    var marginsGuide: UILayoutGuide {
        return contentView.layoutMarginsGuide
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Layout

extension FeedTableCell {
    
    func setupView() {
        labels.forEach { contentView.addSubview($0) }
        contentView.addSubview(eventQuestionLabel)
        contentView.addSubview(eventTimeLabel)
        setupLabels()
    }
    
    func setupLabels() {
        eventQuestionLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        eventQuestionLabel.textColor =  Palette.white.color
        eventQuestionLabel.backgroundColor = Palette.black.color
        
        // TODO: calculate this more effectively without breaking constraints
        eventQuestionLabel.textContainerInset = UIEdgeInsetsMake(5, 30, 5, 10)
        eventQuestionLabel.textAlignment = .left
        
        eventTimeLabel.font = UIFont(name: "Montserrat-Light", size: 14)
        eventTimeLabel.textColor = Palette.grey.color
        
        eventDescriptionLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        eventDescriptionLabel.setLineHeight(lineHeight: 10)
        
        repActionLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        repActionLabel.attributedText = event?.memberPositions
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        labels.forEach { setupCommonConstraints($0) }
        eventTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTimeLabel.numberOfLines = 0
        eventQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        setupUniqueConstraints()
    }
    
    func setupCommonConstraints(_ label: UILabel) {
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupUniqueConstraints() {
        
        eventQuestionLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: contentView.frame.height * 0.3).isActive = true
        eventQuestionLabel.widthAnchor.constraint(lessThanOrEqualTo: marginsGuide.widthAnchor, multiplier: 0.8).isActive = true
        eventQuestionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        eventQuestionLabel.isScrollEnabled = false
        eventQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        eventTimeLabel.topAnchor.constraint(equalTo: eventQuestionLabel.topAnchor).isActive = true
        eventTimeLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        
        eventDescriptionLabel.topAnchor.constraint(equalTo: eventQuestionLabel.bottomAnchor, constant: contentView.frame.height * 0.4).isActive = true
        eventDescriptionLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor, constant: -contentView.frame.width * 0.1).isActive = true
        eventDescriptionLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: contentView.frame.width * 0.05).isActive = true
        
        repActionLabel.topAnchor.constraint(equalTo: eventDescriptionLabel.bottomAnchor, constant: contentView.frame.height * 0.3).isActive = true
        repActionLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        repActionLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor).isActive = true
    }
    
    func formatDate(_ date: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        
        let date: Date? = dateFormatterGet.date(from: date)
        
        return dateFormatter.timeSince(from: date!)
    }
}

// MARK: - Bill or NonBill Specific Layout

extension FeedTableCell {
    
    func setUpBill(_ event: Event) {
        eventQuestionLabel.text = event.bill?.subject.uppercased()
        guard let safeBill = event.bill else { return }
        eventQuestionLabel.backgroundColor = determineBackgroundColor(safeBill.subject)
        
        if event.bill?.summary != "" {
            eventDescriptionLabel.text = event.bill?.summary.replacingOccurrences(of: "(This measure has not been amended since it was introduced. The summary of that version is repeated here.) ", with: "").replacingOccurrences(of: "&quot;", with: "\"")
        } else {
            eventDescriptionLabel.text = event.eventDescription
        }
    
    }
    
    func determineBackgroundColor(_ text:String) -> UIColor {
        
        if text.contains("Education") {
            return Palette.green.color
        } else if text.contains("Natural") {
            return Palette.blue.color
        } else {
            return Palette.black.color
        }
        
    }
    
    func setUpNonBill(_ event: Event) {
        eventQuestionLabel.text = event.question.uppercased()
        eventDescriptionLabel.text = event.eventDescription
       
    }
}

