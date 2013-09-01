package be.agenda.domain

import java.util.List;

import org.apache.commons.logging.LogFactory

import be.agenda.AgendaUtils;
import be.agenda.InvalidScheduleException;

class Schedule {
	
	static searchable = {
		root false
	}
	
	transient def springSecurityService
	
	private static final log = LogFactory.getLog(this)
	
	static belongsTo = [user:ApplicationUser]
	
	static hasMany = [days:ScheduleDay, slots:Slot]
	
	static transients = ['schoolyear']
	
	static constraints = {
		beginYear unique: 'user'
	}
	
	int beginYear
	List<Slot> slots
	List<ScheduleDay> days
	
	public Schedule(int beginYear, ApplicationUser user) {
		this.beginYear = beginYear
		this.user = user
		days = [new ScheduleDay(dayOfWeek: Calendar.MONDAY, schedule:this),
		       	new ScheduleDay(dayOfWeek: Calendar.TUESDAY, schedule:this),
		       	new ScheduleDay(dayOfWeek: Calendar.WEDNESDAY, schedule:this),
		       	new ScheduleDay(dayOfWeek: Calendar.THURSDAY, schedule:this),
		       	new ScheduleDay(dayOfWeek: Calendar.FRIDAY, schedule:this)]
		slots = [new Slot(0, "8:30", "8:55"),
				 new Slot(1, "8:55", "9:20"),
				 new Slot(2, "9:20", "9:45"),
				 new Slot(3, "10:00", "10:25"),
				 new Slot(4, "10:25", "10:50"),
				 new Slot(5, "10:50", "11:15"),
				 new Slot(6, "11:15", "11:40"),
				 new Slot(7, "13:00", "13:25"),
				 new Slot(8, "13:25", "13:50"),
				 new Slot(9, "13:50", "14:15"),
				 new Slot(10, "14:30", "14:55"),
				 new Slot(11, "14:55", "15:25")]
	}	
	
	static Schedule findByDateAndUser(Date date, ApplicationUser user) {
		Calendar dateCalendar = new GregorianCalendar(date.getAt(Calendar.YEAR), date.getAt(Calendar.MONTH), date.getAt(Calendar.DAY_OF_MONTH)) 
		Calendar firstOfJuly = new GregorianCalendar(date.getAt(Calendar.YEAR), Calendar.JULY, 1)
		Calendar lastOfAugust = new GregorianCalendar(date.getAt(Calendar.YEAR), Calendar.AUGUST, 31)
		if (dateCalendar.before(firstOfJuly)) {
			Schedule.findByBeginYearAndUser(dateCalendar.get(Calendar.YEAR)-1, user) 
		} else if (dateCalendar.after(lastOfAugust)) {
			Schedule.findByBeginYearAndUser(dateCalendar.get(Calendar.YEAR), user)
		} else {
			null
		}
	}
	
	ScheduleDay getDay(int dayOfWeek) {
		days.find({ it.dayOfWeek == dayOfWeek })
	}
	
	Schoolday createSchoolday(Date date) {
		if (!isDateInSchedule(date)) {
			throw new InvalidScheduleException("This schedule does not apply to this date.")
		}
		new Schoolday(date, this)
	}
	
	private boolean isDateInSchedule(Date date) {
		Calendar dateCalendar = new GregorianCalendar(date.getAt(Calendar.YEAR), date.getAt(Calendar.MONTH), date.getAt(Calendar.DAY_OF_MONTH))
		Calendar firstOfJuly = new GregorianCalendar(date.getAt(Calendar.YEAR), Calendar.JULY, 1)
		Calendar lastOfAugust = new GregorianCalendar(date.getAt(Calendar.YEAR), Calendar.AUGUST, 31)
		(dateCalendar.before(firstOfJuly) && beginYear == (dateCalendar.get(Calendar.YEAR) -1)) || 
		(dateCalendar.after(lastOfAugust)  && beginYear == dateCalendar.get(Calendar.YEAR))
	}
	
	String getSchoolyear() {
		"${beginYear}-${beginYear+1}" 
	}
	
	Schedule findScheduleByDateAndUser() {
		Schedule.findByBeginYearAndUser(AgendaUtils.beginYearForDate(date), user)
	}
	
	Slot findSlotByDayAndIndex(int dayOfWeek, int slotIndex) {
		def day = days.find { day.dayOfWeek == dayOfWeek }
		day.hours.find { it.beginSlot.slotIndex <= slotIndex && it.endSlot.slotIndex >=  slot.slotIndex}
	}
	
	static Schedule current(ApplicationUser user) {
		Schedule.findByDateAndUser(new GregorianCalendar().getTime(), user)
	}
	
	static Schedule mostRecent(ApplicationUser user) {
		def result = Schedule.findAllByUser(user, [sort: "beginYear", order: "desc"])
		if (result) {
			result[0]	
		} else {
			null
		}
	}
}
