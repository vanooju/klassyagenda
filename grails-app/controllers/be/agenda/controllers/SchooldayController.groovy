package be.agenda.controllers

import org.springframework.dao.DataIntegrityViolationException

import be.agenda.AgendaUtils
import be.agenda.commands.AddCoursePartToCourseCommand
import be.agenda.commands.UpdateEndSlotCommand
import be.agenda.domain.ActivityHour
import be.agenda.domain.ApplicationUser
import be.agenda.domain.Course
import be.agenda.domain.CoursePart
import be.agenda.domain.Hour
import be.agenda.domain.LessonHour
import be.agenda.domain.LessonPlaceHolderHour
import be.agenda.domain.Schedule
import be.agenda.domain.Schoolday
import be.agenda.services.CourseService

class SchooldayController {
	
	def CourseService courseService
	
	static defaultAction = 'show'
	
	static allowedMethods = [save: 'POST']

    def save() {
		def date = params.date
		def hour = null
		def schooldayInstance = Schoolday.findByDateAndUser(date, session.user)
		
		if (params.cancel) {
			redirect(action: "show", params: [date:'date.struct', date_day: date.format("dd"), date_month: date.format("MM"), date_year: date.format("yyyy")])
			return
		}
		
		if (!schooldayInstance) {
			schooldayInstance = new Schoolday(date:date, user:session.user, schedule: Schedule.findByDateAndUser(date, session.user))
		}

		if (params.hourIndex) {
			def placeholder = schooldayInstance.hours.find{ it.beginSlot.slotIndex == params.int('hourIndex') }
			hour = new LessonHour(placeholder.properties + params)
			
			if (!hour.validate()) {
				render(view: "create", model: [hourInstance: hour, hourIndex: params.hourIndex, selectedDate: date, selectedUser: session.user])
				return
			}
			
			log.debug "Replacing placeholder ${placeholder} with hour ${hour}"
			log.debug "${schooldayInstance.hours.size()} hours before removing placeholder"
			schooldayInstance.removeFromHours(placeholder)
			log.debug "${schooldayInstance.hours.size()} hours after removing placeholder"
			schooldayInstance.addToHours(hour)
			log.debug "${schooldayInstance.hours.size()} hours after adding actual hour"
			schooldayInstance.save(flush:true)
		} else {	
			if ("lesson".equals(params.type)) {
				hour = new LessonHour(params)
			} else if ("activity".equals(params.type)) {
				hour = new ActivityHour(params)
			}
			hour.schoolday = schooldayInstance
			
			if (!hour.validate()) {
				render(view: "create", model: [hourInstance: hour])
				return
			}
			
			schooldayInstance.addToHours(hour)
			schooldayInstance.save(flush:true)
		}

        flash.message = message(code: 'lesson.created.message', args: [hour.title, hour.beginHour, hour.endHour])
		flash.date = schooldayInstance.date
        redirect(action: "show")
    }

    def show() {
		println "params.date = ${params.date}"
		println "session.date = ${session.date}"
		println session.date
		def date = params.date ?: session.date
		if (!date) {
			def calendar = new GregorianCalendar()
			if (calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
				calendar.set(Calendar.WEEK_OF_YEAR, calendar.get(Calendar.WEEK_OF_YEAR) + 1)
				calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY)
			}
			date = calendar.getTime().clearTime()
		}
		
		def selectedUser = session.user
		def userId = params.userid
		if (userId) {
			selectedUser = ApplicationUser.get(userId)
		} else {
			selectedUser = ApplicationUser.get(session.user.id)
		}
		
		date = AgendaUtils.firstSchooldayAfter(date)
        def schooldayInstance = Schoolday.findByUserAndDate(selectedUser, date)
        if (!schooldayInstance) {
			if (selectedUser == session.user) {
				schooldayInstance = new Schoolday(date:date, user:session.user, schedule: Schedule.findByDateAndUser(date, session.user))
				if (schooldayInstance.schedule == null) {
					return [selectedDate: date, selectedUser: selectedUser]
				}
				def scheduleDay = schooldayInstance.schedule.getDay(schooldayInstance.dayOfWeek)
				scheduleDay.hours.toList().each {
					schooldayInstance.addToHours(new LessonPlaceHolderHour(it, schooldayInstance))
				}
			} else {
				flash.message = "${selectedUser.firstName} ${selectedUser.lastName} heeft voor deze dag geen agenda ingevuld."
			}
        } 
			
