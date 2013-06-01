package be.agenda

import grails.test.mixin.support.*

import org.springframework.security.core.userdetails.User

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestFor(ScheduleController)
@Mock([Schedule, ApplicationUser, Slot, ScheduleDay, Course, ScheduleHour])
class ScheduleControllerTests {
	
	private Schedule schedule
	private Object springSecurityService = new Object()
	private Course course

	@Before
    void setUp() {
		def user = new ApplicationUser(username: 'johndoe', password: 'p4ssw0rd', firstName: 'Jurgen', lastName: 'Van Oosterwijck')
		def springSecurityService = new Object();
		
		user.springSecurityService = springSecurityService
		springSecurityService.metaClass.encodePassword =  { 'encoded' }
		
		user.save(flush:true, failOnError:true)
		
		springSecurityService.metaClass.principal = user
		controller.springSecurityService = springSecurityService
		
		schedule = new Schedule(2012, user)
		schedule.save(flush:true, failOnError:true)
		
		course = new Course(name: 'DitIsEenVak')
		course.save(flush:true, failOnError:true) 
    }
	
	@BeforeClass
	static void setUpClass() {
	}

    void tearDown() {
        // Tear down logic here
    }

    void testList() {
        def model = controller.list()
		
		Schedule schedule = model['scheduleInstance']
		Integer dayId = model['dayId']
		
		assertNotNull schedule
		assertNotNull schedule.id
		assertNotNull schedule.days
		assertNotNull schedule.slots
		assertEquals 5, schedule.days.size()
		assertEquals 12, schedule.slots.size()
		assertNotNull dayId
    }
	
	void testCreate() {
		def listModel = controller.list()
		def dayId = listModel['dayId']
		
		controller.params['day.id'] = dayId
		
		def createModel = controller.create()
		def scheduleHour = createModel['scheduleHourInstance']
		assertNotNull scheduleHour
		assertEquals schedule.slots[0], scheduleHour.beginSlot
		assertEquals schedule.slots[0], scheduleHour.endSlot
		assertNotNull scheduleHour.day
		assertEquals dayId, scheduleHour.day.id
	}
	
	void testSave() {
		controller.params.dayId = schedule.days[0].id
		controller.params.beginSlot = schedule.slots[0].id
		controller.params.endSlot = schedule.slots[0].id
		controller.params.courseId = course.id 
		
		controller.save()
	}
	
	void testDataBinding() {
		params['day.id'] = schedule.days[0].id
		params['beginSlot.id'] = schedule.slots[0].id
		params['endSlot.id'] = schedule.slots[0].id
		params['course.id'] = course.id
		
		ScheduleHour scheduleHour = new ScheduleHour(params)
		assertNotNull scheduleHour
		assertNotNull scheduleHour.beginSlot
		assertEquals '8:30', scheduleHour.beginSlot.beginHour
		assertNotNull scheduleHour.endSlot
		assertNotNull scheduleHour.course
	}
}