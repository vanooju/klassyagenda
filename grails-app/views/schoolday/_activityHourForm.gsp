<legend>Activiteit</legend>

<g:hiddenField name="type" value="activity" />

<g:render template="hourForm" />

<div
	class="control-group ${hasErrors(bean:hourInstance,field:'subject','error')}">
	<label for="subject" class="control-label"><g:message code="activityHour.subject.label"/> </label>
	<div class="controls form-inline">
		<g:field name="subject" type="text" value="${hourInstance.subject}"
			class="input-xxlarge" />
		<g:hasErrors bean="${hourInstance}" field="subject">
			<g:eachError var="err" bean="${hourInstance}" field="subject">
				<span class="help-block"><g:message error="${err}" /></span>
			</g:eachError>
		</g:hasErrors>
	</div>
</div>

<div class="control-group">
	<label for="description" class="control-label"><g:message code="activityHour.description.label" /></label>
	<div class="controls form-inline">
		<g:textArea name="description" value="${hourInstance.description}"
			rows="5" class="input-xxlarge" />
	</div>
</div>