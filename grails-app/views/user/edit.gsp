<!doctype html>
<html>
<head>
<meta name="layout" content="main">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="span12">
				<g:if test="${flash.message}">
					<div class="alert alert-info">${flash.message}</div>
				</g:if>
				
				<g:form name="userForm" class="form-horizontal" action="update"
					controller="user" id="${selectedUser.id}">
					<fieldset>
						<legend>
							${selectedUser.firstName}
							${selectedUser.lastName}
						</legend>

						<g:render template="userForm" bean="${selectedUser}" />

						<div class="control-group">
							<div class="control-label"></div>
							<div class="controls">
								<label class="checkbox"><input type="checkbox"
									name="enabledFields" value="descriptionBegin"
									${selectedUser.enabledFields?.contains('descriptionBegin') ? 'checked' : '' } />Lesverloop
									- Begin</label> <label class="checkbox"><input type="checkbox"
									name="enabledFields" value="descriptionMiddle"
									${selectedUser.enabledFields?.contains('descriptionMiddle') ? 'checked' : '' } />Lesverloop</label>
								<label class="checkbox"><input type="checkbox"
									name="enabledFields" value="descriptionEnd"
									${selectedUser.enabledFields?.contains('descriptionEnd') ? 'checked' : '' } />Lesverloop
									- Einde</label> <label class="checkbox"><input type="checkbox"
									name="enabledFields" value="objectives"
									${selectedUser.enabledFields?.contains('objectives') ? 'checked' : '' } />Doelstellingen</label>
								<label class="checkbox"><input type="checkbox"
									name="enabledFields" value="media"
									${selectedUser.enabledFields?.contains('media') ? 'checked' : '' } />Media</label>
							</div>
						</div>
						
						<div class="control-group">
							<div class="controls">
								<g:link action="modifyPassword" id="${selectedUser.id}">Paswoord wijzigen</g:link>
							</div>
						</div>
						
						<div class="control-group">
							<div class="controls">
								<g:submitButton class="btn" name="cancel" value="Annuleren" />
								<g:submitButton class="btn btn-primary" name="submit"
									value="Bewaren" />
							</div>
						</div>
					</fieldset>
				</g:form>
			</div>
		</div>
	</div>
</body>
</html>
