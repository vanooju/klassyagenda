<%@ page import="be.agenda.Course" %>

<div class="control-group ${hasErrors(bean:hourInstance, field:'beginSlot', 'error')}">
		<label for="beginHour">Beginuur</label>	
		<g:if test="$hourInstance.id}">		
			<g:select name="beginSlot"
		    		  from="${dayInstance.availableSlots(hourInstance)}"
		    		  optionKey="id"
		    		  optionValue="beginHour"
		    		  value="${hourInstance.beginSlot?.id}" 
		    		  onchange="${remoteFunction(action:'updateEndSlot',update:'endSlot',params:"'beginSlot=' + this.value + '&hourId=${hourInstance.id}'")}"/>
		</g:if>
		<g:else>		
			<g:select name="beginSlot"
		    		  from="${dayInstance.availableSlots(hourInstance)}"
		    		  optionKey="id"
		    		  optionValue="beginHour"
		    		  value="${hourInstance.beginSlot?.id}" 
		    		  onchange="${remoteFunction(action:'updateEndSlot',update:'endSlot',params:"'beginSlot=' + this.value + '&dayId=${dayInstance.id}'")}"/>
		</g:else>
		<g:hasErrors bean="${hourInstance}" field="beginSlot">
			<span class="help-inline">
				<g:eachError bean="${hourInstance}" field="beginSlot">
	    			<g:message error="${it}" />
	    		</g:eachError>
	    	</span>
    	</g:hasErrors>
</div>	
<div class="control-group ${hasErrors(bean:hourInstance, field:'endSlot', 'error')}">	 
		<label for="endHour">Einduur</label>	
		<g:select name="endSlot"
	    		  from="${dayInstance.appropriateEndSlotsFor(hourInstance)}"
	    		  optionKey="id"
	    		  optionValue="endHour"
	    		  value="${hourInstance.endSlot?.id}" /> 
	    
		<g:hasErrors bean="${hourInstance}" field="endSlot">
			<span class="help-inline">
				<g:eachError bean="${hourInstance}" field="endSlot">
	    			<g:message error="${it}" />
	    		</g:eachError>
	    	</span>
    	</g:hasErrors>
</div>
<div class="control-group ${hasErrors(bean:hourInstance, field:'subject', 'error')}">
	<label for="course">Onderwerp</label>
	<g:textField name="subject" value="${hourInstance.subject}"/>
	<g:hasErrors bean="${hourInstance}" field="subject">
		<span class="help-inline">
			<g:eachError bean="${hourInstance}" field="subject">
    			<g:message error="${it}" />
    		</g:eachError>
    	</span>
   	</g:hasErrors>
</div>
<div class="control-group ${hasErrors(bean:hourInstance, field:'description', 'error')}">
	<label for="course">Beschrijving</label>
	<g:textArea name="description" value="${hourInstance.description}" rows="10" cols="80" />
	<g:hasErrors bean="${hourInstance}" field="description">
		<span class="help-inline">
			<g:eachError bean="${hourInstance}" field="description">
    			<g:message error="${it}" />
    		</g:eachError>
    	</span>
   	</g:hasErrors>
</div>