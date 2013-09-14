package be.agenda.services

import be.agenda.domain.Course
import be.agenda.domain.CoursePart

class CourseService {

    Course addCoursePartToCourse(Course course, CoursePart coursePart) {
		course = course.addToCourseParts(coursePart);
		course.save()
    }
}
