package be.agenda.domain


class Schoolday {
	
	static searchable = {
		schedule component: true
	}

    static hasMany = [hours:SchooldayHour]
	
	static transients = ['availableSlots', 'dayOfWeek']
	
	static mapping = {
		hours cascade: "all-delete-orphan"
		reminder length: 1000
		tasks length: 1000
		date unique: 'user'
	}
	
	static constraints = {
		reminder nullable: true
		tasks nullable: true
	}
	
	Date date
	SortedSet hours
	ApplicationUser user
	String reminder
	String tasks
	Schedule schedule
	
	void setDate(Date date) {
		date.clearTime()
		def calendar = new GregorianCalendar()
		calendar.setLenient(false)
		calendar.setTime(date)
		this.date = date
	}
	
	void initHours() {
		hours = new TreeSet()
		def calendar = new GregorianCalendar()
		calendar.setLenient(false)
		calendar.setTime(date)
		def day = schedule?.getDay(calendar.get(Calendar.DAY_OF_WEEK))
		day?.hours.each {
			addToHours(new LessonPlaceHolderHour(it, this))
		}
	}
	
	List<Slot> getAvailableSlots(Hour hour) {
		def slotList = schedule.slots.findAll { eachSlot ->
			for (Hour eachHour : hours) {
				if (eachHour.beginSlot.slotIndex <= eachSlot.slotIndex && eachHour.endSlot.slotIndex >= eachSlot.slotIndex) {
					return eachHour == hour
				}
			}
			
			return true
		}
		return slotList
	}
	
	List<Slot> getAvailableSlots() {
		getAvailableSlots(null)
	}
	
	List appropriateEndSlotsFor(Hour hour) {
		this.appropriateEndSlotsFor(hour.beginSlot, hour)
	}
	
	List appropriateEndSlotsFor(Slot beginSlot, Hour hour) {
		def slots = schedule.slots.findAll{ it.slotIndex >= beginSlot.slotIndex }
		def endSlots = new ArrayList()
		if (slots.size() == 1) { return slots }
		endSlots.add(slots[0])
		int  i = 1
		while (i < slots.size() && (hour instanceof ActivityHour || slots[i-1].endHour.equals(slots[i].beginHour))) {
			endSlots.add(slots[i])
			i++
		}
		
		hours.each() {
			if (it != hour) {
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
	
	List appropriateEndSlotsFor(Slot beginSlot) {
		def slots = schedule.slots.findAll{ it.slotIndex >= beginSlot.slotIndex }
		def endSlots = new ArrayList()
		if (slots.size() == 1) { return slots }
		endSlots.add(slots[0])
		int  i = 1
		while (i < slots.size() && slots[i-1].endHour.equals(slots[i].beginHour)) {
			endSlots.add(slots[i])
			i++
		}
		
		hours.each() {
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
		
		return endSlots
	}
	
	int getDayOfWeek() {
		def calendar = new GregorianCalendar()
		calendar.setLenient(false)
		calendar.setTime(date)
		calendar.get(Calendar.DAY_OF_WEEK)
	}
}
