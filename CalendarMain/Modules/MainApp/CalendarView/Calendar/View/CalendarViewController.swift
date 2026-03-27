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
        view.backgroundColor = .systemBackground
        view.addSubview(calendarView)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getHistoryDayRecord()
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
    
    
    private func dateSelection(
        _ selection: UICalendarSelectionSingleDate,
        didDeselectDate dateComponents: DateComponents?
    ) {
        print("Дата снята")
    }
    
    
    
    func dateSelection(
        _ selection: UICalendarSelectionSingleDate,
        didSelectDate dateComponents: DateComponents?
    ) {
        guard let dateComponents,
              let tappedDate = Calendar.current.date(from: dateComponents)
        else { return }
        
        selection.setSelected(nil, animated: false)

        let selectedDay = Calendar.current.startOfDay(for: tappedDate)

        handleSelectedDate(selectedDay)
    }
    
    private func handleSelectedDate(_ selectedDate: Date) {
        if let record = viewModel.historyDayRecords.first(where: {
            Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
        }) {
//            openDayRecord(record)
            let vc = Builder.createDetailtsVC(data: record)
            vc.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            
            showToast("Нет данных для этого дня")
            // тут можно:
            // • показать алерт
            // • или предложить создать
        }
    }

}






class Builder {
    static func createDetailtsVC(data: DayRecord?) -> UIViewController {
        let viewModel = DayDetailtsViewModel(dayDetails: data)
        let vc = DayDetailsViewController(viewModel: viewModel)
        return vc
    }
}




extension CalendarViewController {
    
    func showToast(_ text: String, visibleFor: TimeInterval = 1.2) {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)

        // Adaptive colors (light/dark)
        label.textColor = .label
        label.backgroundColor = .secondarySystemBackground

        label.layer.cornerRadius = 8
        label.clipsToBounds = true

        label.alpha = 0

        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            label.heightAnchor.constraint(equalToConstant: 45),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])

        view.layoutIfNeeded()

        // ОДНА анимация с несколькими стадиями
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            label.alpha = 1
        } completion: { _ in
            // После показа ждем visibleFor секунд
            UIView.animate(withDuration: 0.3, delay: visibleFor, options: .curveEaseIn) {
                label.alpha = 0
            } completion: { _ in
                label.removeFromSuperview()
            }
        }
        
        
        
    }



}
