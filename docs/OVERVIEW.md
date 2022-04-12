# Overview

In order to observe and analyse energy consumption for streaming events, we need to have a consistent approach to the data measurement and collection.  Whilst we could collect measurements at very fine graularity, we want to ensure that the effort to collect, send and analyse the data is minimised so that observing itself doesn't become a major factor (and that no intellectual property is compromised).

The overall key metric we want to understand is `average watts per 15 minutes`.

## Measurements

During each event, each provider needs to measure their energy usage and deliver those measurements for analysis.

For each measurement we need to know:

* event - the associated event for this measurement, e.g. UEFA Cup Final
* provider - who is providing the measurement, e.g. akamai, ateme
* meter - the providers resource(s) being measured, e.g. a device, machine, rack, data center
* interval - the start and end period of the metered interval
* metric - the system of measurement, e.g. joules
* value - the measure of the meter for the given interval in the metric

## Meters

Each provider can determine the most appropriate meters based on the knowledge of their devices, machines, networks, software and how granular they want to expose their topologies.  For example, a CDN may choose to separate their network measurements into 3 key meters: origin, propagation, pop.

## Topology

TBC
