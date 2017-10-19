use Mix.Config

config :perhap,
  eventstore: Perhap.Adapters.Eventstore.Dynamo,
  modelstore: Perhap.Adapters.Modelstore.Memory

config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role]

config :ex_aws, :retries,
  max_attempts: 10,
  base_backoff_in_ms: 10,
  max_backoff_in_ms: 10_000

config :ex_aws, :dynamodb,
  scheme: "https://",
  region: "us-east-1"


config :ssl, protocol_version: :"tlsv1.2"

config :logger,
  backends: [:console],
  utc_log: true,
  compile_time_purge_level: :debug,
  level: :error

config :logger, :access_log,
  metadata: [:application, :module, :function],
  level: :info

config :logger, :error_log,
  metadata: [:application, :module, :function, :file, :line],
  level: :error

config :libcluster,
  topologies: [
    perhap: [ strategy: Cluster.Strategy.Epmd,
              config: [hosts: [:"perhap1@127.0.0.1", :"perhap2@127.0.0.1", :"perhap3@127.0.0.1"] ]]
  ]

config :swarm, sync_nodes_timeout: 1_000 #,debug: true
