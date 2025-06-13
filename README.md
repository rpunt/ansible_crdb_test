# CockroachDB Ansible Project

This project demonstrates how to use the `cockroach_labs.cockroachdb` collection to manage CockroachDB instances using Ansible.

## Setup Instructions for Local Collection Development

* Start your test container

```bash
./start_container.sh
```

* Run the playbook:

```bash
ansible-playbook crdb_setup.yml
```

then

```bash
ansible-playbook crdb_query.yml
```

* Validate your work

```bash
cockroach sql --insecure
```

* Stop the container

```bash
./stop_container.sh
```

## Project Structure

* `ansible.cfg` - Ansible configuration
* `inventory` - Inventory file listing your target hosts
* `requirements.yml` - Collection requirements
* `cockroachdb_playbook.yml` - Example playbook for CockroachDB management

## Notes

* The playbook is configured to run on localhost by default. Modify the inventory file to target remote hosts.
* Some tasks may require root privileges (using `become: yes`).
* Adjust the CockroachDB configuration parameters according to your specific requirements.
* For production deployments, ensure proper security settings including TLS certificates.

## Documentation

For more information about the cockroach_labs.cockroachdb collection and its modules, refer to the collection documentation.
