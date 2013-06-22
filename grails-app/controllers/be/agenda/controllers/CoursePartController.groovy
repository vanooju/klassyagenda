package be.agenda.controllers

import org.springframework.dao.DataIntegrityViolationException

import be.agenda.domain.Course
import be.agenda.domain.CoursePart

class CoursePartController {
	
	static layout = 'course'
	
	def create() {
		def coursePartInstance = new CoursePart(params)
		
		[coursePartInstance: coursePartInstance]
	}
    
	def save() {
        def coursePartInstance = new CoursePart(params)
        if (!coursePartInstance.save(flush: true)) {
            render(view: "create", model: [coursePartInstance: coursePartInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'coursePart.label', default: 'Vakonderdeel'), coursePartInstance.name])
		flash.coursePartId = coursePartInstance.id
        redirect(action: "list", controller: "coursePart", id: coursePartInstance.course.id)
    }

    def show(Long id) {
        def coursePartInstance = CoursePart.get(id)
        if (!coursePartInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'coursePart.label', default: 'CoursePart'), id])
            redirect(action: "list")
            return
        }

        [coursePartInstance: coursePartInstance]
    }

    def edit(Long id) {
        def coursePartInstance = CoursePart.get(id)
        if (!coursePartInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'coursePart.label', default: 'CoursePart'), id])
            redirect(action: "list")
            return
        }

        [coursePartInstance: coursePartInstance]
    }

    def update(Long id, Long version) {
        def coursePartInstance = CoursePart.get(id)
        if (!coursePartInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'coursePart.label', default: 'CoursePart'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (coursePartInstance.version > version) {
                coursePartInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'coursePart.label', default: 'CoursePart')] as Object[],
                          "Another user has updated this CoursePart while you were editing")
                render(view: "edit", model: [coursePartInstance: coursePartInstance])
                return
            }
        }

        coursePartInstance.properties = params

        if (!coursePartInstance.save(flush: true)) {
            render(view: "edit", model: [coursePartInstance: coursePartInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'coursePart.label', default: 'Vakonderdeel'), coursePartInstance.name])
		flash.coursePartId = coursePartInstance.id
        redirect(action: "list", controller: "coursePart", id: coursePartInstance.course.id)
    }

    def delete(Long id) {
        def coursePartInstance = CoursePart.get(id)
        if (!coursePartInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'coursePart.label', default: 'CoursePart'), id])
            redirect(action: "list")
            return
        }

        try {
            coursePartInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'coursePart.label', default: 'CoursePart'), id])
            redirect(action: "list", controller: "course")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'coursePart.label', default: 'CoursePart'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def list(Long id) {
		def course = Course.get(id)
		[courseParts: CoursePart.findAllByCourse(course, params), courseInstance: course]
	}
	
	def isCoursePartGivenByOtherTeacher() {
		def returnValue = CoursePart.get(params.coursePartId).otherTeacher
		println "Returnvalue: " + returnValue
		render returnValue as String
	}
}
