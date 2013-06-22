<div class="row">
	<div class="well" id="${it.id}">
		<g:if test="${it instanceof be.agenda.domain.LessonHour}">
			<div class="row">
				<div class="span9">
					<div class="page-header"><h1>${it.beginHour} - ${it.endHour}: ${it.title} <small>${it.coursePart.name}</small></h1>
				</div>
				</div>
			</div>
			<div class="row">
				<div class="span8 lead">${it.subject}</div>
			</div>
			
			<div class="row">
				<div class="span2"><span class="label">Lesverloop - Begin</span></div>
				<div class="span6">${it.descriptionBegin}</div>
			</div>
			
			<div class="row">
				<div class="span2"><span class="label">Lesverloop</span></div>
				<div class="span6">${it.descriptionMiddle}</div>
			</div>
			
			<div class="row">
				<div class="span2"><span class="label">Lesverloop - Einde</span></div>
				<div class="span6">${it.descriptionEnd}</div>
			</div>
			
			<div class="row">
				<div class="span2"><span class="label">Doelstellingen</span></div>
				<div class="span6">${it.objectives}</div>
			</div>
			
			<div class="row">
				<div class="span2"><span class="label">Media</span></div>
				<div class="span6">${it.media}</div>
			</div>
		</g:if>
		<g:if test="${it instanceof be.agenda.domain.LessonPlaceHolderHour && !(it instanceof be.agenda.domain.LessonHour)}">
			<div class="row">
				<div class="span9">
					<div class="page-header"><h1>${it.beginHour} - ${it.endHour}: ${it.title}</h1></div>
				</div>
			</div>
			<div class="row">
				<div class="span9">
					<p class="text-info">Deze les is nog niet ingevuld.</p>
				</div>
			</div>
		</g:if>
		<g:if test="${it instanceof be.agenda.domain.ActivityHour}">
			<div class="row">
				<div class="span1"><span class="label">Beschrijving</span></div><div class="span4">${it.description}</div>
			</div>
		</g:if>
		<g:if test="${session.user == it.schoolday.user}">
			<div class="row">
				<div class="span9">
					<g:if test="${it.id}">
						<a class="btn btn-danger btn-small pull-right open-confirm-dialog-id" href="#" data-hour-id="${it.id}" data-toggle="modal" data-target="#myModal">Verwijderen</a>
						<g:link class="btn btn-primary btn-small pull-right" action="edit" id="${it.id}">Bewerken</g:link>
					</g:if>
					<g:else>
						<a class="btn btn-danger btn-small pull-right open-confirm-dialog-index-date" href="#" data-hour-index="${it.beginSlot?.slotIndex}" data-date-year="${it.schoolday.date.format('yyyy')}" data-date-month="${it.schoolday.date.format('MM')}" data-date-day="${it.schoolday.date.format('dd')}" data-toggle="modal" data-target="#myModal">Verwijderen</a>
						<g:link class="btn btn-primary btn-small pull-right" action="create" params="[hourIndex: it.beginSlot?.index, date_year: it.schoolday.date.format('yyyy'), date_month: it.schoolday.date.format('MM'), date_day: it.schoolday.date.format('dd'), date: 'date.struct']">Bewerken</g:link>
					</g:else>
				</div>
			</div>
		</g:if>
	</div>
</div>

