<%@ page import="be.agenda.Course" %>

<label for="beginHour">Beginuur</label>	
<g:if test="$hourInstance.id}">		
	<g:select name="beginSlot.id"
    		  from="${beginSlots}"
    		  optionKey="id"
    		  optionValue="beginHour"
    		  value="${hourInstance.beginSlot.id}" 
    		  onchange="${remoteFunction(action:'updateEndSlot',update:'endSlot',params:"'beginSlot=' + this.value + '&hourId=${hourInstance.id}'")}"/>
</g:if>
<g:else>		
	<g:select name="beginSlot.id"
    		  from="${beginSlots}"
    		  optionKey="id"
    		  optionValue="beginHour"
    		  value="${hourInstance.beginSlot.id}" 
    		  onchange="${remoteFunction(action:'updateEndSlot',update:'endSlot',params:"'beginSlot=' + this.value + '&dayId=${dayInstance.id}'")}"/>
</g:else> 
<label for="endHour">Einduur</label>	
<g:select name="endSlot.id"
   		  from="${endSlots}"
   		  optionKey="id"
   		  optionValue="endHour"
   		  value="${hourInstance.endSlot.id}" /> 

<label for="course">Vak</label>
<g:select name="course" from="${Course.findAll(sort:'name')}" optionKey="id" optionValue="name" value="${hourInstance.course?.id}" noSelection="[null:'-Kies een vak-']" />