		session.date = date
        [schooldayInstance: schooldayInstance, selectedDate: date, selectedUser: selectedUser]
    }

    def edit(Long id) {
		def hourInstance = Hour.get(id)
		
		if (hourInstance instanceof LessonPlaceHolderHour && !(hourInstance instanceof LessonHour)) {
			def lessonHour = new LessonHour(hourInstance.properties)
			lessonHour.id = hourInstance.id
			hourInstance = lessonHour
		}
		
		[hourInstance: hourInstance, selectedDate: hourInstance.schoolday.date]
    }
	
	private LessonHour copyIntoHour(LessonHour hourInstance, Long originalId) {
		def original = LessonHour.get(originalId)
		hourInstance.course = original.course
		hourInstance.coursePart = original.coursePart
		hourInstance.subject = original.subject
		hourInstance.media = original.media
		hourInstance.descriptionBegin = original.descriptionBegin
		hourInstance.descriptionMiddle = original.descriptionMiddle
		hourInstance.descriptionEnd = original.descriptionEnd
		hourInstance.objectives = original.objectives
		
		hourInstance
	}

    def update(Long id, Long version) {
		def hourInstance = Hour.get(id) 
		
		if (params.cancel) {
			redirect(action: "show", params: [date:'date.struct', date_day: hourInstance.schoolday.date.format("dd"), date_month: hourInstance.schoolday.date.format("MM"), date_year: hourInstance.schoolday.date.format("yyyy")])
			return
		}
		
        if (!hourInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'hour.label', default: 'Hour'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (hourInstance.version > version) {
                hourInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'hour.label', default: 'Hour')] as Object[],
                          "Another user has updated this Hour while you were editing")
				render(view: "edit", model: [hourInstance: hourInstance])
                return
            }
        }
		
		def hourId = hourInstance.id
		def schoolday = hourInstance.schoolday
		
		if (hourInstance instanceof LessonPlaceHolderHour && !(hourInstance instanceof LessonHour)) {
			schoolday.removeFromHours(hourInstance)
			hourInstance = new LessonHour(params)
			schoolday.addToHours(hourInstance)
		}
		
		hourInstance.properties = params
		
		if (!hourInstance.validate()) {
			if (hourId) hourInstance.id = id
			render(view: "edit", model: [hourInstance: hourInstance, selectedDate: hourInstance.schoolday.date])
			return
		}

        schoolday.save()

		flash.message = message(code: 'lesson.updated.message', args: [hourInstance.title, hourInstance.beginHour, hourInstance.endHour])
        redirect(action: "show", params: [date:'date.struct', date_day: hourInstance.schoolday.date.format("dd"), date_month: hourInstance.schoolday.date.format("MM"), date_year: hourInstance.schoolday.date.format("yyyy")])
    }

    def delete() {
		def hourInstance = null
		def schoolday = null
		if (params.hourId) {
	        hourInstance = Hour.get(params.hourId)
			if (!hourInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'hour.label', default: 'Hour'), params.hourId])
	            redirect(action: "list")
	            return
	        }
			schoolday = hourInstance.schoolday
		} else {
			def date = params.date_delete
			def user = session.user
			schoolday =	Schoolday.findByDateAndUser(params.date_delete, session.user)?: createSchoolday(params.date_delete, session.user)
			hourInstance = schoolday.hours.find{ it.beginSlot.slotIndex == params.int('hourIndex') }
		}

        try {
            //hourInstance.delete(flush: true)
			schoolday.removeFromHours(hourInstance)
			schoolday.save()
			redirect(action: "show", params: [date:'date.struct', date_day: schoolday.date.format("dd"), date_month: schoolday.date.format("MM"), date_year: schoolday.date.format("yyyy")])
        } catch (DataIntegrityViolationException e) {
            redirect(action: "show", params: [date:'date.struct', date_day: schoolday.date.format("dd"), date_month: schoolday.date.format("MM"), date_year: schoolday.date.format("yyyy")])
        }
    }
	
	def changeDay() {
		def date = params.date
		
		def schooldayInstance = Schoolday.findByDateAndUser(date,session.user)
        if (!schooldayInstance) {
			schooldayInstance = createSchoolday(date, session.user)
        }
		
		render(template:'hours', model:[schooldayInstance: schooldayInstance])
	}

	private Schoolday createSchoolday(Date date, ApplicationUser user) {
		log.info "Nieuwe schooldag voor gebruiker ${user} en datum ${date}"
		def schooldayInstance = new Schoolday(date:date, user:user, schedule: Schedule.findByDateAndUser(date, user))
		def scheduleDay = schooldayInstance.schedule?.getDay(schooldayInstance.dayOfWeek)
		scheduleDay?.hours.toList().each {
			schooldayInstance.addToHours(new LessonPlaceHolderHour(it, schooldayInstance))
		}
		return schooldayInstance
	}
	
	def create() {
		def date = params.date ?: new Date()
		def schoolday = Schoolday.findByDateAndUser(date, session.user) ?: createSchoolday(date, session.user)
		def hourInstance = null
		def hourIndex = null
		if ('lesson'.equals(params.type)) {
			log.debug "Nieuw lesuur aanmaken voor schooldag ${schoolday} van ${schoolday.availableSlots?.first().beginHour} tot ${schoolday.availableSlots?.first().endHour}."
			hourInstance = new LessonHour(schoolday: schoolday, beginSlot: schoolday.availableSlots?.first(), endSlot: schoolday.availableSlots?.first())
		} else if ('activity'.equals(params.type)) {
		log.debug "Nieuwe activiteit aanmaken voor schooldag ${schoolday} van ${schoolday.availableSlots?.first().beginHour} tot ${schoolday.availableSlots?.first().endHour}."
			hourInstance = new ActivityHour(schoolday: schoolday,, beginSlot: schoolday.availableSlots?.first(), endSlot: schoolday.availableSlots?.first())
		} else {
		log.debug "Nieuw lesuur aanmaken voor schooldag ${schoolday} op basis van uur in lessenrooster ${schoolday.hours.find{it.beginSlot.slotIndex == hourIndex }}."
			hourIndex = params.int('hourIndex')
			hourInstance = new LessonHour(schoolday.hours.find{it.beginSlot.slotIndex == hourIndex }.properties)
		}
		render(view: "create", model: [hourInstance: hourInstance, hourIndex:params.hourIndex, selectedDate: date, selectedUser: session.user])
	}
	
	def copyLessonIntoNew(Long id) {
		def date = params.date ?: new Date()
		def hourIndex = params.int('hourIndex')
		def schoolday = Schoolday.findByDateAndUser(date, session.user) ?: createSchoolday(date, session.user)
		def hourInstance = new LessonHour(schoolday: schoolday, beginSlot: schoolday.availableSlots?.first(), endSlot: schoolday.availableSlots?.first())
		hourInstance = copyIntoHour(hourInstance, id)
		render(view: "create", model: [hourInstance: hourInstance, hourIndex:params.hourIndex, selectedDate: date, selectedUser: session.user])
	}
	
	/**
	 * Copies the Lesson from the LessonHour identified by params.copylesson into the LessonHour
	 * identified by id.
	 * @param id The id of the LessonHour into which to copy the lesson from the existing lesson hour
	 * @return
	 */
	def copyLessonIntoExisting(Long id) {
		def hourInstance = Hour.get(id)
		
		hourInstance = convertLessonPlaceHolderHourToLessonHourIfNecessary(hourInstance)
		
		if (params.copylesson) {
			hourInstance = copyIntoHour(hourInstance, Long.valueOf(params.copylesson))
		}
		
		render(view: "edit", model: [hourInstance: hourInstance, selectedDate: hourInstance.schoolday.date])
	}

	private LessonHour convertLessonPlaceHolderHourToLessonHourIfNecessary(def hourInstance) {
		if (hourInstance instanceof LessonPlaceHolderHour && !(hourInstance instanceof LessonHour)) {
			def lessonHour = new LessonHour(hourInstance.properties)
			lessonHour.id = hourInstance.id
			hourInstance = lessonHour
		}
		return hourInstance
	}
	
	def updateEndSlot(UpdateEndSlotCommand cmd) {
		log.info "hour: ${cmd.hour}, beginSlotId: ${cmd.slot}, date= ${cmd.date}"
		def slots = null
		if (cmd.hour) {
			slots = cmd.hour.getAppropriateEndSlots(cmd.slot)
		} else {
			def day = Schoolday.findByDateAndUser(cmd.date, session.user) ?: createSchoolday(cmd.date, session.user)
			slots = day.appropriateEndSlotsFor(cmd.slot)
		}
		
		render g.select(optionKey:'id', optionValue:'endHour', from: slots,
			name: "endSlot.id", id: "endSlot")
	}
	
	def updateCourseParts() {
		log.info "course: ${params.course}"
		def coursePartId = params.coursePartId ?: 'coursePart'
		def coursePartVal = params.coursePartVal
		if (params.course == 'null') {
			render g.select(optionKey:'id', optionValue:'name', from: [], name: 'coursePart.id', id: coursePartId, noSelection: ['null':'-Kies een vakonderdeel-'])
			return
		}
		
		def course = Course.get(params.course)
		
		render g.select(optionKey:'id', optionValue:'name', from: course.courseParts,
			name: "coursePart.id", id: coursePartId, value: coursePartVal, noSelection: ['null':'-Kies een vakonderdeel-'])
	}
	
	def showModalDetail() {
		def hourInstance = null
		if (params.hourId) {
			hourInstance = Hour.get(params.hourId)
		} else {
			def schoolday =	Schoolday.findByDateAndUser(params.date, session.user) ?: createSchoolday(params.date, session.user)
			hourInstance = schoolday.hours.find{ it.beginSlot.slotIndex == params.int('hourIndex') }
		}
		
		render(template: 'hourModalDetail', bean: hourInstance)
	}
	
	def showCoursePartModal() {
		render(template: 'coursePartModal')
	}
	
	def addCoursePart(AddCoursePartToCourseCommand cmd) {
		log.info "Creating coursepart ${cmd.name} for course ${cmd.course.name}"
		CoursePart coursePart = new CoursePart(course: cmd.course, name: cmd.name)
		if (!coursePart.validate()) {
			render(status: 409, template: "/course/coursePartForm", bean: coursePart)
 			return
		}
		def course = courseService.addCoursePartToCourse(cmd.course, coursePart)
		log.info "Saved coursepart id: ${coursePart.id}"
		render g.select(optionKey:'id', optionValue:'name', from: course.courseParts,
			name: "coursePart.id", id: "coursePart", noSelection: ['null':'-Kies een vakonderdeel-'], value: coursePart.id)
	}
	
	def saveReminderAndTasks() {
		def schoolday = null
		if (params.id) {
			schoolday = Schoolday.get(params.id)
		} else {
			schoolday = new Schoolday(date:params.date, user:session.user, schedule: Schedule.findByBeginYearAndUser(AgendaUtils.beginYearForDate(params.date), session.user))
		}
		schoolday.properties = params
		schoolday.save()
		redirect(action: "show", params: [date:'date.struct', date_day: schoolday.date.format("dd"), date_month: schoolday.date.format("MM"), date_year: schoolday.date.format("yyyy")])
	}
	
	def updateLessonHourFormDetails() {
		println "Other teacher: ${params.otherTeacher}"
		if (params.otherTeacher == 'true') {
			render template: 'lessonHourFormDetails', model: [hourInstance: new LessonHour(subject: 'Les gegeven door vakleerkracht.', otherTeacher: true)]
			return
		} else {
			render template: 'lessonHourFormDetails', model: [hourInstance: new LessonHour()]
			return
		}
	}
	
}