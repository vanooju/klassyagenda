<html>
<head>
</head>
<body>
<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<a class="brand" href="#" style="margin-left: 20px;">klassy</a>
		<ul class="nav">
			<sec:ifAllGranted roles="ROLE_USER">
				<li ${controllerName.equals('schedule') ? 'class="active"' : ''}><g:link
						controller="schedule">
						<g:message code="schedule.title.label" />
					</g:link></li>
				<li
					${controllerName.equals('course') || controllerName.equals('coursePart') ? 'class="active"' : ''}><g:link
						controller="course">
						<g:message code="course.title.label" />
					</g:link></li>
				<li
					${controllerName.equals('schoolday') || controllerName.equals('hour') ? 'class="active"' : ''}><g:link
						controller="schoolday">
						<g:message code="schoolday.title.label" />
					</g:link></li>
			</sec:ifAllGranted>
			<sec:ifAllGranted roles="ROLE_PRINCIPAL">
				<li ${controllerName.equals('user') ? 'class="active"' : ''}><g:link
						controller="user" action="list">Leerkrachten</g:link></li>
			</sec:ifAllGranted>
			<sec:ifAllGranted roles="ROLE_ADMIN">
				<li ${controllerName.equals('school') ? 'class="active"' : ''}><g:link
						controller="school" action="list">Schoolbeheer</g:link></li>
			</sec:ifAllGranted>
		</ul>
		<sec:ifLoggedIn>
			<ul class="nav pull-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"	data-toggle="dropdown"> 
						<sec:loggedInUserInfo field="fullName" />
						<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<li><g:link controller="user" action="edit">Instellingen</g:link></li>
						<li><g:link controller="user" action="modifyPassword" id="${session.user.id}">Paswoord wijzigen</g:link></li>
						<li><g:link controller="logout" action="index">Afmelden</g:link></li>
					</ul></li>
			</ul>
			<p class="nav pull-right navbar-text"></p>
		</sec:ifLoggedIn>
	</div>
</div>
</body>
</html>
