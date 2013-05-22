class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/" (controller:"/schedule")
		"500"(view:'/error')
		
		name saveHour: "/schoolday/$date_year/$date_month/$date_day/hours" {
			controller = "schoolday"
			action = "saveHour"
			method = "post"
		}
	}
}
