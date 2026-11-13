//
//  HabitationalUnitRepositoryProtocol.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 19/10/26.
//

protocol HabitationalUnitRepositoryProtocol {
    func getAllHabitationalUnits() -> [HabitationalUnit]?
    func getHabitationalUnitById(id: String) -> HabitationalUnit?
    func getHabitationalUnitModelById(id: String) -> HabitationalUnitModel?
    func save(habitationalUnit: HabitationalUnit) throws
    func saveDamage(huId: String, damage: Damage) throws
    func savePayment(huId: String, payment: Payment) throws
}
