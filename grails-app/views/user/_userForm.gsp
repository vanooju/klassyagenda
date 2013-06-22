<%@ page import="be.agenda.domain.Role" %>

<div
	class="control-group ${hasErrors(bean:it,field:'lastName','error')}">
	<div class="control-label">Naam</div>
	<div class="controls">
		<g:textField name="lastName" value="${it?.lastName}"
			autofocus="autofocus" />
		<g:hasErrors bean="${it}" field="lastName">
			<g:eachError var="err" bean="${it}" field="lastName">
				<span class="help-inline"><g:message error="${err}" /></span>
			</g:eachError>
		</g:hasErrors>
	</div>
</div>

<div
	class="control-group ${hasErrors(bean:it,field:'firstName','error')}">
	<div class="control-label">Voornaam</div>
	<div class="controls">
		<g:textField name="firstName" value="${it?.firstName}" />
		<g:hasErrors bean="${it}" field="firstName">
			<g:eachError var="err" bean="${it}" field="firstName">
				<span class="help-inline"><g:message error="${err}" /></span>
			</g:eachError>
		</g:hasErrors>
	</div>
</div>

<div
	class="control-group ${hasErrors(bean:it,field:'emailAddress','error')}">
	<div class="control-label">Emailadres</div>
	<div class="controls">
		<g:textField name="emailAddress" value="${it?.emailAddress}" />
		<g:hasErrors bean="${it}" field="emailAddress">
			<g:eachError var="err" bean="${it}" field="emailAddress">
				<span class="help-inline"><g:message error="${err}" /></span>
			</g:eachError>
		</g:hasErrors>
	</div>
</div>

<div
	class="control-group ${hasErrors(bean:it,field:'username','error')}">
	<div class="control-label">Gebruikersnaam</div>
	<div class="controls">
		<g:textField name="username" value="${it?.username}" />
		<g:hasErrors bean="${it}" field="username">
			<g:eachError var="err" bean="${it}" field="username">
				<span class="help-inline"><g:message error="${err}" /></span>
			</g:eachError>
		</g:hasErrors>
	</div>
</div>

<div class="control-group">
	<div class="control-label">School</div>
	<div class="controls">
		<g:select class="input-xlarge" name="school.id"
			from="${be.agenda.domain.School.findAll()}" optionKey="id"
			optionValue="name" />
	</div>
</div>