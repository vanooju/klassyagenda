package be.agenda.services



import grails.test.mixin.*

import org.junit.*

import be.agenda.ApplicationUser
import be.agenda.Schedule

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(ScheduleService)
@Mock(Schedule)
class ScheduleServiceTests {

    void testCreateSchedule() {
        def schedule = service.createSchedule(2012, new ApplicationUser(), 1)
		schedule = schedule.save(flush:true)
		assertNotNull schedule
		assertNotNull "Days should not be null after creating the schedule", schedule.days
		assertNotNull "Slots should not be null after creating the schedule", schedule.slots
    }
}
