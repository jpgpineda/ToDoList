////
////  ModuleManager.swift
////  ToDoList
////
////  Created by javier pineda on 24/01/24.
////

import Swinject

struct ModuleManager {
    static let shared = ModuleManager()
    var container = Container()
    var onboardingDependency: OnboardingDependency
    var homeDependency: HomeDependency
    
    init() {
        onboardingDependency = OnboardingDependencyImplementation(container: container)
        homeDependency = HomeDependencyImplementation(container: container)
    }
}
