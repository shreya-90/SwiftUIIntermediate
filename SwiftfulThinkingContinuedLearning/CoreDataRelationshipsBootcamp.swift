//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 12/10/24.
//

import SwiftUI
import CoreData

//3 ENTITIES
// Business Entity
// Department Entity
// Employee Entity


class CoreDataManager {
    static let instance = CoreDataManager() //
    let container: NSPersistentContainer
    
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading Core Data. \(error)")
            }
        }
        context = container.viewContext

    }
    
    func save() {
        do {
            try context.save()
            print("Saved Successfully")
        } catch let error  {
            print("Error saving Core data. \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []

    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Microsoft"
        
        //add existing departments to the new business
        newBusiness.departments = [departments[0], departments[1]]
        
        //add existing emloyees to the new business
        newBusiness.employees = [employees[1]]
        
        //add new business to the existing department
//        newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        //add new business to existing employee
//        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Engineering"
//        newDepartment.businesses = [businesses[0]]
        newDepartment.addToEmployees(employees[1])
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 25
        newEmployee.dateJoined = Date()
        newEmployee.name = "Emily"
        
//        newEmployee.business = businesses[0]
//        newEmployee.department = departments[0]
        
        save()
        
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
//        
//        let filter = NSPredicate(format: "name == %@", "Apple")
//        request.predicate = filter
        
        do {
          businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error Fetching \(error.localizedDescription)")
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
          departments = try manager.context.fetch(request)
        } catch let error {
            print("Error Fetching \(error.localizedDescription)")
        }
        
        
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
          employees = try manager.context.fetch(request)
        } catch let error {
            print("Error Fetching \(error.localizedDescription)")
        }
        
        
    }
    
    func getEmployees(for business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        
        
        do {
          employees = try manager.context.fetch(request)
        } catch let error {
            print("Error Fetching \(error.localizedDescription)")
        }
        
        
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
       
    }
    
    
    func deleteDepartment() {
        let department = departments[1]
        manager.context.delete(department)
        save()
    }
    
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button(action: {
                        vm.deleteDepartment()
                    }, label: {
                        Text("Perform Action")
                            .foregroundColor(Color.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                            .padding(.horizontal)
                           
                        
                    })
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

#Preview {
    CoreDataRelationshipsBootcamp()
}


struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20, content: {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
                
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        })
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)

    }
}



struct DepartmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20, content: {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses:")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
                
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        })
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)

    }
}


struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20, content: {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            Text("Busimness: \(entity.business?.name ?? "")")
                .bold()
            
            Text("Department: \(entity.department?.name ?? "")")
                .bold()
            
            Text("Age: \(entity.age)")
                .bold()
            
            Text("Date joined: \(entity.dateJoined ?? Date())")
                .bold()
        })
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)

    }
}
