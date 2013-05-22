package be.agenda

import org.springframework.dao.DataIntegrityViolationException

class CourseController {

	static defaultAction = "list"
	
    def list() { 
		def courses = Course.findAllByUser(session.user, [sort: 'name'])
		[courses:courses, params:params]	
	}
	
	def create() {
		[courseInstance:new Course(params)]
	}
	
	def save() {
		def courseInstance = new Course(params)
		courseInstance.user = session.user
		if (!courseInstance.save(flush:true)) {
			render(view: "create", model: [courseInstance: courseInstance])
			return
		}
		
		flash.message = message(code: 'default.created.message', args: [message(code: 'course.label', default: 'Vak'), courseInstance.name])
		flash.courseId = courseInstance.id
		redirect(action: 'list')
	}
	
	def show(Long id) {
		def courseInstance = Course.get(id)
		if (!courseInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Vak'), id])
			redirect(action: 'list')
			return
		}
		
		[courseInstance: courseInstance]
	}
	
	def edit(Long id) {
		def courseInstance = Course.get(id)
		if (!courseInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Vak'), id])
			redirect(action: 'list')
			return
		}
		
		[courseInstance: courseInstance]
	}
	
	def update(Long id, Long version) {
		def courseInstance = Course.get(id)
		if (!courseInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Vak'), id])
			redirect(action: 'list')
			return
		}
		
		if (version != null) {
			if (courseInstance.version > version) {
				courseInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
					[message(code: 'course.label', default: 'Course')] as Object[],
					"Another user has updated this Course while you were editing")
				render(view: 'edit', model: [courseInstance: courseInstance])
				return
			}
		}
		
		courseInstance.properties = params
		
		if (!courseInstance.validate()) {
			render(view: 'edit', model: [courseInstance: courseInstance])
			return
		}
		
		if (!courseInstance.save(flush:true)) {
			render(view: 'edit', model: [courseInstance: courseInstance])
			return
		}
		
		flash.message = message(code: 'default.updated.message', args: [message(code: 'course.label', default: 'Vak'), courseInstance.name])
		flash.courseId = courseInstance.id
		redirect(action: 'list', id: courseInstance.id)
	}
	
	def delete(Long id) {
		def courseInstance = Course.get(id)
		if (!courseInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Course'), id])
			redirect(action: "list")
			return
		}
		
		try {
			courseInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'course.label', default: 'Course'), id])
			redirect(action: "list")
		} catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'course.label', default: 'Course'), id])
			redirect(action: "show", id: id)
		}
	}
	
	def saveCoursePart() {
		def coursePartInstance = new CoursePart(params)
		def course = Course.get(params.course.id)
		course.addToCourseParts(coursePartInstance)
		course.save()
		redirect(action: "list")
	}
	
	def editCoursePart(Long id) {
		def coursePartInstance = CoursePart.get(id)
		[coursePartInstance: coursePartInstance]
	}
	
	def updateCoursePart(Long id, Long version) {
		def coursePartInstance = CoursePart.get(id)
		coursePartInstance.properties = params
		
		if (version != null) {
			if (coursePartInstance.version > version) {
				coursePartInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
					[message(code: 'course.label', default: 'Course')] as Object[],
					"Another user has updated this CoursePart while you were editing")
				render(view: 'editCoursePart', model: [coursePartInstance: coursePartInstance])
				return
			}
		}
		
		coursePartInstance.save()
		redirect(action: "edit", id: coursePartInstance.course.id)
	}
	
	def showCourseModalForm() {
		render(template: 'courseModalForm')
	}
	
	def addCourse() {
		def course = new Course(params)
		course.user = session.user
		if (!course.save(flush:true)) {
			render(status: 409, template: 'form', bean: course)
			return
		}
		
		render g.select(optionKey:'id', optionValue:'name', from: Course.findAllByUser(session.user, [sort: 'name']),
					    name: 'course.id', id: 'course', noSelection: ['null':'-Kies een vak-'], value: course.id)
	}
}
