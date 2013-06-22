<%@ page import="be.agenda.domain.Schedule"%>

<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<g:if test="${flash.message}">
					<div class="alert alert-info">
						${flash.message}
					</div>
				</g:if>
			
				<g:form class="form form-horizontal">
					<g:select name="scheduleId"
						from="${be.agenda.domain.Schedule.findAllByUser(session.user, [sort:"beginYear"])}"
						optionKey="id" optionValue="schoolyear"
						value="${scheduleInstance ? scheduleInstance.id : Schedule.current(session.user)}" />
					<script>
						$('#scheduleId').change(function () {
							${remoteFunction(action: 'list', update: 'scheduleTable', params: '\'inline=true&scheduleId=\' + this.value')}
						});
					</script>
					<g:link class="btn" name="newSchoolyear" action="createSchedule">Nieuw schooljaar</g:link>
				</g:form>
				<g:if test="${scheduleInstance}">
					<div id="scheduleTable">
						<g:render template="scheduleTable" model="[scheduleInstance: scheduleInstance]" />
					</div>
				</g:if>
				<g:else>
			Je hebt nog geen schooljaar aangemaakt. Klik op <strong>Nieuw
						schooljaar</strong> om een schooljaar aan te maken.
		</g:else>
			</div>
		</div>
	</div>
</body>
</html>