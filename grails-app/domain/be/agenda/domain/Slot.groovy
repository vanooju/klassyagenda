package be.agenda.domain

import groovy.transform.EqualsAndHashCode;

@EqualsAndHashCode
class Slot {
	
    Integer slotIndex
	String beginHour
	String endHour
	
	Slot(Integer index, String beginHour, String endHour) {
		this.slotIndex = index
		this.beginHour = beginHour
		this.endHour = endHour
	}
	
	String toString() {
		"${beginHour} - ${endHour}"
	}
}
