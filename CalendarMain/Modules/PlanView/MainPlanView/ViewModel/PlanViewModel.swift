//
//  PlanViewModel.swift
//  CalendarMain
//
//  Created by Artiom on 20.01.26.
//

import Foundation


enum PlanNavigation {
    case add
    case info
}

protocol PlanViewModelProtocol: AnyObject {
    var isEmpty: Bool { get }
    var plansCount: Int { get }

    var onDataUpdated: (() -> Void)? { get set }
    var onNavigate: ((PlanNavigation) -> Void)? { get set }

    func fetchPlans()
    func didTapNavigation(_ plan: PlanNavigation)
}


final class PlanViewModel: PlanViewModelProtocol {

    private let manager = StorageManager.shared
    private(set) var plans: [Plan] = []

    var onDataUpdated: (() -> Void)?
    var onNavigate: ((PlanNavigation) -> Void)?

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

    func didTapNavigation(_ plan: PlanNavigation) {
        onNavigate?(plan)
    }
}


