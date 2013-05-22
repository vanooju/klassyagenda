package be.agenda

class School {

    static constraints = {
		name nullable: false
    }
	
	static hasMany = [ teachers: ApplicationUser ]
	
	String name
}
