//
//  CalendarViewController.swift
//  CalendarMain
//
//  Created by Artiom on 18.01.26.
//

import UIKit

class CalendarViewController: UIViewController {
    
    
    let viewModel: CalendarViewModelProtocol
    
    init(viewModel: CalendarViewModelProtocol) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("Используйте init(viewModel:) для создания этого контроллера")
        }
    
    //properties:
    
    lazy var calendarView: UICalendarView = {
        $0.calendar = Calendar(identifier: .gregorian)
//        $0.selectionBehavior = Sele
        
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UICalendarView())

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getHistoryDayRecord()
        view.backgroundColor = .white
        view.addSubview(calendarView)
        setupConstraints()
        
    }

    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            calendarView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }

}


extension CalendarViewController: UICalendarViewDelegate {
    
    func calendarView(
        _ calendarView: UICalendarView,decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {

        guard
            let date = Calendar.current.date(from: dateComponents)
        else { return nil }

        let day = Calendar.current.startOfDay(for: date)

            let isCompleted = viewModel.historyDayRecords.contains {
            Calendar.current.isDate($0.date, inSameDayAs: day) &&
            $0.dayIsComplete
        }

            return isCompleted ? .default(color: .systemGreen, size: .medium) : .default(color: .red, size: .medium)
    }
}




