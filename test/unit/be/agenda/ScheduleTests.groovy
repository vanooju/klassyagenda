package be.agenda

import static org.junit.Assert.*

import grails.test.mixin.*
import grails.test.mixin.support.*
import org.junit.*

import be.agenda.domain.ApplicationUser;
import be.agenda.domain.Schedule;
import be.agenda.domain.ScheduleDay;
import be.agenda.domain.ScheduleHour;
import be.agenda.domain.Slot;

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
@Mock([ApplicationUser,Slot, ScheduleDay])
class ScheduleTests {

	def user
	
	@Before
    void setUp() {
		user = new ApplicationUser(username: 'johndoe', password: 'p4ssw0rd', firstName: 'John', lastName: 'Doe')
		def springSecurityService = new Object()
		springSecurityService.metaClass.encodePassword = { password -> "encoded" }
		user.springSecurityService = springSecurityService
		user.save(flush:true, failOnError:true)
    }

	@After
    void tearDown() {
        user.delete()
    }

    void testCreatingAndSavingANewSchedule() {
        Schedule schedule = new Schedule(2012, user)
		
		assertNull schedule.id
		assertEquals 12, schedule.slots.size()
		assertEquals 5, schedule.days.size()
		
		schedule.save(flush:true, failOnError:true)
		
		assertEquals 1, Schedule.count()
		
		schedule = Schedule.get(schedule.id)
		
		assertNotNull schedule
		assertNotNull schedule.id
		assertEquals 12, schedule.slots.size()
		assertEquals 5, schedule.days.size()
		
		schedule.days.each {
			assertNotNull it.id
		}
		
		schedule.slots.each {
			assertNotNull it.id
		}
		
		assertNotNull schedule.days[(Calendar.MONDAY)]
    }
	
	void testAvailableSlots() {
		Schedule schedule = new Schedule(2012, user)
		def day = schedule.days[Calendar.MONDAY]
		assertNotNull day.availableSlots()
		assertEquals 12, day.availableSlots().size()
	}
	
	void testAvailableSlotsAfterBookingTheFirstHour() {
		Schedule schedule = new Schedule(2012, user)
		def day = schedule.days[Calendar.MONDAY]
		
		assertEquals 12, day.availableSlots().size()
		def beginSlot = day.availableSlots()[0]
		assertEquals 3, day.appropriateEndSlotsFor(beginSlot).size()
		
		def endSlot = day.appropriateEndSlotsFor(beginSlot)[0]
		
		day.addToHours(new ScheduleHour(beginSlot: beginSlot, endSlot: endSlot))
		
		assertEquals 11, day.availableSlots().size()
		assertEquals 2, day.appropriateEndSlotsFor(day.availableSlots()[0]).size()
	}
	
	void testAvailableSlotsAfterBookingTwoSlotsAtOnce() {
		Schedule schedule = new Schedule(2012, user)
		def day = schedule.days[Calendar.MONDAY]
		
		assertEquals 12, day.availableSlots().size()
		def beginSlot = day.availableSlots()[0]
		assertEquals 3, day.appropriateEndSlotsFor(beginSlot).size()
		
		def endSlot = day.appropriateEndSlotsFor(beginSlot)[1]
		
		day.addToHours(new ScheduleHour(beginSlot: beginSlot, endSlot: endSlot))
		
		assertEquals 10, day.availableSlots().size()
		assertEquals 1, day.appropriateEndSlotsFor(day.availableSlots()[0]).size()
	}
	
	void testAppropriateEndSlotsFor() {
		Schedule schedule = new Schedule(2012, user)
		def day = schedule.days.grep( { it.dayOfWeek == Calendar.MONDAY } )[0]
		def slot = day.availableSlots(null)[0]  
		//def slot = day.availableSlots()[0]
		def endSlots = day.appropriateEndSlotsFor(slot)
		assertNotNull endSlots
		assertEquals 3, endSlots.size()
		
		day.addToHours(new ScheduleHour(beginSlot: slot, endSlot: endSlots[0]))
	}
	
	void testCreateSchooldayForSchedule() {
		Schedule schedule = new Schedule(2012, user)
		def schoolday = schedule.createSchoolday(new Date())
		assertEquals new Date().clearTime(), schoolday.date
		assertEquals schedule, schoolday.schedule
		assertEquals 0, schoolday.hours.size()
	}
	
	
}
