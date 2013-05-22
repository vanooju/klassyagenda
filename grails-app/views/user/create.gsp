<%@ page import="be.agenda.Schoolday"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="main">
</head>
<body>
	<div class="row">
		<div class="span12">
			<g:form class="form-horizontal" name="userForm" action="save"
				controller="user">
				<g:hasErrors bean="${user}">
            		<div class="errors">
                		<g:renderErrors bean="${user}" as="list" />
            		</div>
				</g:hasErrors>
	
				<g:render template="userForm" bean="${user}" />
				
				<g:render template="passwordForm" bean="${user}" />

				<div class="control-group">
					<div class="controls">
						<button type="submit" class="btn btn-primary">Registreren</button>
					</div>
				</div>

			</g:form>
		</div>
	</div>
</body>
</html>
