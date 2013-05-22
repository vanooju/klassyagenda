<g:if test="${!hourInstance.otherTeacher}">
<div
	class="control-group ${hasErrors(bean:hourInstance,field:'subject','error')}">
	<label for="subject" class="control-label"><g:message
			code="be.agenda.LessonHour.subject.label" /></label>
	<div class="controls">
		<g:textField name="subject" value="${hourInstance.subject}"
			class="input-xxlarge" />
	</div>
	<g:hasErrors bean="${hourInstance}" field="subject">
		<g:eachError var="err" bean="${hourInstance}" field="subject">
			<span class="help-inline"><g:message error="${err}" /></span>
		</g:eachError>
	</g:hasErrors>
</div>

<div class="control-group">
	<label for="objectives" class="control-label"><g:message
			code="be.agenda.LessonHour.objectives.label" /></label>
	<div class="controls">
		<g:textArea name="objectives" value="${hourInstance.objectives}"
			rows="3" class="input-xxlarge" />
	</div>
</div>

<div class="control-group">
	<label for="descriptionBegin" class="control-label"><g:message
			code="be.agenda.LessonHour.descriptionBegin.label" /></label>
	<div class="controls">
		<g:textArea name="descriptionBegin"
			value="${hourInstance.descriptionBegin}" rows="3"
			class="input-xxlarge" />
	</div>
</div>

<div class="control-group">
	<label for="descriptionMiddle" class="control-label"><g:message
			code="be.agenda.LessonHour.descriptionMiddle.label" /></label>
	<div class="controls">
		<g:textArea name="descriptionMiddle"
			value="${hourInstance.descriptionMiddle}" rows="3"
			class="input-xxlarge" />
	</div>
</div>

<div class="control-group">
	<label for="descriptionEnd" class="control-label"><g:message
			code="be.agenda.LessonHour.descriptionEnd.label" /></label>
	<div class="controls">
		<g:textArea name="descriptionEnd"
			value="${hourInstance.descriptionEnd}" rows="3" class="input-xxlarge" />
	</div>
</div>

<div class="control-group">
	<label for="media" class="control-label"><g:message
			code="be.agenda.LessonHour.media.label" /></label>
	<div class="controls">
		<g:textArea name="media" value="${hourInstance.media}" rows="2"
			class="input-xxlarge" />
	</div>
</div>
</g:if>

<g:if test="${hourInstance.otherTeacher}">
	<div
	class="control-group">
	<label for="subject" class="control-label"><g:message
			code="be.agenda.LessonHour.subject.label" /></label>
	<div class="controls">
		<input name="subject" value="${hourInstance.subject}"
			class="input-xxlarge" disabled />
		<g:hiddenField name="subject" value="${hourInstance.subject}" />
	</div>
</div>

<g:hiddenField name="objectives" value="" />
<g:hiddenField name="descriptionBegin" value="" />
<g:hiddenField name="descriptionMiddle" value="" />
<g:hiddenField name="descriptionEnd" value="" />
<g:hiddenField name="media" value="" />
</g:if>

