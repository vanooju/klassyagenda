<html>
<head>
<meta name='layout' content='nonav' />
<title><g:message code="springSecurity.login.title" /></title>
<link rel="stylesheet" type="text/css"
	href="<g:resource dir="css" file="bootstrap-extension.css" />">
</head>

<body>
	<div id='login'>
		<div class=container>
			<div class="row">
				<div class="span3"></div>
				<div class="span6">
					<g:if test='${flash.message}'>
						<div class='alert alert-error'>
							${flash.message}
						</div>
					</g:if>

					<form action='${postUrl}' method='POST' id='loginForm'
						class='form-horizontal' autocomplete='off'>
						<fieldset>
							<legend style="text-align: center;">
								Welkom bij <span class="brand">Klassy</span>
							</legend>


							<div class="control-group">
								<label for='username' class="control-label"><g:message
										code="springSecurity.login.username.label" /></label>
								<div class="controls">
									<input type='text' class='text_' name='j_username'
										id='username' />
								</div>
							</div>

							<div class="control-group">
								<label for='password' class="control-label"><g:message
										code="springSecurity.login.password.label" /></label>
								<div class="controls">
									<input type='password' name='j_password' id='password' />
								</div>
							</div>
							
							<div class="control-group">
								<div class="controls">
									<label class="checkbox">
      									<input type="checkbox"
										name="${rememberMeParameter}" id="remember_me"
										<g:if test='${hasCookie}'>checked='checked'</g:if> /> <g:message
											code="springSecurity.login.remember.me.label" />
    								</label>
									<button type='submit' class="btn" id="submit">${message(code: "springSecurity.login.button")}</button>
								</div>
							</div>
						</fieldset>
					
						<p style="text-align: center">Heb je nog geen account, dan kan je die <g:link action="create" controller="user">hier aanmaken</g:link>.
						<br/>
						Je kan daarna onmiddellijk de site beginnen gebruiken.</p>
					</form>
				</div>
				<div class="span3"></div>
			</div>
		</div>
	</div>
	<script type='text/javascript'>
	<!--
		(function() {
			document.forms['loginForm'].elements['j_username'].focus();
		})();
	// -->
	</script>
</body>
</html>
