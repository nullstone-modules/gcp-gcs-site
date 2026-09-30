# 0.2.0 (Sep 30, 2026)
* Upgraded `nullstone-io/ns` provider to `~> 0.13.0`.
* Replaced `ns_env_variables` with the layered `ns_env_values` and `ns_env_platform_data` data sources to aggregate environment variables.
* Emitted the `env` platform data record, including the source of each variable.
* Upgraded capability scaffolding to emit `cap_env` (with `capability`) and `cap_prefixes`.

# 0.1.0 (Jun 19, 2026)
* Initial draft
