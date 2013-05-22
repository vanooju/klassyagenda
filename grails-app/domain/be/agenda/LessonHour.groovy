package be.agenda

public class LessonHour extends LessonPlaceHolderHour {
	
	static searchable = {
		coursePart component: true
		course component: true
		schoolday component: true
		subject boost: 2.0
		mapping {
			spellCheck "include"
		}
	}
	
	static mappings = {
		descriptionBegin size: 1000
		descriptionMiddle size: 1000
		descriptionEnd size:1000
		objectives size: 1000
		media size: 1000
	}
	
	static constraints = {
		coursePart nullable: false
		subject blank: false
    }
	
	CoursePart coursePart
	String subject
	String descriptionBegin
	String descriptionMiddle
	String descriptionEnd
	String objectives
	String media
	boolean otherTeacher
	
	LessonHour(LessonPlaceHolderHour placeholder) {
		this(beginSlot:placeholder.beginSlot, endSlot:placeholder.endSlot, schoolday:placeholder.schoolday, course:placeholder.course)
	}
	
	LessonHour(ScheduleHour placeholder, Schoolday schoolday) {
		this(beginSlot:placeholder.beginSlot, endSlot:placeholder.endSlot, schoolday:schoolday, course:placeholder.course)
	}
	
	String getType() {
		'lesson'
	}
}