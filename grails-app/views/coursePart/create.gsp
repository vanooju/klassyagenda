<!DOCTYPE html>

<html>
	<body>
		<g:form action="save" name="coursePartForm">
			<legend>Nieuw vakonderdeel voor ${coursePartInstance.course.name}</legend>

			<g:hiddenField name="course.id" value="${coursePartInstance.course.id}" />
			
			<g:render template="coursePartForm" />
			
			<div class="form-actions">
				<g:submitButton name="save" class="btn btn-primary" value="Save" />
			</div>
		</g:form>
	</body>
</html>
