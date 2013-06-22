package be.agenda.controllers

import be.agenda.ApplicationUser;
import be.agenda.ApplicationUserRole;
import be.agenda.Role;
import be.agenda.Schoolday;
import grails.plugins.springsecurity.Secured

class UserController {
	
	def springSecurityService
	
	@Secured(['ROLE_PRINCIPAL', 'ROLE_ADMIN'])
    def list() { 
		def user = ApplicationUser.get(session.user.id)
		def date = params.date
		[users: ApplicationUser.findAllBySchool(user.school, [sort:'lastName']).findAll {it.authorities.contains(new Role(authority: 'ROLE_USER')) }, selectedDate: date ?: new Date()]
	}
	
	@Secured(['ROLE_PRINCIPAL, ROLE_ADMIN'])
	def showSchooldayOverview() {
		def user = params.user
		def date = params.date
		
		if (!user) {
			return [selectedDate:date ?: new Date()]
		}
		
		def schoolday = Schoolday.findByUserAndDate(ApplicationUser.get(user), date)
		if (schoolday) {
			render(template: '/schoolday/hourDetails', collection: schoolday?.hours)
		} else {
			render('')
		}
	}
	
	def create() {
	}
	
	def save() {
		def user = new ApplicationUser(params)
		user.enabledFields = ['descriptionBegin', 'descriptionMiddle', 'descriptionEnd', 'media', 'objectives']
		user.enabled = true
		
		if (params.passwordRepeat?.empty) {
			flash.passwordRepeatError = 'Vul hier het paswoord nog eens in ter controle.'
			render(view: 'create', model: [user: user])
			return
		} else if (!params.passwordRepeat == params.password) {
			flash.passwordRepeatError = 'Het controle paswoord en het paswoord moeten hetzelfde zijn.'
			render(view: 'create', model: [user: user])
			return
		}
		
		if (!user.save()) {
			render(view: 'create', model: [user: user])
			return
		}
		
		ApplicationUserRole.create user, Role.findByAuthority('ROLE_USER'), true
		
		springSecurityService.reauthenticate user.username
		session.user = user
		
		flash.message = "Welkom ${user.firstName}! Je kan je profiel en instellingen wijzigen via het menu door rechtsboven op je naam te klikken."
		
		redirect(controller: 'schedule', action: 'list')
	}
	
	def edit(Long id) {
		def selectedUser
		if (id) {
			selectedUser = ApplicationUser.get(id)
		} else {
			selectedUser = ApplicationUser.get(session.user.id)
		}
		[selectedUser: selectedUser]
	}
	
	def update() {
		if (params.cancel) {
			redirect(controller:'schoolday', action:'show')
			return
		}
		def user = ApplicationUser.get(params.id)
		user.properties = params
		
		if (params.authorities) {
			def applicationUserRoles = ApplicationUserRole.findAllByUser(user).collect { it.role } as Set
			ApplicationUserRole.deleteAll(applicationUserRoles)
			
			params.authorities.each {
				ApplicationUserRole.create user, Role.get(it), true
			}
		}
		
		if (!user.save(flush:true)) {
			flash.error = "Profiel kon niet worden opgeslagen."
			render(view: 'edit', model: [selectedUser: user])
			return
		} else {
			session.user = user 
		}
		redirect(controller:"schedule", action:"list")
	}
	
	
	def removeRole() {
		def user = User.get(params.userId)
		def role = Role.get(params.roleId)
		
		def applicationUserRole = ApplicationUserRole.findByUserAndRole(user, role)
		applicationUserRole.delete()
		
		redirect(controller:"user", action:"edit", id:user.id)
	}
	
	def modifyPassword(Long id) {
		if (params.cancel) {
			redirect(action:'edit', id: id)
		}
		
		def user = ApplicationUser.get(id)
		
		if (params.submit) {
			if (params.passwordRepeat?.empty) {
				flash.passwordRepeatError = 'Vul hier het paswoord nog eens in ter controle.'
				render(view: 'modifyPassword', model: [selectedUser: user])
				return
			} else if (!params.passwordRepeat == params.password) {
				flash.passwordRepeatError = 'Het controle paswoord en het paswoord moeten hetzelfde zijn.'
				render(view: 'modifyPassword', model: [selectedUser: user])
				return
			}
			
			user.properties = params
			
			if (!user.save()) {
				render view: 'modifyPassword', model: [selectedUser: user]
				return
			} else {
				flash.message = 'Paswoord gewijzigd.'
				redirect action: 'edit', id: user.id
				return
			}
		}
		
		[selectedUser: user]
	}
}
