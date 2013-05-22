<%@ page import="be.agenda.LessonHour"%>

<li>
	<g:if test="${LessonHour.countByCoursePart(it) == 0}">
		<g:link controller="coursePart" action="delete" id="${it.id}">
			<i class="icon-trash"></i>
		</g:link>
	</g:if>
	<g:link controller="coursePart" action="edit" id="${it.id}">
		${it.name}
	</g:link> (${LessonHour.countByCoursePart(it)} Lessen)
</li>