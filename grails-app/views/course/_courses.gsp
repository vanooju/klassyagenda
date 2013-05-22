<li id="Course${it.id}">
	<g:link controller="course" action="delete" id="${it.id}"><i class="icon-trash"></i></g:link>
	<g:link controller="course" action="edit" id="${it.id}">
		${it.name} [${it.user.username}]
	</g:link>
	<small>[<g:link controller="coursePart" action="create" params="['course.id': it.id]">Add CoursePart</g:link>]</small>
	<ul>
		<g:render template="/course/courseParts" collection="${it.courseParts}" />
	</ul>
</li>