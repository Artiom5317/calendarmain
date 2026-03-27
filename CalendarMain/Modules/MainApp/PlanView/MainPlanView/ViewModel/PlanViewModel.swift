//
//  PlanViewModel.swift
//  CalendarMain
//
//  Created by Artiom on 20.01.26.
//

import Foundation


enum PlanRoute {
    case add
    case info
}

protocol PlanViewModelProtocol: AnyObject {
    //Проверка на пустой массив plans
    var isEmpty: Bool { get }
    
    // действия при изменени массива plans
    var onDataUpdated: (() -> Void)? { get set }
    //Получения данных с UserDefaults
    func fetchPlans()
    //Сколько numberOfRowsInSection
    var plansCount: Int { get }
    func planData(from index: Int) -> Plan
    
    // tappedButton selectedPlanButton
    func changeIsActivePlan(at index: Int)
    // Навиция

    func didTapNavigation(_ plan: PlanRoute)
    
//    var onNavigate: ((PlanRoute) -> Void)? { get set }
}



final class PlanViewModel: PlanViewModelProtocol {

    private let manager = StorageManager.shared
    

    private var plans: [Plan] = []

    var onDataUpdated: (() -> Void)?
    var onNavigate: ((PlanRoute) -> Void)?

    var isEmpty: Bool {
        plans.isEmpty
    }

    var plansCount: Int {
        plans.count
    }

    func fetchPlans() {
        plans = manager.loadPlans()
        onDataUpdated?()
    }

    func didTapNavigation(_ plan: PlanRoute) {
        onNavigate?(plan)
    }
    
    func planData(from index: Int) -> Plan {
        return plans[index]
    }
}


extension PlanViewModel {
    
    // Он должен.
    //1.. менять массив который у нас.
    //2 менять activePlan в БД.
    //3

    func changeIsActivePlan(at index: Int) {
        for i in plans.indices {
                plans[i].isActive = false
            }
        
        plans[index].isActive = true
        let newPlan = plans[index]

        
        let currentDay = StorageManager.shared.getCurrentDayRecord()
        guard let nonOptionalCurrentDay = currentDay else { return }
        
        
        if nonOptionalCurrentDay.dayIsComplete {
            // ПОКАЗАТЬ КАКОЙ_ТО ЭКРАН ИЛИ ЧЕТ ТИПО предупрежения что завтра план станет активным
            // onAlleartShow?()
        } else {
            
            StorageManager.shared.saveDayRecord(plan: newPlan)
        }
        
        StorageManager.shared.saveWhichIsActivePlan(newPlan)
        StorageManager.shared.editPlans(plans: plans)
        onDataUpdated?()
        print("changeIsActivePlan")
    }
    

}







#warning("Также стоит выяснить где писать навигацию с координатором. во ViewController только?")



