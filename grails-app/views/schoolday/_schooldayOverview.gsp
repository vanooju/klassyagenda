<%@ page import="be.agenda.domain.ActivityHour"%>
<!-- this template expects a Schoolday bean named schooldayInstance -->
<html>
<head>
<link href="<g:resource dir="css" file="datepicker.css" />"
	type="text/css" rel="stylesheet" media="screen, projection" />
	<script type="text/javascript" src="<g:resource dir="js" file="bootstrap-datepicker.js" />"></script>
	<script type="text/javascript">
			$(document).ready(function() {
				$('#datepicker').datepicker({
					weekStart: 1
				}).on('changeDate', function(ev){
					var curr_date = ev.date.getDate();
				    var curr_month = ev.date.getMonth() + 1; //Months are zero based
				    var curr_year = ev.date.getFullYear();

				    $('#dateYear').val(curr_year);
				    $('#dateMonth').val(curr_month);
				    $('#dateDay').val(curr_date);
					$('#dateForm').submit();
				});
			});
	</script>
</head>
<body>
	<div class="noprint">
	<h4 class="schoolday-date">
		${selectedDate.format("EEEE dd/MM/yyyy")}
		<a href="#" title="Datum kiezen" id="datepicker"
			data-date="${selectedDate}" data-date-format="dd/mm/yyyy" class="btn" style="vertical-align: text-bottom;"><i
			class="icon-calendar"></i></a>
	</h4>
	<g:if test="${schooldayInstance}">
		<table class="table table-condensed" id="schoolday-overview-table">
			<g:each in="${schooldayInstance?.hours}" var="hour" status="i">
				<tr
					class="${hourInstance?.beginSlot?.slotIndex == hour?.beginSlot?.slotIndex ? "info" : ""}">
					<td>
						<i class="${hour instanceof ActivityHour ? 'icon-globe' : 'icon-book'}"></i>
					</td>
					<td style="text-align: right;">
						${hour.beginHour}
					</td>
					<td style="text-align: right;">
						${hour.endHour}
					</td>
					<td>
						${hour.title}
					</td>
				</tr>
			</g:each>
		</table>
	</g:if>
	<g:if
		test="${schooldayInstance?.availableSlots && schooldayInstance?.availableSlots.size() > 0 && (selectedUser == session.user)}">
		<ul class="nav nav-list">
		<li><g:link action="create"
				params="[date_year: schooldayInstance.date.format('yyyy'), date_month: schooldayInstance.date.format('MM'), date_day: schooldayInstance.date.format('dd'), date: 'date.struct', type: 'lesson']">Nieuwe les</g:link></li>
		<li><g:link action="create"
				params="[date_year: schooldayInstance.date.format('yyyy'), date_month: schooldayInstance.date.format('MM'), date_day: schooldayInstance.date.format('dd'), date: 'date.struct', type: 'activity']">Nieuwe activiteit</g:link></li>
			</ul>
	</g:if>
	<sec:ifAnyGranted roles="PRINCIPAL, ADMIN">
		<li><g:link action="list" controller="user">Toon leerkrachten</g:link></li>
	</sec:ifAnyGranted>
	<sec:ifAllGranted roles="ROLE_USER">
		<g:if test="${selectedUser==session.user}">
			<g:if test="${schooldayInstance}">
				<form name="schoolday" action="saveReminderAndTasks"
					class="form well">
					<g:hiddenField name="date_year"
						value="${schooldayInstance.date.format('yyyy')}" />
					<g:hiddenField name="date_month"
						value="${schooldayInstance.date.format('MM')}" />
					<g:hiddenField name="date_day"
						value="${schooldayInstance.date.format('dd')}" />
					<g:hiddenField name="date" value="date.struct" />
					<g:hiddenField name="id" value="${schooldayInstance.id}" />
	
					<div class="control-group">
						<label for="reminder" class="control-label">Niet vergeten</label>
						<div class="controls">
							<g:textArea rows="3" name="reminder"
								value="${schooldayInstance.reminder}" />
						</div>
					</div>
	
					<div class="control-group">
						<label for="tasks" class="control-label">Taken</label>
						<div class="controls">
							<g:textArea rows="3" name="tasks"
								value="${schooldayInstance.tasks}" />
						</div>
					</div>
	
					<div class="form-actions">
						<g:submitButton class="btn" name="submit" value="Opslaan" />
					</div>
				</form>
			</g:if>
		</g:if>
	</sec:ifAllGranted>

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

			$(document).on("click", ".open-confirm-dialog-id", function () {
				var hourId = $(this).data('hour-id');
		        $('#hourId').val(hourId);
		        $('#modal-body').load('${createLink(action: 'showModalDetail')}', 'hourId=' + hourId);
			});
		</script>

	<form id="dateForm" action="show">
		<input type="hidden" value="date.struct" name="date" /> <input
			type="hidden" id="dateYear" value="" name="date_year" /> <input
			type="hidden" id="dateMonth" value="" name="date_month" /> <input
			type="hidden" id="dateDay" value="" name="date_day" /> <input
			type="hidden" value="${selectedUser?.id ?: session.user.id}"
			name="userid" />
	</form>
	</div>
</body>
</html>