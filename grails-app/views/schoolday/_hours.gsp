<html>
	<body>
		<div class="span3">
			<ul class="nav nav-list">
			  <li class="nav-header"><a href="#" title="Datum kiezen" id="datepicker" data-date="${schooldayInstance.date}" data-date-format="dd/mm/yyyy">${schooldayInstance.date.format("EEEE dd/MM/yyyy")}</a></li>
			  <li class="divider"></li>
			  <g:each in="${schooldayInstance.hours}" var="hour">
			  	<li><a href="#${hour.id}">${hour.beginHour} - ${hour.endHour}: ${hour.title}</a></li>
			  </g:each>
			<g:if test="${schooldayInstance.availableSlots && schooldayInstance.availableSlots.size() > 0}">
			  <li class="divider"></li>
			  <li><g:link action="createLesson" params="[date_year: schooldayInstance.date.format('yyyy'), date_month: schooldayInstance.date.format('MM'), date_day: schooldayInstance.date.format('dd'), date: 'date.struct']">Nieuwe les</g:link></li>
			  <li><g:link action="createActivity" params="[date_year: schooldayInstance.date.format('yyyy'), date_month: schooldayInstance.date.format('MM'), date_day: schooldayInstance.date.format('dd'), date: 'date.struct']">Nieuwe activiteit</g:link></li>
			  </g:if>
			</ul>
		</div>		  
		
		<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  	  		<g:form name="deleteForm" controller="schoolday" action="delete">
		  	<div class="modal-header">
		    	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		    	<h3 id="myModalLabel">Uur verwijderen</h3>
		  	</div>
		  	<div class="modal-body" id="modal-body">
		    	<p>
		    	</p>
		  	</div>
		  	<div class="modal-footer">
		  		<g:hiddenField name="hourIndex" value="" />
		  		<g:hiddenField name="date_delete_year" value="" />
		  		<g:hiddenField name="date_delete_month" value="" />
		  		<g:hiddenField name="date_delete_day" value="" />
		  		<g:hiddenField name="date_delete" value="date.struct" />
		  		<g:hiddenField name="hourId" value="" />
		    	<button class="btn" data-dismiss="modal" aria-hidden="true">Annuleren</button>
		    	<g:submitButton class="btn btn-danger" name="confirm" value="Verwijderen" />
		  	</div>
		  </g:form>
		</div>
	</body>
</html>