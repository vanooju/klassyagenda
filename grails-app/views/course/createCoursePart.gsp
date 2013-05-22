<!DOCTYPE html>

<html>
	<body>
		<g:form action="saveCoursePart" name="coursePartForm">
			<legend>Nieuw vakonderdeel voor ${coursePartInstance.course.name}</legend>
			<g:render template="coursePartForm" />
			<div class="form-actions">
				<g:submitButton name="save" class="btn btn-primary" value="Save" />
				<g:submitButton class="btn cancel" name="cancel" value="Cancel"
					action="edit" />
			</div>

			<g:javascript src="bootbox.js" />
			<script>
				$('.cancel').click(function(e) {
					e.preventDefault();
					console.log("inside click");
					var currentForm = $(this).parents('form:first');
					console.log("currentForm: " + currentForm)
					bootbox.confirm("Are you sure?", function(confirmed) {
						console.log("bootbox received result: " + confirmed);
						if (confirmed) {
							currentForm.submit();
						}
					});
				});
			</script>
		</g:form>
	</body>
</html>
