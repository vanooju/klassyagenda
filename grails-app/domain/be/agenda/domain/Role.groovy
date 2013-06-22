package be.agenda.domain

import groovy.transform.EqualsAndHashCode;

@EqualsAndHashCode
class Role {

	String authority

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}
}
