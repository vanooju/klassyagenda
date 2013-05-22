<g:if test="${it instanceof be.agenda.LessonHour}">
	<section id="hour_${it?.beginSlot.slotIndex}">
		<h2>
			<g:if test="${session.user == it.schoolday.user}">
				<g:if test="${it.id}">
					<a class="btn btn-danger open-confirm-dialog-id" href="#"
						data-hour-id="${it.id}" data-toggle="modal" data-target="#myModal"><i
						class="icon-trash icon-white"></i></a>
					<g:link class="btn" action="edit" id="${it.id}" title="Bewerken">
						<i class="icon-edit"></i>
					</g:link>
				</g:if>
				<g:else>
					<a class="btn btn-danger open-confirm-dialog-index-date" href="#"
						data-hour-index="${it.beginSlot?.slotIndex}"
						data-date-year="${it.schoolday.date.format('yyyy')}"
						data-date-month="${it.schoolday.date.format('MM')}"
						data-date-day="${it.schoolday.date.format('dd')}"
						data-toggle="modal" data-target="#myModal" title="Verwijderen"><i
						class="icon-trash icon-white"></i></a>
					<g:link class="btn " action="create"
						params="[hourIndex: it.beginSlot?.slotIndex, date_year: it.schoolday.date.format('yyyy'), date_month: it.schoolday.date.format('MM'), date_day: it.schoolday.date.format('dd'), date: 'date.struct']"
						title="Bewerken">
						<i class="icon-edit"></i>
					</g:link>
				</g:else>
			</g:if>
			${it.beginHour}
			-
			${it.endHour}:
			${it.title}
			<small> ${it.coursePart.name}
			</small>
		</h2>
		<div class="row lead">
			<div class="span3"></div>
			<div class="span6">
				${it.subject}
			</div>
		</div>

		<g:if test="${!it.otherTeacher}">
			<g:if
				test="${it.schoolday.user.enabledFields.contains('objectives')}">
				<div class="row">
					<div class="span3" style="text-align: right">
						<strong>Doelstellingen</strong>
					</div>
					<div class="span9 ${it.objectives == '' ? 'muted' : ''}">
						${it.objectives.replaceAll("\n", "<br />") ?: "Niet ingevuld"}
					</div>
				</div>
			</g:if>
			<g:if
				test="${it.schoolday.user.enabledFields.contains('descriptionBegin')}">
				<div class="row">
					<div class="span3" style="text-align: right">
						<strong>Lesverloop - Begin</strong>
					</div>
					<div class="span8 ${it.descriptionBegin == '' ? 'muted' : ''}">
						${it.descriptionBegin.replaceAll("\n", "<br />") ?: "Niet ingevuld"}
					</div>
				</div>
			</g:if>

			<g:if
				test="${it.schoolday.user.enabledFields.contains('descriptionMiddle')}">
				<div class="row">
					<div class="span3" style="text-align: right">
						<strong>Lesverloop</strong>
					</div>
					<div class="span9 ${it.descriptionMiddle == '' ? 'muted' : ''}">
						${it.descriptionMiddle.replaceAll("\n", "<br />") ?: "Niet ingevuld"}
					</div>
				</div>
			</g:if>

			<g:if
				test="${it.schoolday.user.enabledFields.contains('descriptionEnd')}">
				<div class="row">
					<div class="span3" style="text-align: right">
						<strong>Lesverloop - Einde</strong>
					</div>
					<div class="span9 ${it.descriptionEnd == '' ? 'muted' : ''}">
						${it.descriptionEnd.replaceAll("\n", "<br />") ?: "Niet ingevuld"}
					</div>
				</div>
			</g:if>

			<g:if test="${it.schoolday.user.enabledFields.contains('media')}">
				<div class="row">
					<div class="span3" style="text-align: right">
						<strong>Media</strong>
					</div>
					<div class="span9 ${it.media == '' ? 'muted' : ''}">
						${it.media.replaceAll("\n", "<br />") ?: "Niet ingevuld"}
					</div>
				</div>
			</g:if>
		</g:if>
	</section>
</g:if>

<g:if
	test="${it instanceof be.agenda.LessonPlaceHolderHour && !(it instanceof be.agenda.LessonHour)}">
	<section id="hour_${it?.beginSlot.slotIndex}">
		<h2>
			<g:if test="${session.user == it.schoolday.user}">
				<g:if test="${it.id}">
					<a class="btn btn-danger open-confirm-dialog-id" href="#"
						data-hour-id="${it.id}" data-toggle="modal" data-target="#myModal"
						title="Verwijderen"><i class="icon-trash icon-white"></i></a>
					<g:link class="btn" action="edit" id="${it.id}" title="Bewerken">
						<i class="icon-edit"></i>
					</g:link>
				</g:if>
				<g:else>
					<a class="btn btn-danger open-confirm-dialog-index-date" href="#"
						data-hour-index="${it.beginSlot?.slotIndex}"
						data-date-year="${it.schoolday.date.format('yyyy')}"
						data-date-month="${it.schoolday.date.format('MM')}"
						data-date-day="${it.schoolday.date.format('dd')}"
						data-toggle="modal" data-target="#myModal"><i
						class="icon-trash icon-white" title="Verwijderen"></i></a>
					<g:link class="btn" action="create"
						params="[hourIndex: it.beginSlot?.slotIndex, date_year: it.schoolday.date.format('yyyy'), date_month: it.schoolday.date.format('MM'), date_day: it.schoolday.date.format('dd'), date: 'date.struct']"
						title="Bewerken">
						<i class="icon-edit"></i>
					</g:link>
				</g:else>
			</g:if>
			${it.beginHour}
			-
			${it.endHour}:
			${it.title}
			<small><em> Nog niet ingevuld</em> </small>

		</h2>
	</section>
</g:if>
<g:if test="${it instanceof be.agenda.ActivityHour}">
	<section id="hour_${it?.beginSlot.slotIndex}">
		<h2>
			<g:if test="${session.user == it.schoolday.user}">
				<g:if test="${it.id}">
					<a class="btn btn-danger open-confirm-dialog-id" href="#"
						data-hour-id="${it.id}" data-toggle="modal" data-target="#myModal"><i
						class="icon-trash icon-white"></i></a>
					<g:link class="btn" action="edit" id="${it.id}" title="Bewerken">
						<i class="icon-edit"></i>
					</g:link>
				</g:if>
				<g:else>
					<a class="btn btn-danger open-confirm-dialog-index-date" href="#"
						data-hour-index="${it.beginSlot?.slotIndex}"
						data-date-year="${it.schoolday.date.format('yyyy')}"
						data-date-month="${it.schoolday.date.format('MM')}"
						data-date-day="${it.schoolday.date.format('dd')}"
						data-toggle="modal" data-target="#myModal" title="Verwijderen"><i
						class="icon-trash icon-white"></i></a>
					<g:link class="btn " action="create"
						params="[hourIndex: it.beginSlot?.slotIndex, date_year: it.schoolday.date.format('yyyy'), date_month: it.schoolday.date.format('MM'), date_day: it.schoolday.date.format('dd'), date: 'date.struct']"
						title="Bewerken">
						<i class="icon-edit"></i>
					</g:link>
				</g:else>
			</g:if>
			${it.beginHour}
			-
			${it.endHour}:
			${it.subject}
		</h2>
		<div class="row">
			<div class="span3" style="text-align: right">
				<strong>Beschrijving</strong>
			</div>
			<div class="span9 ${it.description == '' ? 'muted' : ''}">
				${it.description.replaceAll("\n", "<br />") ?: "Niet ingevuld"}
			</div>
		</div>
	</section>
</g:if>