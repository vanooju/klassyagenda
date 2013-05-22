<!DOCTYPE html>
<html>
	<body>
		<g:form action="save">
			<legend>Vak</legend>
			<g:hiddenField name="id" value="${courseInstance?.id}"/>
			<g:render template="form" bean="${courseInstance}" />
			<div class="control-group">
				<div class="controls">
					<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</div>
			</div>
		</g:form>
	</body>
</html>