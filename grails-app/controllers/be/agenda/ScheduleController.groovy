package be.agenda

import java.util.Iterator;

import be.agenda.authentication.UserDetails;

import grails.plugins.springsecurity.Secured

class ScheduleController {
	
	static defaultAction = "list"
	
	def scheduleService
	
	def list() { 
		def schedule = null
		if (params.scheduleId) {
			schedule = Schedule.get(params.scheduleId)
		} else {
			schedule = Schedule.current(session.user) ?: Schedule.mostRecent(session.user)
		}
		
		def model = [scheduleInstance:schedule]
		if (schedule) {
			model.dayId = params.dayId ? Integer.valueOf(params.dayId) : schedule?.days[0]?.id
		}
		if (params.inline) {
			render template: 'scheduleTable', model: model
		} else {
			return model
		}
	}
	
	def createSchedule() {
	}
	
	def create() {
		def scheduleHourInstance =  new ScheduleHour(params)
		scheduleHourInstance.beginSlot = scheduleHourInstance.day.availableSlots()[0]
		scheduleHourInstance.endSlot = scheduleHourInstance.day.availableSlots()[0]
		
		if (!scheduleHourInstance.beginSlot) {
			flash.message = 'Geen lesuren meer beschikbaar.'
			redirect(action: 'list')
		}
		
		[scheduleHourInstance:scheduleHourInstance, scheduleId: params.scheduleId, beginSlots:scheduleHourInstance.day.availableSlots(), endSlots: scheduleHourInstance.day.appropriateEndSlotsFor(scheduleHourInstance.beginSlot)]
	}
	
	def saveSchedule() {
		if (params.cancel) {
			redirect(action: "list", controller: "schedule")
			return
		}	
		
		def schedule = scheduleService.createSchedule(Integer.valueOf(params.beginYear), session.user, params.int('grade'))
		if (!schedule.save()) {
			render(view: "createSchedule", model: [scheduleInstance: schedule])
			return
		}
		
		redirect(action: "list", controller: "schedule", params: [scheduleId: schedule.id])
	}
	
	def save() {
		def scheduleInstance = Schedule.get(params.scheduleId)
		
		if (params.cancel) {
			redirect(action: "list", controller: "schedule", params: ['day.id': params.day.id], scheduleInstance: scheduleInstance)
			return
		}
		ScheduleHour scheduleHourInstance = new ScheduleHour(params)
		
		if (!scheduleHourInstance.save(flush: true)) {
            render(view: "create", model: [scheduleHourInstance: scheduleHourInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'scheduleHour.label', default: 'Lesuur'), scheduleHourInstance.id])
        redirect(action: "list", controller: "schedule", params: [dayId: scheduleHourInstance.day.id, scheduleId: scheduleInstance.id])
    }

    def update(Long id, Long version) {
		if (params.cancel) {
			redirect(action: "list", controller: "schedule", params: ['day.id': params.day.id])
			return
		}
		
        def scheduleHourInstance = ScheduleHour.get(id)
        if (!scheduleHourInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'scheduleHour.label', default: 'Lesuur'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (scheduleHourInstance.version > version) {
                scheduleHourInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'scheduleHour.label', default: 'Lesuur')] as Object[],
                          "Another user has updated this Lesuur while you were editing")
                render(view: "edit", model: [scheduleHourInstance: scheduleHourInstance])
                return
            }
        }
		
		scheduleHourInstance.properties = params

        if (!scheduleHourInstance.save(flush: true)) {
            render(view: "edit", model: [scheduleHourInstance: scheduleHourInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'scheduleHourInstance.label', default: 'Lesuur'), id])
		//flash.coursePartId = coursePartInstance.id
        redirect(action: "list", params: ['day.id': scheduleHourInstance.day.id])
    }
	
	def edit(Long id) {
		def scheduleHourInstance = ScheduleHour.get(id)
		if (!scheduleHourInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'scheduleHour.label', default: 'Lesuur'), scheduleHourInstance.id])
			redirect(action: "list")
			return
		}
		
		def beginSlots = scheduleHourInstance.day.availableSlots(scheduleHourInstance)
		def endSlots = scheduleHourInstance.day.appropriateEndSlotsFor(scheduleHourInstance)

		[scheduleHourInstance: scheduleHourInstance, beginSlots:beginSlots, endSlots:endSlots, scheduleDayInstance: scheduleHourInstance.day]
	}
	
	def updateEndSlot() {
		log.info "scheduleHourId: ${params.scheduleHourId}, beginSlotId: ${params.beginSlot}"
		def scheduleHourInstance = null
		def slots = null
		def beginSlot = Slot.get(params.beginSlot)
		if (params.scheduleHourId) {
			def hour = ScheduleHour.get(params.scheduleHourId)
			def day = hour.day
			slots = day.appropriateEndSlotsFor(beginSlot, hour)
		} else {
			def day = ScheduleDay.get(params.scheduleDayId)
			slots = day.appropriateEndSlotsFor(beginSlot)
		}
		
		render g.select(optionKey:'id', optionValue:'endHour', from: slots, 
			name: "endSlot.id")
	}
	
	def delete(Long id) {
		def scheduleHour = ScheduleHour.get(id)
		scheduleHour.delete()
		
		redirect action: "list", controller: "schedule", params: [scheduleId: scheduleHour.day.schedule.id]
	}
}
