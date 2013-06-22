<%@ page import="be.agenda.domain.Schoolday" %>

<div class="fieldcontain ${hasErrors(bean: it, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="schoolday.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<div class="input-append date datepicker" id="dp3" data-date="${it.schooldate?.format("dd/MM/yyyy")}" data-date-format="dd/mm/yyyy">
	  <g:textField name="schooldate" class="span2" size="16" type="text" value="${it.schooldate?.format("dd/MM/yyyy")}"/>
	  <span class="add-on"><i class="icon-th"></i></span>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: it, field: 'hours', 'error')} ">
	<label for="hours">
		<g:message code="schoolday.hours.label" default="Hours" />		
	</label>
	
	<ul class="one-to-many">
		<g:each in="${it?.hours?}" var="h">
		    <li><g:link controller="hour" action="show" id="${h.id}">${h?.encodeAsHTML()}</g:link></li>
		</g:each>
		<li class="add">
			<g:link controller="hour" action="create" params="['schoolday.id': it?.id]">${message(code: 'default.add.label', args: [message(code: 'hour.label', default: 'Hour')])}</g:link>
		</li>
	</ul>
</div>