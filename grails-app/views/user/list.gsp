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
				<h3>Leerkrachten</h3>

				<g:each in="${users}" var="${user}">
					<li><g:link action="show" controller="schoolday"
							params="[userid: user.id]">
							${user.firstName}
							${user.lastName}
						</g:link> - Laatste keer aangemeld op ${user.lastLoginDate}</li>
				</g:each>
			</div>
		</div>
	</div>
</body>
</html>
