<html>
<body>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-hidden="true">&times;</button>
	<h3>Lesdetail</h3>
</div>
<div class="modal-body">
	<div class="row-fluid">
		<div class="span4" style="text-align:right"><strong>Datum</strong></div>
		<div class="span8 text-info">${it.schoolday.date.format("EEEE dd/MM/yyyy")}</div>
	</div>
	<div class="row">
		<div class="span4" style="text-align:right"><strong>Vak</strong></div>
		<div class="span8 text-info">${it.coursePart.course.name}</div>
	</div>
	<div class="row">
		<div class="span4" style="text-align:right"><strong>Vakonderdeel</strong></div>
		<div class="span8 text-info">${it.coursePart.name}</div>
	</div>
	<div class="row">
		<div class="span4" style="text-align:right"><strong>Onderwerp</strong></div>
		<div class="span8 text-info">${it.subject}</div>
	</div>
	<div class="row">
		<div class="span4" style="text-align:right"><strong>Lesverloop - Begin</strong></div>
		<div class="span8 text-info">${it.descriptionBegin}</div>
	</div>
	<div class="row">
		<div class="span4" style="text-align:right"><strong>Lesverloop</strong></div>
		<div class="span8 text-info">${it.descriptionMiddle}</div>
	</div>
	<div class="row">
		<div class="span4" style="text-align:right"><strong>Lesverloop - Einde</strong></div>
		<div class="span8 text-info">${it.descriptionEnd}</div>
	</div>
	<div class="row">
		<div class="span4" style="text-align:right"><strong>Doelstellingen</strong></div>
		<div class="span8 text-info">${it.objectives}</div>
	</div>
	<div class="row">
		<div class="span4" style="text-align:right"><strong>Media</strong></div>
		<div class="span8 text-info">${it.media}</div>
	</div>
</div>
<div class="modal-footer">
	<a href="#" data-dismiss="modal" class="btn">Close</a>
	<g:remoteLink url="[controller: 'lesson', action: 'searchModal']"
			update="lessonSearchModalContents"
			method="post" class="btn"
			params="['course.id': selectedCourse?.id, 'coursePart.id': selectedCoursePart?.id, subject: subject, hourId: hourId, hourIndex: hourIndex, beginSlot: beginSlot, endSlot: endSlot, selectedDate_day: selectedDate?.format('dd'), selectedDate_month: selectedDate?.format('MM'), selectedDate_year: selectedDate?.format('yyyy'), selectedDate: 'date.struct']">Terug naar lijst</g:remoteLink>
	<g:if test="${hourId && hourId != 'null'}">
		<g:link class="btn btn-primary" method="get" action="edit" controller="schoolday" params="[copylesson: it.id, date_day: selectedDate?.format('dd'), date_month: selectedDate?.format('MM'), date_year: selectedDate?.format('yyyy'), date: 'date.struct']" id="${hourId}">Invoegen</g:link>
	</g:if>
	<g:else>
		<g:link class="btn btn-primary" method="get" action="create" controller="schoolday" params="[copylesson: it.id, date_day: selectedDate?.format('dd'), date_month: selectedDate?.format('MM'), date_year: selectedDate?.format('yyyy'), date: 'date.struct', hourIndex: hourIndex]">Invoegen</g:link>
	</g:else>
</div>
</body>
</html>