<html>
<body>
	<g:renderErrors/>
	
	<div class="control-group ${hasErrors(bean:coursePartInstance,field:'name','error')}">
		<label for="name">Name</label>
		<g:textField name="name" value="${coursePartInstance.name}"
				     autofocus="autofocus" />
		<g:hasErrors bean="${coursePartInstance}" field="name">
			<g:eachError var="err" bean="${coursePartInstance}" field="name">
	     		<span class="help-inline"><g:message error="${err}" /></span>
	 		</g:eachError>
		</g:hasErrors>	
	</div>
	
	<!--g:javascript src="bootbox.js" />
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
	</script-->

</body>
</html>