<legend>Activiteit</legend>

<g:hiddenField name="type" value="activity"/>

<g:render template="hourForm" />

<div class="control-group">
	<label for="subject" class="control-label">Onderwerp</label>
	<g:field name="subject" type="text" value="${hourInstance.subject}" class="input-xxlarge" />
</div>

<div class="control-group">
	<label for="description" class="control-label">Beschrijving</label>
	<g:textArea name="description" value="${hourInstance.description}" rows="5" class="input-xxlarge" />
</div>