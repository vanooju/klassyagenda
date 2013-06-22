package be.agenda.domain

class School {

    static constraints = {
		name nullable: false
    }
	
	static hasMany = [ teachers: ApplicationUser ]
	
	String name
}
