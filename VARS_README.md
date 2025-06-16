# Ansible CockroachDB Variables Structure

This document explains the variable organization for the CockroachDB Ansible playbooks.

## Variable Files Structure

```text
vars/
├── crdb_common.yml          # Common CockroachDB configuration
├── crdb_setup.yml           # Setup-specific variables
├── crdb_query.yml           # Query/testing variables
└── environments/
    ├── dev.yml              # Development environment overrides
    └── prod.yml             # Production environment overrides

group_vars/
└── crdb_servers.yml         # Variables for crdb_servers group
```

## Variable Precedence

Variables are loaded in this order (later files override earlier ones):

1. `vars/crdb_common.yml` - Base configuration
2. Playbook-specific vars (`crdb_setup.yml` or `crdb_query.yml`)
3. Environment-specific vars (`environments/dev.yml` or `environments/prod.yml`)
4. `group_vars/crdb_servers.yml` - Group-specific overrides
5. `host_vars/hostname.yml` - Host-specific overrides (if created)

## Usage Examples

### Running with Development Environment

```bash
# Make sure vars/environments/dev.yml is uncommented in your playbook
ansible-playbook -i inventory.ini crdb_setup.yml
```

### Running with Production Environment

```bash
# Comment out dev.yml and uncomment prod.yml in your playbook
ansible-playbook -i inventory.ini crdb_setup.yml
```

### Using Command Line Variables

```bash
# Override specific variables at runtime
ansible-playbook -i inventory.ini crdb_setup.yml -e "setup_database_name=custom_db"
```

### Using Different Environment Files

```bash
# Create custom environment file and reference it in playbook
ansible-playbook -i inventory.ini crdb_setup.yml -e "@vars/environments/staging.yml"
```

## Key Variables

### Common Variables (`crdb_common.yml`)

- `crdb_version`: CockroachDB version
- `crdb_cluster_name`: Cluster name
- `crdb_listen_port`: Database port
- `crdb_secure_mode`: Security mode (disable/require)
- `crdb_host`: Database host
- `crdb_user`: Database user

### Setup Variables (`crdb_setup.yml`)

- `setup_database_name`: Database to create
- `setup_user_name`: User to create
- `cluster_parameters`: CockroachDB cluster parameters

### Query Variables (`crdb_query.yml`)

- `query_database_name`: Database for queries
- `query_table_name`: Table name for queries
- `sample_queries`: Pre-defined SQL queries

## Security Considerations

- Use `ansible-vault` to encrypt sensitive variables like passwords
- Store vault files separately from regular vars files
- Example:

  ```bash
  ansible-vault create vars/secrets.yml
  ansible-playbook -i inventory.ini crdb_setup.yml --ask-vault-pass
  ```

## Creating Host-Specific Variables

Create `host_vars/hostname.yml` for host-specific overrides:

```yaml
---
# Host-specific variables for a particular server
crdb_data_dir: "/mnt/large-disk/cockroach/data"
setup_database_name: "{{ inventory_hostname }}_database"
```
