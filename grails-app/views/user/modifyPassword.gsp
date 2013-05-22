<!doctype html>
<html>
<head>
<meta name="layout" content="main">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="span12">
				<g:form name="modifyPasswordForm" class="form-horizontal" action="modifyPassword"
					controller="user" id="${selectedUser.id}">
					<fieldset>
						<legend>
							${selectedUser.firstName} ${selectedUser.lastName} - Paswoord wijzigen
						</legend>

						<g:render template="passwordForm" bean="${selectedUser}" />

						<div class="control-group">
							<div class="controls">
								<g:submitButton class="btn" name="cancel" value="Annuleren" />
								<g:submitButton class="btn btn-primary" name="submit"
									value="Wijzigen" />
							</div>
						</div>
					</fieldset>
				</g:form>
			</div>
		</div>
	</div>
</body>
</html>
