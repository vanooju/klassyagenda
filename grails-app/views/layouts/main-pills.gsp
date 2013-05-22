<!DOCTYPE html>
<html>
<head>
<r:require modules="bootstrap, jquery-ui" />
<r:layoutResources />
<g:layoutHead />
<script type="text/javascript" src="<g:resource dir="js" file="bootstrap-tooltip.js" />"></script>
<script type="text/javascript" src="<g:resource dir="js" file="bootstrap-popover.js" />"></script>
</head>
<body style="padding-top: 60px">
		<div class="navbar navbar-inverse navbar-fixed-top">
			<div class="navbar-inner">
				<div class="container">
						<ul class="nav">
							<li ${controllerName == null ? 'class="active"' : ''}><a href="${createLink(uri:'/')}">Home</a></li>
							<li ${controllerName.equals('schedule') ? 'class="active"' : ''}><g:link controller="schedule"><g:message code="schedule.title.label" /></g:link></li>
							<li ${controllerName.equals('course') || controllerName.equals('coursePart') ? 'class="active"' : ''}><g:link controller="course"><g:message code="course.title.label" /></g:link></li>
							<li ${controllerName.equals('schoolday') || controllerName.equals('hour') ? 'class="active"' : ''}><g:link controller="schoolday"><g:message code="schoolday.title.label" /></g:link></li>
						</ul>
						<sec:ifLoggedIn>
							<ul class="nav pull-right">
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							        <sec:loggedInUserInfo field="fullName" />&nbsp;<avatar:gravatar email="jurgen.vanoosterwijck@gmail.com"/> 
							      	<b class="caret"></b>
							    </a>
							    <ul class="dropdown-menu">
							      <li><g:link  controller="logout" action="index">Logout</g:link></li>
							    </ul>
							  </li>
							   </ul>
							<p class="nav pull-right navbar-text">
								
							</p>
						</sec:ifLoggedIn>
					</div>
				</div>
			</div>
		</div>
	
		<div class="container">
			<div class="row">
				<g:layoutBody />
				<r:layoutResources />
			</div>
		</div>
</body>
</html>