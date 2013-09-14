package be.agenda.commands

import grails.validation.Validateable
import be.agenda.domain.Course
import be.agenda.domain.CoursePart

@Validateable
class AddCoursePartToCourseCommand {
	Course course
	String name
}
