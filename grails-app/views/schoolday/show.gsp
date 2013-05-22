<%@ page import="be.agenda.Schoolday"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'schoolday.label', default: 'Schoolday')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
<script>
		$(document).on("click", ".open-confirm-dialog-index-date", function () {
		     var hourIndex = $(this).data('hour-index');
		     var date_year = $(this).data('date-year')
		     var date_month = $(this).data('date-month')
		     var date_day = $(this).data('date-day')
		     var hourId = $(this).data('hour-id')
	         $('#hourIndex').val(hourIndex);
	         $('#date_delete_year').val(date_year);
	         $('#date_delete_month').val(date_month);
	         $('#date_delete_day').val(date_day);
	         $('#modal-body').load('${createLink(action: 'showModalDetail')}', 'hourIndex=' + hourIndex + '&date_year=' + date_year + '&date_month=' + date_month + '&date_day=' + date_day + '&date=date.struct');
		});
	</script>
</head>
<body data-spy="scroll" data-target=".nav-list">
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span3">
				<g:if test="${schooldayInstance}">
					<g:render template="schooldayOverview" bean="${schooldayInstance}"
						var="schooldayInstance" />
				</g:if>
			</div>
			<div id="hour-form" class="span9">
				<g:if test="${flash.message}">
					<div class="row">
						<div class="span5">
							<div class="alert alert-info">
								${flash.message}
							</div>
						</div>
					</div>
				</g:if>
				<g:if test="${selectedUser != session.user}">
					<div class="row">
						<div class="page-header">
							<h1>
								${selectedUser.firstName}
								${selectedUser.lastName}
								<small> ${selectedDate.format("EEEE dd/MM/yyyy")}
								</small>
							</h1>
						</div>
					</div>
				</g:if>
				<g:if test="${schooldayInstance}">
					<g:render template="hourDetails"
						collection="${schooldayInstance.hours}" />
				</g:if>
				<g:elseif test="${selectedUser?.id == session.user.id}">
					<g:link controller="schedule" action="createSchedule">Maak eerst een schooljaar aan</g:link> voor deze datum, of kies een andere datum.
				</g:elseif>
			</div>
		</div>

		<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<g:form name="deleteForm" controller="schoolday" action="delete">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h3 id="myModalLabel">Uur verwijderen</h3>
				</div>
				<div class="modal-body" id="modal-body">
					<p></p>
				</div>
				<div class="modal-footer">
					<g:hiddenField name="hourIndex" value="" />
					<g:hiddenField name="date_delete_year" value="" />
					<g:hiddenField name="date_delete_month" value="" />
					<g:hiddenField name="date_delete_day" value="" />
					<g:hiddenField name="date_delete" value="date.struct" />
					<g:hiddenField name="hourId" value="" />
					<button class="btn" data-dismiss="modal" aria-hidden="true">Annuleren</button>
					<g:submitButton class="btn btn-danger" name="confirm"
						value="Verwijderen" />
				</div>
			</g:form>
		</div>
	</div>

</body>
</html>
