package be.agenda;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class AgendaUtils {
	
	public static int beginYearForDate(Date date) {
		Calendar dateCalendar = date.toCalendar()
		Calendar firstOfJuly = new GregorianCalendar(date.getAt(Calendar.YEAR), Calendar.JULY, 1)
		Calendar lastOfAugust = new GregorianCalendar(date.getAt(Calendar.YEAR), Calendar.AUGUST, 31)
		if (dateCalendar.before(firstOfJuly)) 
			return dateCalendar.get(Calendar.YEAR) - 1
		else {
			return dateCalendar.get(Calendar.YEAR)
		}
	}
	
	public static Date firstSchooldayAfter(Date date) {
		Calendar dateCalendar = date.toCalendar()
		if (dateCalendar.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || dateCalendar.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
			dateCalendar.set(Calendar.WEEK_OF_YEAR, dateCalendar.get(Calendar.WEEK_OF_YEAR) + 1)
			dateCalendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY)
		}
		dateCalendar.getTime()
	}
}
