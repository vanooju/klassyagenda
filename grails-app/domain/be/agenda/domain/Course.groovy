package be.agenda.domain

class Course {
	
	static searchable = {
		root false
	}
	
	static mapping = {
		sort: 'name' order: 'asc'
		courseParts sort: 'name', order: 'asc'
	}
	
	static hasMany = [courseParts:CoursePart]
	
	static constraints = {name unique: 'user', blank: false 
						  user nullable: false}
	
	static belongsTo = [user : ApplicationUser]
	
    String name
	
	String toString() {
		name
	}
	
}
