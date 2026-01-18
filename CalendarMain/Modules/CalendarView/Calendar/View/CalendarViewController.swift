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
        $0.delegate = self
        $0.locale = Locale(identifier: "Ru_ru")
        $0.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
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
    
//    func calendarView(
//        _ calendarView: UICalendarView,decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
//
//        guard
//            let date = Calendar.current.date(from: dateComponents)
//        else { return nil }
//
//        let day = Calendar.current.startOfDay(for: date)
//
//            let isCompleted = viewModel.historyDayRecords.contains {
//            Calendar.current.isDate($0.date, inSameDayAs: day) &&
//            $0.dayIsComplete
//        }
//
//            return isCompleted ? .default(color: .systemGreen, size: .medium) : .default(color: .red, size: .medium)
//    }
    
    func calendarView(
        _ calendarView: UICalendarView,
        decorationFor dateComponents: DateComponents
    ) -> UICalendarView.Decoration? {

        guard
            let date = Calendar.current.date(from: dateComponents)
        else { return nil }

        let day = Calendar.current.startOfDay(for: date)

        guard let record = viewModel.historyDayRecords.first(where: {
            Calendar.current.isDate($0.date, inSameDayAs: day)
        }) else {
            return nil // 🔑 нет DayRecord — нет точки
        }

        // теперь мы ТОЧНО знаем, что DayRecord есть
        return record.dayIsComplete
            ? .default(color: .systemGreen, size: .medium)
            : .default(color: .systemRed, size: .medium)
    }

    
    
}


extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    
    func dateSelection(
        _ selection: UICalendarSelectionSingleDate,
        didSelectDate dateComponents: DateComponents?
    ) {
        guard let dateComponents,
              let tappedDate = Calendar.current.date(from: dateComponents)
        else { return }

        let selectedDay = Calendar.current.startOfDay(for: tappedDate)

        handleSelectedDate(selectedDay)
    }
    
    private func handleSelectedDate(_ selectedDate: Date) {
        if let record = viewModel.historyDayRecords.first(where: {
            Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
        }) {
//            openDayRecord(record)
            let vc = UIViewController()
            vc.view.backgroundColor = .blue
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("DayRecord за этот день не найден")
            // тут можно:
            // • показать алерт
            // • или предложить создать
        }
    }


    
}

