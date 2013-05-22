<html>
	<body>
		  <div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		    <h3>Lessen zoeken</h3>
		  </div>
		  <div class="modal-body">
			<g:if test="${searchResult}">
			  	<g:render template="/lesson/searchResults" model="[lessons: searchResult?.results]"/>
			</g:if>
			<g:else>
				<p class="text-info">Geen lessen gevonden.</p>
			</g:else>
		  </div>
			<div class="modal-footer">
				<a href="#" data-dismiss="modal" class="btn">Close</a>
				<g:remoteLink update="lessonSearchModalContents" controller="lesson" action="searchModal" class="btn btn-primary" params="['course.id': selectedCourse?.id, 'coursePart.id': selectedCoursePart?.id, subject: subject, selectedDate_day: selectedDate?.format('dd'), selectedDate_month: selectedDate?.format('MM'), selectedDate_year: selectedDate?.format('yyyy'), selectedDate: 'date.struct', hourIndex: hourIndex, hourId: hourId, selectedSchedule: selectedSchedule]" method="get">Opnieuw zoeken</g:remoteLink>
			</div>
	</body>
</html>