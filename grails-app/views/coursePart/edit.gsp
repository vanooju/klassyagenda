<!DOCTYPE HTML>

<html>
	<body>
		<g:form action="update" id="${coursePartInstance.id}"	name="coursePartForm">
			<fieldset>
				<legend>Vakonderdeel ${coursePartInstance.course.name} - ${coursePartInstance.name} bewerken</legend>
				
				<g:render template="coursePartForm" bean="${coursePartInstance}" />
				
				<div class="form-actions">
					<g:submitButton name="save" class="btn btn-primary" value="Save" />
				</div>
			</fieldset>
		</g:form>
	</body>
</html>
