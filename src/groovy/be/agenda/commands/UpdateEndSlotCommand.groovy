package be.agenda.commands;

import grails.validation.Validateable;
import be.agenda.domain.Hour
import be.agenda.domain.Slot

@Validateable
public class UpdateEndSlotCommand {
	Date date
	Slot slot
	Hour hour
}
