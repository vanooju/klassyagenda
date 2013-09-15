<%@ page import="be.agenda.domain.LessonHour"%>
<%@ page import="be.agenda.domain.ActivityHour"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'hour.label', default: 'Uur')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>

<script type="text/javascript">
	$(window)
			.bind('beforeunload',
				  function() {
				    return 'Weet je zeker dat je de pagina wil verlaten voor je de wijzigingen hebt opgeslaan?';
				  });

	$('form').submit(function() {
		$(window).unbind('beforeunload');
	});
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span3">
				<g:render template="schooldayOverview"
					bean="${hourInstance.schoolday}" var="schooldayInstance" />
			</div>
			<div id="hour-form" class="span9">
				<g:if test="${flash.message}">
					<span> ${flash.message}
					</span>
				</g:if>
				<g:else>
					<g:form class="form-horizontal">
						<g:hiddenField name="date_year"
							value="${hourInstance.schoolday.date.format('yyyy')}" />
						<g:hiddenField name="date_month"
							value="${hourInstance.schoolday.date.format('MM')}" />
						<g:hiddenField name="date_day"
							value="${hourInstance.schoolday.date.format('dd')}" />
						<g:hiddenField name="date" value="date.struct" />

						<g:if test="${hourInstance instanceof LessonHour}">
							<g:if test="${hourIndex != null}">
								<g:hiddenField name="hourIndex" value="${hourIndex}" />
							</g:if>
							<g:render template="lessonHourForm" />
							
							<div class="form-actions">
								<g:actionSubmit class="btn btn-primary" name="submit" action="saveLesson"
									value="${message(code: 'default.button.create.label')}" />
								<g:submitButton class="btn" name="cancel" value="${message(code: 'default.button.cancel.label')}" />
							</div>
						</g:if>
						<g:if test="${hourInstance instanceof ActivityHour}">
							<g:render template="activityHourForm" />
							
							<div class="form-actions">
								<g:actionSubmit class="btn btn-primary" name="submit" action="saveActivity"
									value="${message(code: 'default.button.create.label')}" />
								<g:submitButton class="btn" name="cancel" value="${message(code: 'default.button.cancel.label')}" />
							</div>
						</g:if>
					</g:form>

					<g:formRemote url="[controller: 'lesson', action: 'searchModal']"
						update="lessonSearchModalContents" name="lessonSearchForm">
						<input type="hidden" name="selectedDate_day"
							value="${selectedDate.format("dd")}" />
						<input type="hidden" name="selectedDate_month"
							value="${selectedDate.format("MM")}" />
						<input type="hidden" name="selectedDate_year"
							value="${selectedDate.format("yyyy")}" />
						<input type="hidden" name="selectedDate" value="date.struct" />
						<input type="hidden" name="hourIndex" value="${hourIndex}" />
						<input type="hidden" name="beginSlot"
							value="${hourInstance?.beginSlot?.slotIndex}" />
						<input type="hidden" name="endSlot"
							value="${hourInstance?.endSlot?.slotIndex}" />
						<g:render template="/lesson/searchModal" />
					</g:formRemote>
					<script>
					$('#lessonSearchModal').on('show', function () {
						$("#searchModal-course").val( $("#course").val() );
						${remoteFunction(action:'updateCourseParts',update:'searchModal-coursePart',params:"'coursePartVal=' + \$(\"#coursePart\").val() + '&coursePartId=searchModal-coursePart&course=' + \$(\"#course\").val()")};
						//setCoursePartLinkStatus();
					});
				</script>
				</g:else>
			</div>
		</div>

		<div id="coursePartModal" class="modal hide" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<g:formRemote name="coursePartForm"
				url="[ controller: 'coursePart', action: 'addCoursePart']"
				update="[success: 'coursePart', failure: 'coursePartFormTemplate']"
				onSuccess="\$('#coursePartModal').modal('hide')" class="form-horizontal">
				<g:hiddenField name="course.id" value="${it?.course?.id}"
					id="courseId" />
				<div class="modal-header">
					<button type="button" href="#" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h3 id="myModalLabel">Vakonderdeel toevoegen</h3>
				</div>
				<div class="modal-body" id="modal-body"></div>
				<div class="modal-footer">
					<g:submitToRemote class="btn btn-primary" name="confirm"
						value="Aanmaken"
						url="[controller: 'coursePart', action: 'addCoursePart']"
						update="[success: 'coursePart', failure: 'coursePartFormTemplate']"
						onSuccess="\$('#coursePartModal').modal('hide')" />
					<button type="button" class="btn" data-dismiss="modal"
						aria-hidden="true">Annuleren</button>
				</div>
			</g:formRemote>
		</div>
	</div>

	<script>
		 $("#coursePartModal").on("hidden", function() { 
			 $(this).removeData('modal');
		 });

		 $("#coursePartModal").on("shown", function() { 
			 $('#courseId').val($('#course').val());
		 });
	</script>

	<g:render template="/course/courseModal" />
</body>
</body>
</html>