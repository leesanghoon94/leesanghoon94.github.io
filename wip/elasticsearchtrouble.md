2024-08-20 02:20:21 {"@timestamp":"2024-08-19T17:20:21.264Z", "log.level": "WARN", "message":"This node is a fully-formed single-node cluster with cluster UUID [YYnb5Mq7TMyV9gV60vndQA], but it is configured as if to discover other nodes and form a multi-node cluster via the [discovery.seed_hosts=[es01]] setting. Fully-formed clusters do not attempt to discover other nodes, and nodes with different cluster UUIDs cannot belong to the same cluster. The cluster UUID persists across restarts and can only be changed by deleting the contents of the node's data path(s). Remove the discovery configuration to suppress this message.", "ecs.version": "1.2.0","service.name":"ES_ECS","event.dataset":"elasticsearch.server","process.thread.name":"elasticsearch[es01][scheduler][T#1]","log.logger":"org.elasticsearch.cluster.coordination.Coordinator","elasticsearch.cluster.uuid":"YYnb5Mq7TMyV9gV60vndQA","elasticsearch.node.id":"1-COstN0SUaP233Un2-W8Q","elasticsearch.node.name":"es01","elasticsearch.cluster.name":"es-cluster"}

이 경고 메시지는 Elasticsearch의 노드가 잘못된 클러스터 설정을 감지했음을 나타냅니다. 구체적으로는, 현재 노드가 이미 "완전히 구성된 단일 노드 클러스터"로 작동 중인데, `discovery.seed_hosts` 설정을 통해 추가적인 노드를 검색하려고 하고 있다는 경고입니다.

### 메시지 분석

- **`fully-formed single-node cluster`**: 이 노드는 현재 단일 노드 클러스터로 구성되어 있습니다. 즉, 클러스터 내에서 유일한 노드로 작동 중이며, 추가적인 노드가 필요하지 않습니다.
- **`discovery.seed_hosts=[es01]` 설정**: 이 설정은 원래 다중 노드 클러스터에서 사용되며, 다른 노드와 클러스터를 형성하기 위해 특정 호스트를 검색하도록 설정합니다. 그러나 현재 이 노드는 이미 단일 노드 클러스터로 형성되어 있으므로 다른 노드를 발견할 필요가 없습니다.
- **`cluster UUID persists across restarts`**: 클러스터 UUID는 클러스터가 생성될 때 고유하게 부여되며, 재시작해도 유지됩니다. 다른 클러스터와 UUID가 다르면 같은 클러스터에 속할 수 없습니다.

### 해결 방법

- **`discovery.seed_hosts` 설정 제거**: 단일 노드 클러스터에서는 `discovery.seed_hosts` 설정을 사용할 필요가 없습니다. 이 설정을 `elasticsearch.yml` 파일에서 제거하거나 주석 처리하십시오. 이렇게 하면 Elasticsearch가 이 경고를 더 이상 발생시키지 않으며, 노드는 단일 노드 클러스터로 정상 작동합니다.

```yaml
# elasticsearch.yml에서 discovery.seed_hosts 설정 제거
discovery.seed_hosts: []
```

- **설정 파일 확인**: 위와 같은 설정 변경 후, Elasticsearch를 다시 시작하여 경고 메시지가 사라지는지 확인합니다.

### 요약

이 경고는 현재 단일 노드로 작동 중인 Elasticsearch 클러스터에서 불필요하게 다른 노드를 검색하려는 설정이 남아있다는 것을 알려주는 것입니다. `discovery.seed_hosts` 설정을 제거하면 이 문제가 해결됩니다.
