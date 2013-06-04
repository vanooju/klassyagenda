<%@ page import="be.agenda.LessonHour"%>
<%@ page import="be.agenda.LessonPlaceHolderHour"%>
<%@ page import="be.agenda.ActivityHour"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="main">
<r:require modules="bootstrap-js" />
<g:set var="entityName"
	value="${message(code: 'hour.label', default: 'Uur')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>

</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2"></div>
			<div class="span8">
				<g:form action="search" class="form form-horizontal">
					<div class="control-group">
						<div class="control-label">Leerkracht</div>
						<div class="controls">
							<g:select name="sharedUsers" from="${sharedUsers}" optionKey="id"
								optionValue="displayName" value="${selectedUser.id}" 
								onchange="${remoteFunction(action: 'courses', params: '\'id\' + this.value',
                                 			update: '#courses')}"/>
						</div>
					</div>
					<div class="control-group" id="courses">
						<div class="control-label">Vakken</div>
						<div class="controls">
							<g:select name="courses" from="${be.agenda.Course.findAllByUser(selectedUser)}" optionKey="id"
								optionValue="name"/>
						</div>
					</div>
				</g:form>
			</div>
			<div class="span2"></div>
		</div>
	</div>
</body>
</html>