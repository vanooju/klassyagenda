package be.agenda

import static org.junit.Assert.*

import grails.test.mixin.*
import grails.test.mixin.support.*
import org.junit.*

import be.agenda.domain.Schedule;
import be.agenda.domain.ScheduleDay;
import be.agenda.domain.ScheduleHour;

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
@Mock(ScheduleDay)
class ScheduleHourTests {

    void setUp() {
        // Setup logic here
    }

    void tearDown() {
        // Tear down logic here
    }

    void testInitializeNewScheduleHourWithSlots() {
		Schedule schedule = new Schedule(2012,null)
		ScheduleDay day = new ScheduleDay(schedule)
        ScheduleHour hour = new ScheduleHour(day)
		assertNotNull hour.beginSlot
		assertNotNull hour.endSlot
    }
	
	void testAvailableSlotsForOneHour() {
		Schedule schedule = new Schedule(2012,null)
		ScheduleDay day = new ScheduleDay(schedule)
        ScheduleHour hour = new ScheduleHour(day)
		assertEquals 12, day.availableSlots().size()
		day.addToHours(hour)
		assertEquals 1, day.hours.size()
	}
	
	void testAvailableSlotsForSecondHour() {
		Schedule schedule = new Schedule(2012,null)
		ScheduleDay day = new ScheduleDay(schedule)
        ScheduleHour firstHour = new ScheduleHour(day)
		day.addToHours(firstHour)
        ScheduleHour secondHour = new ScheduleHour(day)
		assertEquals 11, day.availableSlots().size()
		day.addToHours(secondHour)
		assertEquals 2, day.hours.size()
	}
	
	void testAvailableSlotsForOneHourCoveringThreeSlots() {
		Schedule schedule = new Schedule(2012,null)
		ScheduleDay day = new ScheduleDay(schedule)
        ScheduleHour firstHour = new ScheduleHour(day)
		firstHour.endSlot = day.appropriateEndSlotsFor(firstHour)[2]
		assertEquals '8:30', firstHour.beginSlot.beginHour
		assertEquals '9:45', firstHour.endSlot.endHour
		day.addToHours(firstHour)
        ScheduleHour secondHour = new ScheduleHour(day)
		assertEquals 9, day.availableSlots().size()
		assertEquals '10:00', secondHour.beginSlot.beginHour
		assertEquals '10:25', secondHour.endSlot.endHour
		day.addToHours(secondHour)
		assertEquals 2, day.hours.size()
	}
}
