package be.agenda

import static org.junit.Assert.*

import grails.test.mixin.*
import grails.test.mixin.support.*
import org.junit.*

import be.agenda.domain.ApplicationUser;
import be.agenda.domain.Course;
import be.agenda.domain.LessonHour;
import be.agenda.domain.Schedule;
import be.agenda.domain.ScheduleDay;
import be.agenda.domain.ScheduleHour;
import be.agenda.domain.Schoolday;

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
@Mock([ApplicationUser,Schoolday,LessonHour,Schedule, Course,ScheduleDay])
class SchooldayTests {

	Date firstSchoolday = new GregorianCalendar(2012, Calendar.SEPTEMBER, 3).getTime() //monday
	def user
	def schoolday
	def schedule

	@Before
	public void setup() {
		def originalMapConstructor = Schoolday.metaClass.retrieveConstructor(Map)

		Schoolday.metaClass.constructor = { Map m ->
			def instance = originalMapConstructor.newInstance(m)
			instance.initHours()
			instance
		}

		user = new ApplicationUser(username: 'test', password: 'p4ssw0rd')
		user.save(flush: true)
		schedule = new Schedule(2012, user)
		schedule.save(flush:true)
		def wiskunde = new Course(name: 'Wiskunde')
		def nederlands = new Course(name: 'Wiskunde')
		wiskunde.save()
		nederlands.save()
		def monday = schedule.days[0]
		monday.addToHours(new ScheduleHour(beginSlot:schedule.slots[0], endSlot:schedule.slots[0], course:wiskunde));
		monday.addToHours(new ScheduleHour(beginSlot:schedule.slots[2], endSlot:schedule.slots[2], course:nederlands));
		monday.save()

		schoolday = new Schoolday(date:firstSchoolday, user:user)
		schoolday.save(flush:true)
	}

	void testCreateALessonHourForASchoolday() {
		def user = new ApplicationUser(username: 'test', password: 'p4ssw0rd')
		user.save(flush: true)
		def today = new Date()
		def schoolday = new Schoolday(date:firstSchoolday, user:user)
		schoolday.save(flush:true)
		def lessonHour = new LessonHour(schoolday:schoolday)
		lessonHour.save(flush:true)
		assertNotNull lessonHour.schoolday.date
	}

	void testAvailableSlotsForNewSchoolday() {
		assertNotNull schoolday.availableSlots
		assertEquals 10, schoolday.availableSlots.size()
	}

	void testAvailableSlotsAfterAddingLessonHour() {
		assertNotNull schoolday.availableSlots
		assertEquals 10, schoolday.availableSlots.size()
	}
}
