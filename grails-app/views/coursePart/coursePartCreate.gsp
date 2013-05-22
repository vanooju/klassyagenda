<%@ page import="be.agenda.CoursePart" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="course">
		<g:set var="entityName" value="${message(code: 'coursePart.label', default: 'CoursePart')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<g:form action="save" >
			<fieldset class="form">
				<g:render template="coursePartForm"/>
			</fieldset>
			<fieldset class="buttons">
				<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
			</fieldset>
		</g:form>
	</body>
</html>
