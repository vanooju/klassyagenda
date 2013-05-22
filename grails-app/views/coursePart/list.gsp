<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:if test="${flash.courseId != null}">
	<script> 
				$(document).ready(function() {
					$("#Course${flash.courseId}
		").effect("highlight", {
				color : '#d9edf7'
			}, 3000);
		});
	</script>
</g:if>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="span9" id="courses">
				<p>
					<g:link controller="course" action="list" id="${courseInstance.id}">Terug naar vakken</g:link>
				</p>

				<h3>
					${courseInstance.name}
					vakonderdelen (${courseInstance.courseParts.size()})
				</h3>

				<p>

					<g:link controller="coursePart" action="create"
						update="coursepart-form" params="['course.id': courseInstance.id]">Nieuw vakonderdeel</g:link>
				</p>

				<div id="coursePartPagination">
					<g:render template="coursePartPagination"
						collection="${courseParts}" />
				</div>

				<g:paginate controller="coursePart" action="list"
					id="${courseInstance.id}"
					total="${courseInstance.courseParts.size()}" />
			</div>
			<div class="span9" id="courseParts"></div>
		</div>
	</div>
</body>
</html>