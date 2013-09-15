package be.agenda.domain

import java.util.List;

class ActivityHour extends SchooldayHour {
	
	static mappings = {
		description length: 2000
	}
	
	static constraints = {
		subject blank: false
	}
	
	String subject
	String description
	
	String getTitle() {
		subject
	}
	
	String getType() {
		'activity'
	}
	
}
