dataSource {
    pooled = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}

environments {
    development {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:h2:mem:devDb;MVCC=TRUE"
        }
    }
    test {
		dataSource {
			dbCreate = "update"
			driverClassName = "com.mysql.jdbc.Driver"
			dialect = org.hibernate.dialect.MySQL5InnoDBDialect
			
			url = "jdbc:mysql://localhost:3306/agenda?useUnicode=yes&characterEncoding=UTF-8&autoReconnect=true&zeroDateTimeBehavior=convertToNull"
			username = "agenda"
			password = "agenda"
			properties {
				maxActive = 50
				maxIdle = 25
				minIdle = 1
				initialSize = 1
				minEvictableIdleTimeMillis = 60000
				timeBetweenEvictionRunsMillis = 60000
				numTestsPerEvictionRun = 3
				maxWait = 10000

				testOnBorrow = true
				testWhileIdle = true
				testOnReturn = true

				validationQuery = "select now()"
			}
			loggingSql = true
		}
    }
    production {
		dataSource {
			dbCreate = "update"
			driverClassName = "com.mysql.jdbc.Driver"
			//dialect = org.hibernate.dialect.MySQL5Dialect
			dialect = org.hibernate.dialect.MySQL5InnoDBDialect
			
			url = "jdbc:mysql://localhost:3306/agenda?useUnicode=yes&characterEncoding=UTF-8&autoReconnect=true&zeroDateTimeBehavior=convertToNull"
			username = "agenda"
			password = "agenda"
			properties {
				maxActive = 50
				maxIdle = 25
				minIdle = 1
				initialSize = 1
				minEvictableIdleTimeMillis = 60000
				timeBetweenEvictionRunsMillis = 60000
				numTestsPerEvictionRun = 3
				maxWait = 10000

				testOnBorrow = true
				testWhileIdle = true
				testOnReturn = true

				validationQuery = "select now()"
			}
		}
    }
}
