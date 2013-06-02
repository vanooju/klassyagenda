<span id="share_with_${it.id}">
	<g:if test="${session.user.sharedUsers?.contains(it)}">
		<g:remoteLink action="stopShare" params="[id: it.id]" update="share_with_${it.id}">
			Stop sharing
		</g:remoteLink>
	</g:if>
	<g:else>
		<g:remoteLink action="startShare" params="[id: it.id]" update="share_with_${it.id}">
			Share
		</g:remoteLink>
	</g:else>
</span>