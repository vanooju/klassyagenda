package be.agenda



import org.junit.*

import be.agenda.controllers.SchoolController;
import be.agenda.domain.School;
import grails.test.mixin.*

@TestFor(SchoolController)
@Mock(School)
class SchoolControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/school/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.schoolInstanceList.size() == 0
        assert model.schoolInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.schoolInstance != null
    }

    void testSave() {
        controller.save()

        assert model.schoolInstance != null
        assert view == '/school/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/school/show/1'
        assert controller.flash.message != null
        assert School.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/school/list'

        populateValidParams(params)
        def school = new School(params)

        assert school.save() != null

        params.id = school.id

        def model = controller.show()

        assert model.schoolInstance == school
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/school/list'

        populateValidParams(params)
        def school = new School(params)

        assert school.save() != null

        params.id = school.id

        def model = controller.edit()

        assert model.schoolInstance == school
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/school/list'

        response.reset()

        populateValidParams(params)
        def school = new School(params)

        assert school.save() != null

        // test invalid parameters in update
        params.id = school.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/school/edit"
        assert model.schoolInstance != null

        school.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/school/show/$school.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        school.clearErrors()

        populateValidParams(params)
        params.id = school.id
        params.version = -1
        controller.update()

        assert view == "/school/edit"
        assert model.schoolInstance != null
        assert model.schoolInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/school/list'

        response.reset()

        populateValidParams(params)
        def school = new School(params)

        assert school.save() != null
        assert School.count() == 1

        params.id = school.id

        controller.delete()

        assert School.count() == 0
        assert School.get(school.id) == null
        assert response.redirectedUrl == '/school/list'
    }
}
