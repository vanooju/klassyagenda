<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main" />
	</head>
	<body>
		<g:form action="update">
			<g:hiddenField name="day.id" value="${scheduleHourInstance.day.id}"/>
			<g:hiddenField name="id" value="${scheduleHourInstance.id}"/>
			<g:render template="form" />
			<div class="controls">
			<g:submitButton class="btn btn-primary" name="submit" value="${message(code:'edit.label')}" />
			<g:submitButton class="btn" name="cancel" value="${message(code:'cancel.label')}" />
			</div>
		</g:form>
		
		<g:render template="/course/courseModal" />
	</body>
</html>