<div class="control-group">
	<label for="beginSlot" class="control-label"><g:message code="be.agenda.Hour.slot.label" /></label>
	<div class="controls form-inline">	
	
		<g:if test="${hourInstance.id}">		
			<g:select name="beginSlot.id"
		    		  from="${hourInstance.availableSlots}"
		    		  optionKey="id"
		    		  optionValue="beginHour"
		    		  value="${hourInstance.beginSlot?.id}" 
		    		  onchange="${remoteFunction(action:'updateEndSlot',update:'endSlot',params:"'beginSlot=' + this.value + '&hourId=${hourInstance.id}'")}"
		    		  class="input-small" 
		    		  id="beginSlot" />
		</g:if>
		<g:else>		
			<g:select name="beginSlot.id"
		    		  from="${hourInstance.availableSlots}"
		    		  optionKey="id"
		    		  optionValue="beginHour"
		    		  value="${hourInstance.beginSlot?.id}" 
		    		  onchange="${remoteFunction(action:'updateEndSlot',update:'endSlot',params:"'beginSlot=' + this.value + '&date_year=${hourInstance.schoolday.date.format("yyyy")}&date_month=${hourInstance.schoolday.date.format("MM")}&date_day=${hourInstance.schoolday.date.format("dd")}'")}"
		    		  class="input-small" 
		    		  id="beginSlot" />
		</g:else> 
		<g:select name="endSlot.id"
				  id="endSlot"
		   		  from="${hourInstance.appropriateEndSlots}"
		   		  optionKey="id"
		   		  optionValue="endHour"
		   		  value="${hourInstance.endSlot?.id}" 
		   		  class="input-small"/>
	</div>
</div>   	 
