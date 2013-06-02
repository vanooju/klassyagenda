package be.agenda

import java.util.List;

import groovy.transform.EqualsAndHashCode;

@EqualsAndHashCode
class ScheduleHour extends Hour {
	
	static belongsTo = [day:ScheduleDay]
	
	Course course
	int grade
	
	ScheduleHour(ScheduleDay day) {
		this.day = day
		this.beginSlot = day.availableSlots()[0]
		this.endSlot = beginSlot
	}
	
	def String toString() {
		"${beginSlot.beginHour}-${endSlot.endHour}: ${course.name}"
	}
	
	String getTitle() {
		course?.name
	}
	
}
