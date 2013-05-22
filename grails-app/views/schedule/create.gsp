<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<g:form action="save">
					<g:hiddenField name="scheduleId" value="${scheduleId}" />
					<g:hiddenField name="day.id" value="${scheduleHourInstance.day.id}" />
					<g:render template="form" />
					<div class="controls">
						<g:submitButton class="btn btn-primary" name="submit"
							value="${message(code:'save.label')}" />
						<g:submitButton class="btn" name="cancel"
							value="${message(code:'cancel.label')}" />
					</div>
				</g:form>

				<g:render template="/course/courseModal" />
			</div>
		</div>
	</div>
</body>
</html>