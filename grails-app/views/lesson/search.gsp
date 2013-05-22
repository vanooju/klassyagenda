<!doctype html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'hour.label', default: 'Uur')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
		<div class="span3">
			<g:form name="lessonSearchForm" controller="lesson" action="search">
				<g:render template="searchForm" />
				<g:submitButton name="submit" class="btn" value="Zoek"/>
			</g:form>
		</div>

		<div class="span3">
			<g:if test="${searchResult}">
				<div id="searchResults">
					<g:render template="searchResults" model="[lessons: searchResult.results]" />
				</div>
			</g:if>
		</div>
		<div class="span6" id="lesson-details"></div>
</body>
</html>