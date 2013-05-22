<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="span9">

				<g:form action="save">
					<g:render template="form" />
					<div class="control-group">
						<div class="controls">
							<g:submitButton class="btn btn-primary" name="save"
								value="${message(code: 'default.button.create.label', default: 'Create')}" />
						</div>
					</div>
				</g:form>
			</div>
		</div>
	</div>
</body>
</html>