<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main" />
	</head>
	<body>
		<g:form class="form form-horizontal" action="saveSchedule">
			<div
				class="control-group ${hasErrors(bean:scheduleInstance,field:'beginYear','error')}">
				<label for="beginYear" class="control-label">
					Schooljaar begint in 
				</label>
				<div class="controls">
					<g:textField name="beginYear" value="${scheduleInstance?.beginYear}"></g:textField>
				<g:hasErrors bean="${scheduleInstance}" field="beginYear">
					<g:eachError var="err" bean="${scheduleInstance}" field="beginYear">
						<span class="help-inline"><g:message error="${err}" /></span>
					</g:eachError>
				</g:hasErrors>
				</div>  
			</div>
			<div class="controls">
				<g:submitButton class="btn btn-primary" name="submit" value="${message(code:'save.label')}" />
				<g:submitButton class="btn" name="cancel" value="${message(code:'cancel.label')}" />
			</div>
		</g:form>
		
		<g:render template="/course/courseModal" />
	</body>
</html>