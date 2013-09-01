package be.agenda;

import static org.junit.Assert.*;

import org.junit.Test;

class AgendaUtilsTest {

	@Test
	public void testFindCorrectSchoolyearForFirstOfSeptember() {
		def firstOfSeptember = new GregorianCalendar(2013,Calendar.SEPTEMBER, 1).getTime()
		def beginYearForDate = AgendaUtils.beginYearForDate(firstOfSeptember)
		assertEquals(2013, beginYearForDate)
	}

}
