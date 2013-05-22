<!DOCTYPE html>

<html>
<head>
<meta name="layout" content="main">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="span9" id="courses">
				<g:form action="save" name="coursePartForm">
					<legend>
						Nieuw vakonderdeel voor
						${coursePartInstance.course.name}
					</legend>

					<g:hiddenField name="course.id"
						value="${coursePartInstance.course.id}" />

					<g:render template="coursePartForm" />

					<div class="form-actions">
						<g:submitButton name="save" class="btn btn-primary" value="Bewaren" />
						<g:link class="btn" controller="coursePart" action="list" id="${coursePartInstance.course.id}"><g:message code="default.button.cancel.label" default="Annuleren" /></g:link>
					</div>
				</g:form>
			</div>
		</div>
	</div>
</body>
</html>
