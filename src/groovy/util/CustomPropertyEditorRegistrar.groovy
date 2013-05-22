package util

import org.springframework.beans.PropertyEditorRegistrar
import org.springframework.beans.PropertyEditorRegistry

class CustomPropertyEditorRegistrar implements PropertyEditorRegistrar {
	def dateEditor
	
	void registerCustomEditors(PropertyEditorRegistry registry) {
		registry.registerCustomEditor(Date.class, dateEditor)
	}
}
