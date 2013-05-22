<!DOCTYPE HTML>

<html>
<head>
<meta name="layout" content="main">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="span9">
				<g:form action="update" id="${coursePartInstance.id}"
					name="coursePartForm">
					<fieldset>
						<legend>
							Vakonderdeel
							${coursePartInstance.course.name}
							-
							${coursePartInstance.name}
							bewerken
						</legend>

						<g:render template="coursePartForm" bean="${coursePartInstance}" />

						<div class="form-actions">
							<g:submitButton name="save" class="btn btn-primary" value="Save" />
							<g:link class="btn" controller="coursePart" action="list"
								id="${coursePartInstance.course.id}">
								<g:message code="default.button.cancel.label"
									default="Annuleren" />
							</g:link>
						</div>
					</fieldset>
				</g:form>
			</div>
		</div>
	</div>
</body>
</html>
