package be.agenda.services

import be.agenda.ApplicationUser
import be.agenda.Schedule
import be.agenda.ScheduleDay
import be.agenda.Slot

class ScheduleService {

    Schedule createSchedule(int beginYear, ApplicationUser user, int grade) {
		def schedule = new Schedule(beginYear: beginYear, user: user, grade: grade)
		
		schedule.days =  [
			new ScheduleDay(dayOfWeek: Calendar.MONDAY, schedule: schedule),
			new ScheduleDay(dayOfWeek: Calendar.TUESDAY, schedule: schedule),
			new ScheduleDay(dayOfWeek: Calendar.WEDNESDAY, schedule: schedule),
			new ScheduleDay(dayOfWeek: Calendar.THURSDAY, schedule: schedule),
			new ScheduleDay(dayOfWeek: Calendar.FRIDAY, schedule: schedule)
		]
		
		schedule.slots = [
			new Slot(0, "8:30", "8:55"),
			new Slot(1, "8:55", "9:20"),
			new Slot(2, "9:20", "9:45"),
			new Slot(3, "10:00", "10:25"),
			new Slot(4, "10:25", "10:50"),
			new Slot(5, "10:50", "11:15"),
			new Slot(6, "11:15", "11:40"),
			new Slot(7, "13:00", "13:25"),
			new Slot(8, "13:25", "13:50"),
			new Slot(9, "13:50", "14:15"),
			new Slot(10, "14:30", "14:55"),
			new Slot(11, "14:55", "15:25")
		]
		
		schedule
    }
}
