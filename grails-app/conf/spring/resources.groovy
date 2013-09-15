import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import be.agenda.propertyeditor.CustomDateEditorRegistrar

// Place your Spring DSL code here
beans = {
	userDetailsService(be.agenda.authentication.UserDetailsService)
	
	authenticationSuccessHandler(be.agenda.authentication.DynamicRedirectAuthenticationSuccessHandler) {
		def conf = SpringSecurityUtils.securityConfig
		requestCache = ref('requestCache')
		defaultTargetUrl = conf.successHandler.defaultTargetUrl
		alwaysUseDefaultTargetUrl = conf.successHandler.alwaysUseDefault
		targetUrlParameter = conf.successHandler.targetUrlParameter
		useReferer = conf.successHandler.useReferer
		redirectStrategy = ref('redirectStrategy')
		principalUrl = "/agenda/user/list"
	}
	
	customPropertyEditorRegistrar(CustomDateEditorRegistrar)
}
