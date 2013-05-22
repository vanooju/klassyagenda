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
						<g:submitButton name="save" class="btn btn-primary" value="Save" />
					</div>
				</g:form>
			</div>
		</div>
	</div>
</body>
</html>
