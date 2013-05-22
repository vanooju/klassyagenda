<!DOCTYPE html>
<html>
	<body>
		<g:form action="save">
			<g:render template="form" />
			<div class="control-group">
				<div class="controls">
					<g:submitButton class="btn btn-primary" name="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</div>
			</div>
		</g:form>
	</body>
</html>