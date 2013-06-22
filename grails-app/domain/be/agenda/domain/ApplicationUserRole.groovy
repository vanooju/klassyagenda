package be.agenda.domain

import org.apache.commons.lang.builder.HashCodeBuilder

class ApplicationUserRole implements Serializable {

	ApplicationUser user
	Role role

	boolean equals(other) {
		if (!(other instanceof ApplicationUserRole)) {
			return false
		}

		other.user?.id == user?.id &&
			other.role?.id == role?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (user) builder.append(user.id)
		if (role) builder.append(role.id)
		builder.toHashCode()
	}

	static ApplicationUserRole get(long userId, long roleId) {
		find 'from UserRole where user.id=:userId and role.id=:roleId',
			[userId: userId, roleId: roleId]
	}

	static ApplicationUserRole create(ApplicationUser user, Role role, boolean flush = false) {
		new ApplicationUserRole(user: user, role: role).save(flush: flush, insert: true)
	}

	static boolean remove(ApplicationUser user, Role role, boolean flush = false) {
		ApplicationUserRole instance = ApplicationUserRole.findByUserAndRole(user, role)
		if (!instance) {
			return false
		}

		instance.delete(flush: flush)
		true
	}

	static void removeAll(ApplicationUser user) {
		executeUpdate 'DELETE FROM UserRole WHERE user=:user', [user: user]
	}

	static void removeAll(Role role) {
		executeUpdate 'DELETE FROM UserRole WHERE role=:role', [role: role]
	}

	static mapping = {
		id composite: ['role', 'user']
		version false
	}
}
