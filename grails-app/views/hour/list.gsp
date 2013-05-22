<g:each in="${hourInstance.day.hours}" var="hour">
	<p>${hour.beginHour}-${hour.endHour}: ${hour.course}</p>
</g:each>
<g:unless test="${hourInstance.day.hours}"> 
   <p class="well text-info"><small>Nog geen uren ingevuld.<br />Voeg uren toe aan deze dag...</small></p> 
</g:unless> 
<g:if test="${schooldayInstance.id == null}">
	<g:remoteLink action="create" update="hours" params="${[dateText:schooldayInstance.date.format("dd/MM/yyyy")]}">Dag aanmaken</g:remoteLink>
</g:if>
<g:else>
	<g:remoteLink controller="hour" action="create" update="hours" id="${[id:schooldayInstance.id]}">Nieuw lesuur</g:remoteLink>
</g:else>