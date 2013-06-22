import grails.util.Environment;
import be.agenda.domain.ApplicationUser
import be.agenda.domain.ApplicationUserRole
import be.agenda.domain.Course
import be.agenda.domain.CoursePart
import be.agenda.domain.Role
import be.agenda.domain.School
import be.agenda.domain.Schoolday

class BootStrap {

	def init = { servletContext ->
		if (Environment.current == Environment.DEVELOPMENT) {
			def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
			def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

			def school = new School(name: 'Sint-Romboutscollege').save(flush: true)

			def josUser = new ApplicationUser(username: 'jos', enabled: true, password: 'jos', firstName: 'Jos', lastName: 'Peeters', school: school)
			def miekeUser = new ApplicationUser(username: 'mieke', enabled: true, password: 'mieke', firstName: 'Mieke', lastName: 'Jansens', school: school)
			josUser.save(flush: true)
			miekeUser.save(flush: true)

			ApplicationUserRole.create josUser, adminRole, true
			ApplicationUserRole.create miekeUser, userRole, true

			def course = new Course(name: 'Wiskunde', user: josUser)
			course.addToCourseParts(new CoursePart(name: 'Getallenkennis'))
			course.save(flush: true)

			def course2 = new Course(name: 'Turnen', user: miekeUser)
			course2.addToCourseParts(new CoursePart(name: 'Turnen'))
			course2.save(flush: true)

			assert ApplicationUser.count() == 2
			assert Role.count() == 2
			assert ApplicationUserRole.count() == 2
			assert Course.count() == 2

			//
		}
		def originalMapConstructor = Schoolday.metaClass.retrieveConstructor(Map)

		Schoolday.metaClass.constructor = { Map m ->
			def instance = originalMapConstructor.newInstance(m)
			instance.initHours()
			instance
		}
	}
	def destroy = {
	}
}
