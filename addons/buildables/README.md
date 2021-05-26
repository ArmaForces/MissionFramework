## Buildables

This module allows you to "build" editor layer by un-hiding the layer objects after delivering configured amount of supplies to the area.
Types of accepted supplies can be configured in module attributes, module area defines the delivery zone.

| Event | Locality | Arguments | Description
|---|---|----------|-----------|
| afmf_buildables_built | Global | 0: Layer name | Area for given layer was built (all supplies delivered and after configured time)
| afmf_buildables_delivered | Global | 0: Layer name | Single supply was delivered to area for given layer

### Authors

- [veteran29](http://github.com/veteran29)
