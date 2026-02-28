# ip_in_subnet

## Check if ip is within a specific subnet.

### Usage

```bash
ip_in_subnet <ip> <subnet>
```

### Examples

ip_in_subnet 10.10.1.145 10.10.0.0/16 && echo yes || echo false


### Description


The `<subnet>` is defined as an ip in CIDR notation with the relevant number of bits. But you can also use `private`, `public` and `loopback`.

