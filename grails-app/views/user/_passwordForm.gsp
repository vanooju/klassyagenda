<g:if test="${!session.user || session.user.id == it?.id}">
	<div
		class="control-group ${hasErrors(bean:it,field:'password','error')}">
		<div class="control-label">Paswoord</div>
		<div class="controls">
			<g:passwordField name="password" />
			<g:hasErrors bean="${it}" field="password">
				<g:eachError var="err" bean="${it}" field="password">
					<span class="help-inline"><g:message error="${err}" /></span>
				</g:eachError>
			</g:hasErrors>
		</div>
	</div>

	<div class="control-group ${flash.passwordRepeatError ? 'error' : ''}">
		<div class="control-label">Herhaal paswoord</div>
		<div class="controls">
			<g:passwordField name="repeatPassword" />
			<g:if test="${flash.passwordRepeatError}">
				<span class="help-inline"> ${flash.passwordRepeatError}
				</span>
			</g:if>
		</div>
	</div>
</g:if>