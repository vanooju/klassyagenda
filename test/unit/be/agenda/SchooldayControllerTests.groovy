package be.agenda

import static org.junit.Assert.*
import grails.test.mixin.*
import grails.test.mixin.domain.DomainClassUnitTestMixin
import grails.test.mixin.support.*

import org.junit.*

import be.agenda.controllers.SchooldayController;
import be.agenda.domain.ApplicationUser;
import be.agenda.domain.Course;
import be.agenda.domain.CoursePart;
import be.agenda.domain.Hour;
import be.agenda.domain.LessonHour;
import be.agenda.domain.Schoolday;
import be.agenda.domain.Slot;

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestFor(SchooldayController)
@Mock([LessonHour, Schoolday, Course, CoursePart, Slot, Schoolday, Hour])
@TestMixin(DomainClassUnitTestMixin)
class SchooldayControllerTests {

    void testCreateLessonHourForSchooldayThatDoesNotExist() {
		controller.session.user = new ApplicationUser(username:'test')
        def result = controller.createLessonHour(new Date().clearTime())
		assertNotNull result['hourInstance']
    }

    void testShowSchooldayForSpecificDate() {
		controller.session.user = new ApplicationUser(username:'test')
		controller.params.date = new GregorianCalendar(2012, Calendar.SEPTEMBER, 1).getTime()
        def result = controller.show()
		assertNotNull result['schooldayInstance']
    }
	
	void testEditLessonHour() {
		controller.session.user = new ApplicationUser(username: 'test');
		
        def slot = new Slot(0, '8:30', '8:55')
		slot.save()
		def course = new Course(name: 'Wiskunde')
		course.save()
		def coursePart = new CoursePart(course: course, name: 'Hoofdrekenen')
		coursePart.save()
		def schoolday = new Schoolday(date: new Date())
		schoolday.save()
		
		def lessonHour = new LessonHour(id: 1, descriptionBegin: '', descriptionMiddle: '', descriptionEnd: '', media: '', objectives: '', schoolday: schoolday, beginSlot: slot, endSlot: slot, course: coursePart.course, coursePart: coursePart, subject: 'Leren hoofdrekenen')
		
		mockDomain(Hour, [lessonHour])
		
		controller.edit(lessonHour.id)
	}			
}
