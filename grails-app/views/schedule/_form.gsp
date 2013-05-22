<%@ page import="be.agenda.Course" %>

<div class="control-group ${hasErrors(bean:scheduleHourInstance, field:'beginSlot', 'error')}">
	<label for="beginSlot.id"><g:message code="hour.beginHour.label" /></label>
	<div class="controls">
		<g:if test="${scheduleHourInstance.id}">
			<g:select name="beginSlot.id"
	       			  from="${beginSlots}"
	       			  optionKey="id"
	       			  optionValue="beginHour"
	       			  value="${scheduleHourInstance.beginSlot.id}" 
	       			  onchange="${remoteFunction(action:'updateEndSlot',update:'endSlotId',params:"'beginSlot=' + this.value + '&scheduleHourId=${scheduleHourInstance.id}'")}"/>
		</g:if>
		<g:else>
			<g:select name="beginSlot.id"
	       			  from="${beginSlots}"
	       			  optionKey="id"
	       			  optionValue="beginHour"
	       			  value="${scheduleHourInstance.beginSlot.id}" 
	       			  onchange="${remoteFunction(action:'updateEndSlot',update:'endSlotId',params:"'beginSlot=' + this.value + '&scheduleDayId=${scheduleHourInstance.day.id}'")}" />
       	</g:else>
		<g:hasErrors bean="${scheduleHourInstance}" field="beginSlot">
			<span class="help-inline">
				<g:eachError bean="${scheduleHourInstance}" field="beginSlot">
	    			<g:message error="${it}" />
	    		</g:eachError>
	    	</span>
    	</g:hasErrors>
  </div>
</div>

<div class="control-group ${hasErrors(bean:scheduleHourInstance, field:'endSlot', 'error')}">
	<label for="endSlot.id"><g:message code="hour.endHour.label" /></label>
	<div class="controls">
		<g:select name="endSlot.id"
       			  from="${endSlots}"
       			  optionKey="id"
       			  optionValue="endHour"
       			  value="${scheduleHourInstance.endSlot.id}" 
       			  id="endSlotId" />
		<g:hasErrors bean="${scheduleHourInstance}" field="endSlot">
			<span class="help-inline">
				<g:eachError bean="${scheduleHourInstance}" field="endSlot">
	    			<g:message error="${it}" />
	    		</g:eachError>
	    	</span>
    	</g:hasErrors>
  </div>
</div>

<div class="control-group ${hasErrors(bean:scheduleHourInstance, field:'course', 'error')}">
	<label for="course.id"><g:message code="hour.course.label" /></label>
	<div class="controls">
		<div class="input-append">
	        <g:select name="course.id"
				from="${Course.findAllByUser(session.user)}"
				optionKey="id"
				optionValue="name" 
				value="${scheduleHourInstance.course?.id}" 
				id="course" />
			<button class="btn open-course-dialog" type="button" 
				        data-toggle="modal" data-target="#courseModal" 
				        id="show-course-modal-link"
				        data-remote="${createLink(controller: 'course', action: 'showCourseModalForm')}">Add Course</button>
		</div>
		<g:hasErrors bean="${scheduleHourInstance}" field="course">
			<span class="help-inline">
				<g:eachError bean="${scheduleHourInstance}" field="course">
	    			<g:message error="${it}" />
	    		</g:eachError>
	    	</span>
    	</g:hasErrors>
  </div>
</div>