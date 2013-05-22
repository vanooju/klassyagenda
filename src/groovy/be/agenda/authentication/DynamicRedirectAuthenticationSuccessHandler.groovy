package be.agenda.authentication

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

class DynamicRedirectAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	private String principalUrl

	@Override
	protected String determineTargetUrl(HttpServletRequest request,
	HttpServletResponse response) {
		boolean hasPrincipal = SpringSecurityUtils.ifAllGranted("ROLE_PRINCIPAL");
		boolean hasUser = SpringSecurityUtils.ifAllGranted("ROLE_USER");

		if(hasPrincipal){
			return principalUrl;
		}else {
			return super.determineTargetUrl(request, response);
		}
	}

	public void setPrincipalUrl(String principalUrl) {
		this.principalUrl = principalUrl
	}
}
