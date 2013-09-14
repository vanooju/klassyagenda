package be.agenda.domain

class CoursePart {
	
	static searchable = {
		root false
	}
	
	static belongsTo = [course:Course]
	
	static constraints = {
		name unique: 'course', blank: false
	}
	
	static mapping = {
		sort name: "asc"
	}
	
    String name
}
