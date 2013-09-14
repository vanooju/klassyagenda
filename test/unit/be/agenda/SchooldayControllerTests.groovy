package be.agenda

import static org.junit.Assert.*
import grails.test.mixin.*
import grails.test.mixin.domain.DomainClassUnitTestMixin;
import grails.test.mixin.support.*

import org.junit.*

import be.agenda.controllers.SchooldayController
import be.agenda.domain.ApplicationUser
import be.agenda.domain.Course
import be.agenda.domain.CoursePart
import be.agenda.domain.Hour
import be.agenda.domain.LessonHour
import be.agenda.domain.Schedule
import be.agenda.domain.Schoolday
import be.agenda.domain.Slot

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestFor(SchooldayController)
@Mock([Schoolday])
@TestMixin(DomainClassUnitTestMixin)
class SchooldayControllerTests {
	
	public void testCopyIntoNewLesson() {
		def user = new ApplicationUser()
		def schedule = new Schedule(2013, user)
		def date = new GregorianCalendar(2013, Calendar.SEPTEMBER, 2).clearTime().getTime()
		
		new Schoolday(date:date, user:user, schedule: schedule).save(failOnError: true)
		
		mockDomain(ApplicationUser, [[firstName: 'Jos', lastName: 'Vermeulen', username: 'jos', password: 'password', emailAddress: 'jos@vermeulen.be']])
		mockDomain(Schedule, [[beginYear: 2013, user: user]])
		mockDomain(Schoolday, [[date: date, user: user]])
		mockDomain(LessonHour, [[id: 1]])
		
		session.user = user
		params.date = date
		
		controller.copyLessonIntoNew(1)
	}
    
}
