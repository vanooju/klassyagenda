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
						<div class="form-actions">
							<g:submitButton class="btn btn-primary" name="save"
								value="${message(code: 'default.button.create.label', default: 'Aanmaken')}" />
							<g:link class="btn" controller="course" action="list"><g:message code="default.button.cancel.label" default="Annuleren" /></g:link> 								
						</div>
					</div>
				</g:form>
			</div>
		</div>
	</div>
</body>
</html>