package be.agenda.domain

class LessonPlaceHolderHour extends SchooldayHour {

	static constraints = {
		course nullable: false
	}
	
	Course course
	
	LessonPlaceHolderHour(ScheduleHour scheduleHour, Schoolday schoolday) {
		this(beginSlot:scheduleHour.beginSlot, endSlot:scheduleHour.endSlot, course:scheduleHour.course, schoolday:schoolday)
	}
	
	@Override
	public String getTitle() {
		course ?: ''
	}
	
	boolean equals(Object other) {
		if (!(other instanceof LessonPlaceHolderHour || other instanceof LessonHour)) {
			return false
		} else {
			return other.schoolday == this.schoolday && other.beginSlot == this.beginSlot && other.endSlot == this.endSlot
		}
		
	}
	
	String getType() {
		'placeholder'
	}
    
}
