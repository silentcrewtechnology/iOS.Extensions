import Foundation

extension Date {
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    var isCurrentYear: Bool {
        let year = Calendar.current.component(.year, from: self)
        let currentYear = Calendar.current.component(.year, from: Date())
        
        return year == currentYear
    }
    
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func endOfDay() -> Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay())
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth().endOfDay()!)!
    }
    
    func nextMonth() -> Date? {
        return Calendar.current.date(byAdding: DateComponents(month: 1), to: self.startOfMonth())
    }
}

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents(
            [.year, .month],
            from: Calendar.current.startOfDay(for: self))) ?? Date()
    }
    
    func startOfWeek() -> Date {
        let startOfWeek = Calendar(identifier: .gregorian)
            .dateComponents(
                [.calendar, .yearForWeekOfYear, .weekOfYear],
                from: Calendar(identifier: .gregorian).startOfDay(for: self)
            ).date ?? Date()
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: 1, to: startOfWeek) ?? Date()
    }

    func prevMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: -1), to: self.startOfMonth()) ?? Date()
    }
}
