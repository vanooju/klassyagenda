package be.agenda

import java.util.List;

abstract class Hour implements Comparable {
	
	static transients = ['beginHour', 'endHour', 'availableSlots','title']
	
	static constraints = {
		beginSlot nullable: false
		endSlot nullable: false
    }
	
	static mapping = {
		tablePerHierarchy false
	}
	
	Slot beginSlot
	Slot endSlot
	
	String getBeginHour() {
		beginSlot?.beginHour
	}
	
	String getEndHour() {
		endSlot?.endHour
	}
	
	public int compareTo(def other) {
		return beginSlot?.slotIndex <=> other?.beginSlot?.slotIndex // <=> is the compareTo operator in groovy
	}
	
	abstract String getTitle()
}
