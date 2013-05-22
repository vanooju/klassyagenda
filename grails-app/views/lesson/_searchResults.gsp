<html>
	<body>
		<ul class="nav nav-list">
			<g:each var="lesson" in="${lessons}" status="index">
 				<li>
 					<!--  hier nog params toevoegen -->
 					<g:remoteLink action="showModal" 
 							      controller="lesson" 
 							      id="${lesson.id}" 
 							      update="lessonSearchModalContents"
 							      params="['course.id': lesson?.course?.id, 
 							      	       'coursePart.id': lesson?.coursePart?.id, 
 							      	       subject: subject,
 							      	       selectedDate_day: selectedDate?.format('dd'), 
 							      	       selectedDate_month: selectedDate?.format('MM'), 
 							      	       selectedDate_year: selectedDate?.format('yyyy'), 
 							      	       selectedDate: 'date.struct',
 							      	       hourIndex: hourIndex,
 							      	       hourId: hourId]">
 						(<g:formatDate date="${lesson.schoolday.date}" />) ${lesson.course.name} - ${lesson.coursePart.name}: ${lesson.subject}
 					</g:remoteLink>
 				</li>
			</g:each>
		</ul>
	</body>
</html>