package be.agenda

import java.util.List;

class ActivityHour extends SchooldayHour {
	
	static mapping = {
		description length: 1000
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
