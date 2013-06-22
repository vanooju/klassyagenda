<%@ page import="be.agenda.domain.School" %>



<div class="fieldcontain ${hasErrors(bean: schoolInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="school.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${schoolInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: schoolInstance, field: 'teachers', 'error')} ">
	<label for="teachers">
		<g:message code="school.teachers.label" default="Teachers" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${schoolInstance?.teachers?}" var="t">
    <li><g:link controller="applicationUser" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="applicationUser" action="create" params="['school.id': schoolInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'applicationUser.label', default: 'ApplicationUser')])}</g:link>
</li>
</ul>

</div>

