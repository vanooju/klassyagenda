
<%@ page import="be.agenda.domain.School"%>
<%@ page import="be.agenda.domain.Role"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'school.label', default: 'School')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<h1>
					${schoolInstance.name}
				</h1>
				<g:link class="list" action="list">Terug naar lijst</g:link>
				<g:if test="${flash.message}">
					<div class="message" role="status">
						${flash.message}
					</div>
				</g:if>
				<h2>School details</h2>
				<g:if test="${schoolInstance?.name}">
					<li class="fieldcontain"><span id="name-label"
						class="property-label"><g:message code="school.name.label"
								default="Name" /></span> <span class="property-value"
						aria-labelledby="name-label"><g:fieldValue
								bean="${schoolInstance}" field="name" /></span></li>
				</g:if>


				<h2>Directeur(s)</h2>
				<g:if
					test="${schoolInstance?.teachers?.findAll { it.authorities.contains(new Role(authority:'ROLE_PRINCIPAL')) }}">
					<ul class="nav nav-list">
						<g:each
							in="${schoolInstance?.teachers?.findAll { it.authorities.contains(new Role(authority:'ROLE_PRINCIPAL')) }}"
							var="t">
							<li><g:link controller="user" action="edit"
									id="${t.id}">
									${t?.firstName}
									${t?.lastName}
								</g:link></li>
						</g:each>
					</ul>
				</g:if>

				<h2>Leerkrachten</h2>
				<g:if
					test="${schoolInstance?.teachers?.findAll { !it.authorities.contains(new Role(authority:'ROLE_PRINCIPAL')) }}">
					<ul class="nav nav-list">
						<g:each
							in="${schoolInstance?.teachers?.findAll { !it.authorities.contains(new Role(authority:'ROLE_PRINCIPAL')) }}"
							var="t">
							<li><g:link controller="user" action="edit"
									id="${t.id}">
									${t?.firstName}
									${t?.lastName}
								</g:link></li>
						</g:each>
					</ul>
				</g:if>
			</div>
		</div>
	</div>
</body>
</html>
