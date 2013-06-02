<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
	<div class="row-fluid">
		<div class="span2"></div>
		<div class="span9">
			<g:form class="form form-horizontal" action="saveSchedule">
				<legend>Nieuw lessenrooster aanmaken</legend>
				<div
					class="control-group ${hasErrors(bean:scheduleInstance,field:'beginYear','error')}">
					<label for="beginYear" class="control-label"> Schooljaar
						begint in</label>
					<div class="controls">
						<g:textField name="beginYear"
							value="${scheduleInstance?.beginYear}"></g:textField>
						<g:hasErrors bean="${scheduleInstance}" field="beginYear">
							<g:eachError var="err" bean="${scheduleInstance}"
								field="beginYear">
								<span class="help-inline"><g:message error="${err}" /></span>
							</g:eachError>
						</g:hasErrors>
					</div>
				</div>
				<div
					class="control-group ${hasErrors(bean:scheduleInstance,field:'grade','error')}">
					<label for="grade" class="control-label">Leerjaar</label>
					<div class="controls">
						<g:select name="grade" from="${1..6}"
							noSelection="${['-1':'Verschillende leerjaren']}" />
						<g:hasErrors bean="${scheduleInstance}" field="grade">
							<g:eachError var="err" bean="${scheduleInstance}" field="grade">
								<span class="help-inline"><g:message error="${err}" /></span>
							</g:eachError>
						</g:hasErrors>
						<span class="help-block">Als je het hele jaar in 1 leerjaar
							lesgeeft, kies dan hier dat leerjaar. <br /> Als je kiest voor <em>Verschillende
								leerjaren</em>, dan kan je achteraf het leerjaar selecteren voor elk
							lesuur dat je ingeeft.
						</span>
					</div>
				</div>
				<div class="controls">
					<g:submitButton class="btn btn-primary" name="submit"
						value="${message(code:'save.label')}" />
					<g:submitButton class="btn" name="cancel"
						value="${message(code:'cancel.label')}" />
				</div>
			</g:form>

			<g:render template="/course/courseModal" />
		</div>
		<div class="span2"></div>
	</div>
</body>
</html>