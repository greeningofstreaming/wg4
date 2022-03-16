## Key Metric

"Average Watts per 15min per server"

## Machine Metrics

### Intel Chipsets

See <https://github.com/opcm/pcm>

### AMD Chipsets

See <https://developer.amd.com/amd-uprof/>

### *nix kernel

See <https://github.com/prometheus/node_exporter>

### impi compatible devices

From a power consumption on a per-server basis, the BMC may be useful.

```sh
ipmitool -H <HOSTNAME> -U USERNAME -P PASSWORD  dcmi power reading
```
