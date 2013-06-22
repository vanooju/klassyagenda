package be.agenda.domain

import java.util.Iterator;
import java.util.List;

class ScheduleDay {

	static hasMany = [hours:ScheduleHour]
	
	static belongsTo = [schedule:Schedule]
	
	int dayOfWeek
	SortedSet hours
	
	String toString() {
		def calendar = new GregorianCalendar()
		calendar.set(Calendar.DAY_OF_WEEK, dayOfWeek)
		calendar.format('EEEE')
	}
	
	List availableSlots(ScheduleHour scheduleHour) {
		def slots = new ArrayList()
		slots.addAll(schedule.slots)
		hours.each() {
			if (it != scheduleHour) {
				def beginSlotIndex = it.beginSlot.slotIndex
				def endSlotIndex = it.endSlot.slotIndex
				log.info "Removing slots ${beginSlotIndex} to ${endSlotIndex} from list."
				for (Iterator eachSlot = slots.iterator(); eachSlot
						.hasNext();) {
					Slot slot = (Slot) eachSlot.next()
					if (slot.slotIndex >= beginSlotIndex && slot.slotIndex <= endSlotIndex) {
						eachSlot.remove()
					}
				}
			}
		}
		return slots
	}
	
	List appropriateEndSlotsFor(Slot beginSlot, ScheduleHour scheduleHour) {
		def slots = schedule.slots.grep( { it.slotIndex >= beginSlot.slotIndex} )
		def endSlots = new ArrayList()
		if (slots.size() == 1) { return slots }
		endSlots.add(slots[0])
		int  i = 1
		while (i < slots.size() && slots[i-1].endHour.equals(slots[i].beginHour)) {
			endSlots.add(slots[i])
			i++
		}
		
		hours.each() {
			if (scheduleHour && (it != scheduleHour)) {
				def beginSlotIndex = it.beginSlot.slotIndex
				def endSlotIndex = it.endSlot.slotIndex
				log.info "Removing slots ${beginSlotIndex} to ${endSlotIndex} from list."
				for (Iterator eachSlot = endSlots.iterator(); eachSlot
						.hasNext();) {
				Slot slot = (Slot) eachSlot.next()
					if (slot.slotIndex >= beginSlotIndex && slot.slotIndex <= endSlotIndex) {
						eachSlot.remove()
					}
				}
			}
		}
		
		return endSlots
	}
	
	List appropriateEndSlotsFor(ScheduleHour scheduleHour) {
		appropriateEndSlotsFor(scheduleHour.beginSlot, scheduleHour)
	}
	
	List appropriateEndSlotsFor(Slot beginSlot) {
		appropriateEndSlotsFor(beginSlot, null)
	}
	
	Hour hourForSlot(slot) {
		hours.find { it.beginSlot.slotIndex <= slot.slotIndex && it.endSlot.slotIndex >=  slot.slotIndex}
	}
}
