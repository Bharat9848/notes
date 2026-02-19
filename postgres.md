# configuration
1. posgresql.conf
 - primary will have setting like `wal_level`, `max_wal_sender`, `wal_keep_size`, `synchronous_commit`, `synchronous_standby_names`
 - secondary will have configuration of `hot_standby`
2. pg_hpa.conf
 - authentication configuration 