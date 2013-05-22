package be.agenda

import org.compass.core.CompassQuery

class LessonController {
	
	def searchableService

    def search() {
		flash.clear()
		def selectedCourse = null 
		if ('null' != params.course?.id) {
			selectedCourse = params.course?.id ? Course.get(params.course.id) : null
		}
		
		def selectedCoursePart = null
		if ('null' != params.coursePart?.id) {
			selectedCoursePart = params.coursePart?.id ? CoursePart.get(params.coursePart.id) : null
		}
		
		def selectedSchedule = null;
		if ('null' != params.selectedSchedule) {
			selectedSchedule = params.selectedSchedule ? Schedule.get(params.selectedSchedule) : null
		}
		
		if (request.method == 'GET') {
			log.info("Showing lesson search form.")
			[	
				selectedCourse: selectedCourse, 
				selectedCoursePart: selectedCoursePart,
				subject: params.subject,
				selectedDate: params.selectedDate,
				selectedSchedule: selectedSchedule?.id,
				hourIndex: params.hourIndex,
				hourId: params.hourId,
				beginSlot: params.beginSlot,
				endSlot: params.endSlot
			]
		} else {
			/*if (selectedCoursePart == null) {
				flash.error = 'Selecteer een vak en een vakonderdeel.'
				return [selectedCourse:selectedCourse, selectedCoursePart:selectedCoursePart, courseParts: (selectedCourse != null ? selectedCourse.courseParts : null)]
			}*/
		
			log.info("Doing actual Lesson.search() for ${params.subject}")
			/*if (!params.subject?.trim()) {
				return [:]
			}*/
			def searchResult = null
			params.reload = true
			params.max = 1000
			params.sort = '$/LessonHour/schoolday/id'
			params.order = "desc"
			println "schedule: ${selectedSchedule?.id}"
			searchResult = LessonHour.search({
				if (selectedSchedule) { must(term('$/LessonHour/schoolday/schedule/id', selectedSchedule?.id)) }
				if (selectedCourse) { must(term('$/LessonHour/course/id', selectedCourse?.id)) }
				if (selectedCoursePart) { must(term('$/LessonHour/coursePart/id', selectedCoursePart?.id)) }
				if (params.subject) { must(queryString("\"${params.subject}\"")) }
			}, params)
			log.info("Number of resuls from search: ${searchResult.results.size()}")
						
			[
				selectedCourse: selectedCourse,
				//courses: Course.findAll(),
				//courseParts: (selectedCourse != null ? selectedCourse.courseParts : null),
				selectedCoursePart: selectedCoursePart,
				subject: params.subject, 
				searchResult: searchResult,
				selectedDate: params.selectedDate,
				selectedSchedule: selectedSchedule?.id,
				hourIndex: params.hourIndex,
				hourId: params.hourId,
				beginSlot: params.beginSlot,
				endSlot: params.endSlot
			]
		}
	}
	
	def searchModal() {
		println("SearchModal - params: ${params}")
		def model = search()
		if (request.method == 'POST') {
			render(template: 'searchModalResults', model: model)
		} else if (request.method == 'GET') {
			render(template: 'searchModalForm', model: model)
		}
	}
	
	def show() {
		LessonHour lessonHour = LessonHour.get(params.id)
		render(template:'/schoolday/hourDetails', bean: lessonHour)	
	}
	
	def showModal() {
		println("ShowModal - Params: ${params}")
		def model = [:]
		LessonHour lessonHour = LessonHour.get(params.id)
		if (params.course?.id) {
			model.selectedCourse = Course.get(params.course?.id)
		}
		if (params.coursePart?.id) {
			model.selectedCoursePart = CoursePart.get(params.coursePart?.id)
		}
		model.selectedDate = params.selectedDate
		model.subject = params.subject
		if (params.hourIndex) {
		model.hourIndex = params.hourIndex
		}
		if (params.hourIndex) {
			model.hourId = params.hourId
		}
		render(template:'/lesson/hourDetailsModal', bean: lessonHour, model: model)	
	}
}
