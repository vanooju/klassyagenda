<div class="control-group ${hasErrors(bean:it,field:'name','error')}">
<div class="control-label">
	<label for="name">Name</label>
</div>
	<div class="controls">
		<g:textField name="name" value="${it?.name}" autofocus="autofocus" />
		<g:hasErrors bean="${it}" field="name">
			<g:eachError var="err" bean="${it}" field="name">
				<span class="help-inline"><g:message error="${err}" /></span>
			</g:eachError>
		</g:hasErrors>
	</div>
</div>