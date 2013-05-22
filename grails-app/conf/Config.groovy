
import org.codehaus.groovy.grails.plugins.springsecurity.SecurityRequestHolder
import org.springframework.dao.OptimisticLockingFailureException

import be.agenda.AgendaUtils
import be.agenda.ApplicationUser
import be.agenda.Schedule

// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }


grails.project.groupId = "be.agenda" // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']


// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// enable query caching by default
grails.hibernate.cache.queries = true

grails.plugins.twitterbootstrap.fixtaglib = true
grails.plugins.twitterbootstrap.defaultBundle = 'bundle_bootstrap'

grails.plugins.springsecurity.controllerAnnotations.staticRules = [
	'/user/create': ['IS_AUTHENTICATED_ANONYMOUSLY'],
	'/user/save': ['IS_AUTHENTICATED_ANONYMOUSLY'],
	'/**': ['IS_AUTHENTICATED_FULLY'],
	'/login/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
	'/logout/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
	'/favicon.ico': ['IS_AUTHENTICATED_ANONYMOUSLY'],
 ]

grails.plugins.springsecurity.useSecurityEventListener = true

grails.plugins.springsecurity.onInteractiveAuthenticationSuccessEvent = { event, appCtx ->
	def session = SecurityRequestHolder.request.getSession(false)	
	def user = ApplicationUser.get(event.getAuthentication().getPrincipal().id)
	def schedule = Schedule.findByBeginYearAndUser(AgendaUtils.beginYearForDate(new Date()), session.user)
	if (schedule != null) {
		session.scheduleId = schedule.id
		session.schoolyear = schedule.schoolyear
	}
	
	ApplicationUser.withTransaction { status ->
	  try {
		user.attach()
		user.lastLoginDate = new Date()
		user.save(flush: true)
	  } catch(OptimisticLockingFailureException e) {
		user = ApplicationUser.merge(user)
	  }
	}
	
	session.user = user
}

// set per-environment serverURL stem for creating absolute links
environments {
    development {
        grails.logging.jul.usebridge = true
    }
    test {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
    }
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', 
    //}
	root {
		error 'stdout'
	}

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
           'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
           'org.springframework',
		   'org.hibernate',
           'net.sf.ehcache.hibernate'
		   
	info   'grails.app'
	
	debug 'grails.plugins.twitterbootstrap'
}

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'be.agenda.ApplicationUser'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'be.agenda.ApplicationUserRole'
grails.plugins.springsecurity.authority.className = 'be.agenda.Role'
grails.plugins.springsecurity.securityConfigType = "Annotation"

grails.resources.modules = {
        'agenda-less-style' {
		  dependsOn 'bootstrap'
          resource url:[dir: 'less', file: 'agenda-style.less'], attrs:[rel: "stylesheet/less", type:'css']
		  resource url:[dir: 'css', file: 'bootstrap-extension.css'], attrs:[rel: 'stylesheet', type:'css']
		  resource url:[dir: 'js', file: 'bootbox.js']
        }
}