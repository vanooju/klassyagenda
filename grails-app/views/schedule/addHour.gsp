<!DOCTYPE html>
<%@ page import="be.agenda.domain.Course" %>
<html>
	<head>
		<meta name="layout" content="main" />
	</head>
	<body>
		<g:form action="saveHour">
			<g:hiddenField name="dayId" value="${params.dayId}"/>
			<g:hiddenField name="dayIndex" value="${params.dayIndex}"/>
			<g:hiddenField name="id" value="${hourInstance.id}" />
			<label for="beginHour"><g:message code="hour.beginHour.label" /></label>
			<g:textField name="beginHour" value="${hourInstance.beginHour}" />
			<label for="endHour"><g:message code="hour.endHour.label" /></label>
			<g:textField name="endHour" value="${hourInstance.endHour}"/>
			<label for="course.id"><g:message code="hour.course.label" /></label>
			<g:select name="courseId"
          			  from="${Course.findAllByUser(session.user)}"
          			  optionKey="id"
          			  optionValue="name" 
          			  value="${hourInstance.course?.id}" />
			<div class="controls">
			<g:submitButton class="btn btn-primary" name="submit" value="${message(code:'save.label')}" />
			<g:submitButton class="btn" name="cancel" value="${message(code:'cancel.label')}" />
			</div>
		</g:form>
	</body>
</html>