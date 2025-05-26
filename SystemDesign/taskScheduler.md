## Concept
- dependent / independent task

## Requiement
- Submit tasks
- Remove tasks
- Allocate resources: intelligently map resources to number of background tasks
- Monitor task execution: reexecute failed tasks.
- Prioritized time sensistive tasks
- Efficiency: fairness to multi tenents, underutilized resources should not be allocated.
- Release resources 
- Show task status
- Scheduling of tasks

## Non functional task
- Availability
- Durability: 
- Scalability
- Fault tolerance
- bounded wait time.

## Components

## Entity
- Task(taskId, userId, task definiton, schedule, failed_attempt_allowed, resourceRequirement, executionCap, status, delayTolerance)

## Deep dive
1. how to do Scheduling with no starvation of low priority task, timely finish of urgent task and periodic task 
   - Separate queue for urgent task, periodic task and task that can be delayed.
   - Each task should be assigned maximum delay tolerance. Urgent task should have low `delayTolerance`. Once some task's delay tolerance limit is expired it can be put into urgent queue. Maximum delay tolerance can be set by client explicitly or system by checking task category and serverity

2. How to prevent tasks from hogging the resources
   - Client should provides maximum `executionCap` time, after which schedular can failed the task and inform client.
   - Schedular can keep its own `executionCap` in case it is not provided by the client
   - If longer tasks are allowed then they should be preempt after some time slice. Checkpointing can help stop and resume the task where it left off.
   - Maximum usage limit should be set for each kind of resources.    

3. How to monitor resources capacity
   - Scheduler maintains `resources-to-demand` ratio. For peak time it should tends to zero. We can observe its trend over time to increase/decrease capacity of resources.
   