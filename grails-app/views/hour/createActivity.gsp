
<%@ page import="be.agenda.domain.Schoolday" %>
<%@ page import="be.agenda.domain.LessonHour" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'hour.label', default: 'Uur')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row">
			<div class="span3">
				<input maxlength="10" size="10" type="text" value="<g:formatDate date="${hourInstance.schoolday.date}" format="dd/MM/yyyy" />" disabled>
				<g:render template="/schoolday/hours" model="[schooldayInstance: hourInstance.schoolday, readOnly: true]" />
			</div>
			<div class="span9">
				<g:form action="saveActivityHour">
					<g:hiddenField name="id" value="${dayInstance.id}"/>
				
					<g:render template="activityForm" />
					
					<div class="row-fluid">
						<g:submitButton class="btn btn-primary" name="submit" value="Create" />
						<g:submitButton class="btn" name="cancel" value="Cancel" />			            
					</div>					
				</g:form>
			</div>
		</div>
	</body>
</html>