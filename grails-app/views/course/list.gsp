<%@ page import="be.agenda.LessonHour"%>

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
			<h3>Vakken (${courses.size()})</h3>
			
			<p><g:link controller="course" action="create">Nieuw vak</g:link></p>
			
			<g:each in="${courses}" var="${course}">
			<li>
				<g:if test="${LessonHour.countByCourse(course) == 0}">
					<g:link controller="course" action="delete" id="${course.id}"><i class="icon-trash"></i></g:link>
				</g:if>
				<g:link controller="course" action="edit" id="${course.id}"><i class="icon-edit"></i></g:link>
				<g:link controller="coursePart" action="list" id="${course.id}" title="Vakonderdelen tonen" params="[offset: 0, max: 20]">
					${course.name }
				</g:link>
				(${LessonHour.countByCourse(course)} Lessen)
			</li>
			</g:each>
		</div>
		<div class="span9" id="courseParts">
		</div>
	</div>
	</div>
</body>
</html>