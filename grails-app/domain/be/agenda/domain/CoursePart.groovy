package be.agenda.domain

class CoursePart {
	
	static searchable = {
		root false
	}
	
	static belongsTo = [course:Course]
	
	static constraints = {
		name unique: 'course', blank: false
	}
	
    String name
}
