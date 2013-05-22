<!-- this template is triggered on a page that has a #course select box -->
<div id="courseModal" class="modal hide" tabindex="-1" role="dialog" aria-labelledby="courseModalLabel" aria-hidden="true">
	  	<g:formRemote name="courseForm" url="[ controller: 'course', action: 'addCourse']" update="[success: 'course', failure: 'courseFormTemplate']" onSuccess="\$('#courseModal').modal('hide')">
  	<div class="modal-header">
    	<button type="button" href="#" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    	<h3 id="courseModalLabel">Vak toevoegen</h3>
  	</div>
  	<div class="modal-body" id="modal-body">
  	</div>
  	<div class="modal-footer">
    	<g:submitToRemote class="btn btn-primary" name="confirm" value="Aanmaken" 
    					  url="[controller: 'course', action: 'addCourse']" 
    					  update="[success: 'course', failure: 'courseFormTemplate']" 
    					  onSuccess="\$('#courseModal').modal('hide');\$('#course').trigger('change');" />
    	<button type="button" class="btn" data-dismiss="modal" aria-hidden="true">Annuleren</button>
  	</div>
  </g:formRemote>
</div>

<script>
	 $("#courseModal").on("hidden", function() { 
		 $(this).removeData('modal');
		 $('#course').trigger('change');
	 });
</script>