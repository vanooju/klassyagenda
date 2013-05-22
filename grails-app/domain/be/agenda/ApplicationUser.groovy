package be.agenda

import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode
class ApplicationUser {
	
	static searchable = {
		root false
	}

	transient springSecurityService
	
	static hasOne = [ school: School ]
	
	static hasMany = [enabledFields: String]

	String username
	String password
	String firstName
	String lastName
	String emailAddress
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired 
	Date lastLoginDate

	static constraints = {
		firstName blank: false
		lastName blank: false
		username blank: false, unique: true
		password blank: false
		emailAddress blank: false, unique: true, email: true
		lastLoginDate nullable: true
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		ApplicationUserRole.findAllByUser(this).collect { it.role } as Set
	}

	Collection<Role> getApplicationUserRoles() {
		ApplicationUserRole.findAllByUser(this)
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
	
	public boolean equals(Object other) {
		if (!other) return false
		
		if (! other instanceof ApplicationUser) return false
		
		other.id == this.id
	}
}
