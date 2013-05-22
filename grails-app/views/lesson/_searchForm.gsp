<%@ page import="be.agenda.Course"%>
<%@ page import="be.agenda.CoursePart"%>
<%@ page import="be.agenda.Schedule"%>
<html>
<body>
	<div class="row-fluid">
		<div class="span2"></div>
		<div class="span8">
	<g:if test="${flash.error}">
		<div class="alert alert-error">
			${flash.error}
		</div>
	</g:if>

	<div class="control-group">
		<g:select name="selectedSchedule"
			from="${Schedule.findAllByUser(session.user, [sort:'beginYear', order:'desc'])}"
			optionKey="id" optionValue="schoolyear"
			value="${selectedSchedule}"
			noSelection="['null':'-Kies een schooljaar-']" class="input-xlarge"
			id="searchModal-schedule" />
	</div>

	<div class="control-group">
		<!-- update coursepart dropdown when course is changed -->
		<g:select name="course.id"
			from="${Course.findAllByUser(session.user, [sort:'name'])}"
			optionKey="id" optionValue="name" value="${selectedCourse?.id}"
			noSelection="['null':'-Kies een vak-']" class="input-xlarge"
			id="searchModal-course" />
	</div>

	<div class="control-group">
		<g:select name="coursePart.id"
			from="${selectedCourse?.courseParts ?: []}" optionKey="id"
			optionValue="name" value="${selectedCoursePart?.id}"
			noSelection="['null':'-Kies een vakonderdeel-']"
			id="searchModal-coursePart" class="input-xlarge" />
	</div>

	<script>
		$('#searchModal-course').change(function() {
			${remoteFunction(controller:'schoolday', action:'updateCourseParts',update:'searchModal-coursePart',params:"'course=' + this.value")};
		});
	</script>

	<div class="control-group">
		<label>Onderwerp</label>
		<g:textField name="subject" value="${subject}" class="input-xlarge" />
	</div>
	</div>
	<div class="span2"></div>
	</div>
</body>
</html>