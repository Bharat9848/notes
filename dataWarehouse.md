# star schema
# Denormalized Wide Table
# Fact Tables
# Dimension Tables

## Rough
Data lifecycle-
1. generation 
2. Storage
3. Ingestions
4. Transfomation
5. Serving

Horizontal usecasea
1. Security
2. Data management
3. Dataops
4. Data architecture
5. Orchestration
6. Software engineering

Difference between lambda and Kappa architecture.


Data warehouse vs data lake
Mpp database ? Reverse ETL
RDD Apache spark
Operator checkpoint in Apache flink

1. Feature store - feature version, feature history, feature sharing. Assessment of data quality
2. Data metadata - data dictionary what is the meaning of the term, data model, schema, data lineage, technical metadata to help data engineer to do something with pipeline
3. Good data architecture serves business requirements with a common widely reusable set of building blocks while maintaining flexibility and making appropriate trade off.


Data lineage is the process of tracking data as it flows from data sources to consumption, including all the transformations the data underwent along the way

One bottleneck was poor read performance of the Avro file format. Engineers migrated to ORC and consequently saw a read speed increase of ~10-1000x, along with a 25-50% improvement in compression ratio. ??