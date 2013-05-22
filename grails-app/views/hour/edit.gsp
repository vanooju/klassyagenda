<%@ page import="be.agenda.Schoolday" %>
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
				<g:render template="/schoolday/hoursReadOnly" bean="${hourInstance.schoolday}" />
			</div>
			<div class="span9">
				<g:form action="update">
					<g:hiddenField name="id" value="${hourInstance.id}"/>
					<g:hiddenField name="schooldayId" value="${hourInstance.schoolday.id}"/>
				
					<g:render template="form" />
					
					<div class="control-group">
					    <div class="controls">
							<g:submitButton class="btn btn-primary" name="submit" value="Save" />
							<g:submitButton class="btn" name="cancel" value="Cancel" />		
					    </div>
					</div>
				</g:form>
			</div>
		</div>
	</body>
</html>