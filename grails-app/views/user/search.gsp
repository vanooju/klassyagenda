<%@ page import="be.agenda.Schoolday"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'schoolday.label', default: 'Schoolday')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="span12" id="users">
				<g:form action="search">
					<g:textField name="name" value="${params.name}" />
				</g:form>
			
				<h3>Leerkrachten</h3>

				<g:each in="${results}" var="${user}">
					<li>
							${user.firstName}
							${user.lastName}
						- ${user.school.name}
						<g:render template="share" bean="${user}" />
					</li>
				</g:each>
			</div>
		</div>
	</div>
</body>
</html>
