<table width="100%" class="schedule">
	<caption>
		<h1>
			Schooljaar
			${scheduleInstance.schoolyear}
		</h1>
	</caption>
	<thead>
		<tr>
			<th class="schedule">Uur</th>
			<g:each in="${scheduleInstance.days}" var="day">
				<th class="schedule">
					${day}
				</th>
			</g:each>
		</tr>
	</thead>
	<tbody>
		<g:each in="${scheduleInstance.slots}" var="slot" status="index">
			<g:if test="${index > 0 && slot.beginHour != scheduleInstance.slots[index-1].endHour}">
				<tr>
					<td class="schedule-slot">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</g:if>
			<tr>
				<td class="schedule-slot">
					${slot}
				</td>
				<g:each in="${scheduleInstance.days}" var="day">
					<td class="schedule-cell"
						style="${day.hourForSlot(slot)?.beginSlot?.slotIndex == slot?.slotIndex ? 'border-top: 1px solid black;' : ''} ${day.hourForSlot(slot)?.endSlot?.slotIndex == slot?.slotIndex ? 'border-bottom: 1px solid black;' : ''} ${day.hourForSlot(slot) ? 'background-color: #ffffe3;' : ''}">
						<g:if
							test="${day.hourForSlot(slot)?.beginSlot?.slotIndex == slot?.slotIndex}">
							${day.hourForSlot(slot)?.course}
							<g:if test="${day.hourForSlot(slot)}">
								<g:link action="delete" id="${day.hourForSlot(slot)?.id}">
									<i class="icon-trash"></i>
								</g:link>
							</g:if>
						</g:if>
					</td>
				</g:each>
			</tr>
		</g:each>
		<tr class="info">
			<td />
			<g:each in="${scheduleInstance.days}" var="day">
				<td style="text-align: center">
					<g:if test="${day.countAvailableSlots() > 0}">
						<g:link action="create"
							class="btn btn-mini btn-primary"
							params="['day.id': day.id, scheduleId: scheduleInstance.id]">
							<i class="icon-plus-sign icon-white"></i>
							<g:message code="add.label" />
						</g:link>
					</g:if>
				</td>
			</g:each>
		</tr>
	</tbody>
</table>