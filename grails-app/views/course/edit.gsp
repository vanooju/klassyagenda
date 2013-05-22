<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
</head>
	<body>
		<g:form action="save">
			<legend>Vak</legend>
			<g:hiddenField name="id" value="${courseInstance?.id}"/>
			<g:render template="form" bean="${courseInstance}" />
			<div class="form-actions">
					<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:link class="btn" controller="course" action="list"><g:message code="default.button.cancel.label" default="Annuleren" /></g:link>
			</div>
		</g:form>
	</body>
</html>