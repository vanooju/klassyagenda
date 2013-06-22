
<%@ page import="be.agenda.domain.School"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'school.label', default: 'School')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<h1>Scholen</h1>
				<g:if test="${flash.message}">
					<div class="message" role="status">
						${flash.message}
					</div>
				</g:if>
				<ul class="nav nav-list">
					<g:each in="${schoolInstanceList}" status="i" var="schoolInstance">
						<li><g:link action="show" id="${schoolInstance.id}">
								${fieldValue(bean: schoolInstance, field: "name")}
							</g:link></li>
					</g:each>
					<li class="divider"></li>
					<li><g:link class="create" action="create">Nieuwe school aanmaken</g:link></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>
