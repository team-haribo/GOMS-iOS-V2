//
//  CalendarBottomSheetVC.swift
//  Feature
//
//  Created by 새미 on 4/30/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

class CalendarBottomSheetVC: BaseViewController {

    // MARK: - Properties
    var selectedDate: DateComponents? = nil

    private let bottomSheetView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "날짜 선택"
        $0.textColor = .color.gomsTextDefault.color
        $0.font = .pretendard(size: 19, weight: .bold)
    }
    
    private lazy var closeButton = UIButton().then {
        $0.setBackgroundImage(.image.cancelButton.image, for: .normal)
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private lazy var calendarView = UICalendarView().then {
        $0.tintColor = .color.gomsAdmin.color
        $0.wantsDateDecorations = true
    }
    
    // MARK: - Life Cycel
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setCalendar()
        reloadDateView(date: Date())
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: false, completion: nil)
    }
    
    private func setCalendar() {
        calendarView.delegate = self
        
        let calendarSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = calendarSelection
    }
    
    func reloadDateView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        calendarView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
    
    // MARK: - Add View
    override func addView() {
        [titleLabel, closeButton, calendarView].forEach { bottomSheetView.addSubview($0) }
        view.addSubview(bottomSheetView)
    }

    // MARK: - Layout
    override func setLayout() {
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(bounds.height * 0.56)
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.05)
            $0.height.equalTo(32)
            $0.top.equalToSuperview().inset(16)
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalTo(-bounds.width * 0.06)
            $0.top.equalToSuperview().inset(20)
        }
        
        calendarView.snp.makeConstraints {
            $0.leading.equalTo(bounds.width * 0.04)
            $0.trailing.equalTo(-bounds.width * 0.04)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
    }
}

extension CalendarBottomSheetVC: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }

    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        reloadDateView(date: Calendar.current.date(from: dateComponents!))
    }
}
