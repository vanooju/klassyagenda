<html>
<body>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-hidden="true">&times;</button>
	<h3>Lessen zoeken</h3>
</div>
<div class="modal-body">
	<g:render template="/lesson/searchForm" />
</div>
<div class="modal-footer">
	<a href="#" data-dismiss="modal" class="btn">Close</a>
	<g:submitButton name="search" value="Zoek" class="btn btn-primary" />
</div>
</body>
</html>