package be.agenda.commands

import grails.validation.Validateable
import be.agenda.domain.Schoolday
@Validateable
class CreateHourCommand {
	Date date
	Schoolday schoolday
}
