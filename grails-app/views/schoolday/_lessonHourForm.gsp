<%@ page import="be.agenda.domain.Course"%>
<%@ page import="be.agenda.domain.CoursePart"%>

<div id="hiddenCoursePartOtherTeacher" style="display: none;"></div>
<div id="newValue" style="display: none;"></div>

<script>
		function setCoursePartLinkStatus() {
			if ($('#course').val() == 'null') {
				if (!$('#show-coursepart-modal-link').hasClass('disabled')) {
					$('#show-coursepart-modal-link').addClass('disabled');
					$('#show-coursepart-modal-link').attr("disabled", "disabled");
				}
			} else {
				if ($('#show-coursepart-modal-link').hasClass('disabled')) {
					$('#show-coursepart-modal-link').removeClass('disabled');
					$('#show-coursepart-modal-link').removeAttr("disabled");
				}
			}
		}
	
		$('document').ready(function() {
			setCoursePartLinkStatus();
		});
	</script>

<legend>
	<g:message code="be.agenda.domain.LessonHour.label" />
	<g:hasErrors bean="${hourInstance}">
		<small class="text-error"><g:message
				code="default.error.message" /></small>
	</g:hasErrors>
</legend>

<p>
	<a href="#lessonSearchModal" data-toggle="modal"
		id="lessonSearchModalLink">Les zoeken</a>
</p>

<g:hiddenField name="type" value="lesson" />

<g:render template="hourForm" />

<div
	class="control-group ${hasErrors(bean:hourInstance,field:'course','error')} ${hasErrors(bean:hourInstance,field:'coursePart','error')}">
	<label for="course" class="control-label"><g:message
			code="be.agenda.domain.Course.label" /></label>
	<div class="controls form-inline">
		<div class="input-append">
			<g:select name="course.id"
				from="${Course.findAllByUser(session.user, [sort: 'name'])}"
				optionKey="id" optionValue="name" value="${hourInstance.course?.id}"
				noSelection="['null':'-Kies een vak-']" class="input-large"
				id="course" />
			<button class="btn open-course-dialog" type="button"
				data-toggle="modal" data-target="#courseModal"
				id="show-course-modal-link"
				data-remote="${createLink(controller: 'course', action: 'showCourseModalForm')}">
				<g:message code="default.button.new.label" />
			</button>
		</div>
		<div class="input-append">
			<g:select name="coursePart.id"
				from="${hourInstance.course ? hourInstance.course.courseParts : []}"
				optionKey="id" optionValue="name"
				value="${hourInstance.coursePart?.id}"
				noSelection="['null':'-Kies een vakonderdeel-']" id="coursePart"
				class="input-large" />
			<button class="btn open-coursepart-dialog" type="button"
				data-toggle="modal" data-target="#coursePartModal"
				id="show-coursepart-modal-link"
				data-remote="${createLink(action: 'showCoursePartModal')}">
				<g:message code="default.button.new.label" />
			</button>
		</div>

		<g:hasErrors bean="${hourInstance}" field="course">
			<g:eachError var="err" bean="${hourInstance}" field="course">
				<span class="help-block"><g:message error="${err}" /></span>
			</g:eachError>
		</g:hasErrors>
		<g:hasErrors bean="${hourInstance}" field="coursePart">
			<g:eachError var="err" bean="${hourInstance}" field="coursePart">
				<span class="help-block"><g:message error="${err}" /></span>
			</g:eachError>
		</g:hasErrors>
	
	</div>
</div>

<script>
	$('#course').change(function() {
		${remoteFunction(action:'updateCourseParts',update:'coursePart',params:"'course=' + this.value")};
		setCoursePartLinkStatus();
	});
</script>

<div class="control-group">
	<div class="controls">
		<label class="checkbox inline" style="width: 100%;"> <g:checkBox
				name="otherTeacher" value="${hourInstance?.otherTeacher}" /> <g:message
				code="be.agenda.domain.LessonHour.otherTeacher.label" />
		</label>
	</div>
</div>

<script>
	$('#otherTeacher').change(function() {
		if ($('#otherTeacher').is(":checked")) {
			bootbox.confirm("Wil je deze les automatisch invullen?" , function(result) {
				if (result == true) {
					${remoteFunction(action:'updateLessonHourFormDetails',update:'lessonHourFormDetails',params:'\'otherTeacher=true\'')};
				} else {
					$('#otherTeacher').val(false);
				}
			});
		} else {
			${remoteFunction(action:'updateLessonHourFormDetails',update:'lessonHourFormDetails',params:'\'otherTeacher=false\'')};
		}
	});
</script>

<div id="lessonHourFormDetails">
	<g:render template="lessonHourFormDetails"
		model="[hourInstance: hourInstance]" />
</div>