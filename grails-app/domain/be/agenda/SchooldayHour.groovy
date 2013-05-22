package be.agenda

import java.util.List;

abstract class SchooldayHour extends Hour {

    static belongsTo = [schoolday: Schoolday]
	
	List<Slot> getAvailableSlots() {
		schoolday.getAvailableSlots(this)
	}
	
	List<Slot> getAppropriateEndSlots() {
		schoolday.appropriateEndSlotsFor(this)
	}
	
	List<Slot> getAppropriateEndSlots(Slot beginSlot) {
		schoolday.appropriateEndSlotsFor(beginSlot, this)
	}
	
}
