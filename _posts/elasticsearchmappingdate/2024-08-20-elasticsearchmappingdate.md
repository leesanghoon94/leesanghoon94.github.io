---
layout: post
title: "elasticsearchmappingdate"
date: 2024-08-20 03:15:52 +0900
categories: []
tags: []
---

Elasticsearch 에서 날짜 타입은 ISO8601 형식을 따라 입력을 합니다. 일반적으로 다음과 같은 형태로 입력된 경우 자동으로 날짜 타입으로 인식이 됩니다.

"2019-06-12"

"2019-06-12T17:13:40"

"2019-06-12T17:13:40+09:00"

"2019-06-12T17:13:40.428Z"

위와 같은 ISO8601 형식이 아니라 "2019/06/12 12:10:30" 와 같이 입력하면 보통은 text, keyword 로 저장됩니다. 이 외에도 1550282065513 와 같이 long 타입의 정수인 epoch_millis 형태의 입력도 가능합니다. epoch_millis 는 1970-01-01 00:00:00 부터의 시간을 밀리초 단위로 카운트 한 값입니다. 필드가 date 형으로 정의 된 이후에는 long 타입의 정수를 입력하면 날짜 형태로 저장이 가능합니다. "2019/06/10 12:10:30" 같은 형식으로 날짜를 저장하려면 format 옵션을 사용해서 형태를 지정해야 합니다.

다음은 날짜 타입에서 사용 가능한 옵션들입니다.

"doc_values", "index", "null_value", "ignore_malformed" 옵션들은 문자열, 숫자 필드와 기능이 동일합니다.

"format" : "<문자열 || 문자열 ...>" 입력 가능한 날짜 형식을 || 로 구분해서 입력합니다.

다음은 my_date 인덱스에서 "2019/06/10", "2019-06-10 12:10:30" 그리고 epoch_millis 형태로 입력받도록 date_val 날짜 필드를 지정하는 예제입니다.

---

boolean타입
불리언은 true 와 false 두가지 값을 갖는 필드 타입입니다. 선언은 "type": "boolean" 로 합니다. "true" 와 같이 문자열로 입력이 되어도 true 로 해석이 되어 저장됩니다. 불리언 필드를 사용 할 때는 일반적으로 term 쿼리를 이용해서 검색을 합니다.

다음은 불리언 필드에서 사용 가능한 옵션들입니다.

"doc_values", "index" 옵션들은 문자열, 숫자 필드와 기능이 동일합니다.

"null_value" : <true | false> - 필드가 존재하지 않거나 값이 null 일 때 디폴트 값을 지정합니다. 지정하지 않으면 불리언 필드가 없거나 값이 null인 경우 존재하지 않는 것으로 처리되어 true / false 모두 쿼리나 집계에 나타나지 않습니다.

---

object,nejesty
Object
JSON 에서는 한 필드 안에 하위 필드를 넣는 object, 즉 객체 타입의 값을 사용할 수 있습니다. 보통은 한 요소가 여러 하위 정보를 가지고 있는 경우 object 타입 형태로 사용합니다. 다음은 movie 인덱스에 하위 필드 "name", "age", "side" 를 가진 object 타입 "characters" 필드의 예제입니다.

```
  PUT movie/_doc/1
{
  "characters": {
    "name": "Iron Man",
    "age": 46,
    "side": "superhero"
  }
}

```

---

logstash
시작하기

elastic stack
solution
kibana: visualize & manage
elasticsearch: store,search,analyze
beats(ingest :수집해서 적재),logstash: ingest(수집:가공)

logstash pipeline
input/filter/output

---

Logstash filter 설정
config 변경시 logstash 자동 재시작 설정
LOGSTAsh.ymlㅇ에서 config.reload.automatic: true

아파치 웹로그 수집을 위한 FILTER 설정
GROk: 메세지 스트림 파싱
geoip: ip 주소에서 위치 및 지역 정보 확장
mutate: 불피료한 필드 삭제 및 타입 변환
DATe: 문자열로 된 날짜를 DATE타입으로 변환

grok
%{NUMBER:duration} %{IP: client}

geoip

useragent
이 필드는 포함하다 클라이언트의 os와 장치 브라우저 정보
useragent {
source => "agent"
target => "useragent"
} filter 추가
무조건 grok 설정후에 와야된다

date filter
@timestamp는 logstash가 작성한거라,
timestamp는 날짜 타입으로 바꿔서 줘야됨

---

Filebeat 설치 및 실행
yaml에서 파일 입력 설정
파일을 다시 읽어들이기 위한 Data 플래그 삭제
filebeat -> logstash 파이프라인
filebeat.yml 에서 Output.logstash 설정
logsatash 에서 beats 입력 설정
logstash output 설정
codec => dots 로 데이터 전송 과정 쉽게 확인하기
index : "%{+yyyy.MM.dd}" 날짜 별로 인덱스 지정
file beat는
path, elasticsearch: hosts, username password 필요함

---

인덱스 재색인
필드 매핑 개선
\_mapping 으로 자동 생성된 필드들의 정보 확인
적합하지 않은 타입의 필드들을 개선한 새 인덱스 생성

\_reindex api를 이용하여 새 인덱스로 재색인

````post _reindex {
  source: {index: "{source index}"},
  dest: { index: "{ target index}"}
}```
````

filebeat
데이터 수집을 경량화 하기 위한 목적으로 개발

---

이 로그 메시지를 파싱하기 위한 Grok 패턴을 작성해드리겠습니다.

로그 메시지:

```
172.18.0.8 - - [20/Aug/2024:19:50:53 +0000] "GET / HTTP/1.1" 200 615 "-" "curl/7.68.0" "-"
```

Grok 패턴:
apache combinedapachelog가 Deprecated 되어서

```
grok {
  match => {
    "message" => "%{IP:client_ip} %{WORD:ident} %{WORD:auth} \[%{HTTPDATE:timestamp}\] \"%{WORD:method} %{DATA:request} HTTP/%{NUMBER:http_version}\" %{NUMBER:response_code} %{NUMBER:bytes} \"%{DATA:referrer}\" \"%{DATA:user_agent}\" \"%{DATA:extra}\""}
}
```

각 필드에 대한 설명은 다음과 같습니다:

- `%{IP:client_ip}`: 클라이언트 IP 주소
- `%{WORD:ident}`: 식별자 (`-`)
- `%{WORD:auth}`: 인증 사용자 (`-`)
- `%{HTTPDATE:timestamp}`: 요청 시간 (예: `[20/Aug/2024:19:50:53 +0000]`)
- `%{WORD:method}`: HTTP 메소드 (`GET`, `POST` 등)
- `%{DATA:request}`: 요청 경로 (`/`)
- `%{NUMBER:http_version}`: HTTP 버전 (`1.1`)
- `%{NUMBER:response_code}`: 응답 코드 (`200`)
- `%{NUMBER:bytes}`: 응답 바이트 수 (`615`)
- `%{DATA:referrer}`: 참조자 (`-`)
- `%{DATA:user_agent}`: 사용자 에이전트 (`curl/7.68.0`)
- `%{DATA:extra}`: 추가 데이터 (`-`)

이 Grok 패턴을 사용하면 로그 메시지에서 다양한 필드를 추출할 수 있습니다.

---

인덱스 재색인
reindex
집계,검색에 필요한것들을 keyword,text

```
PUT mylog
{
    "mappings": {
      "properties": {
        "@timestamp": {
          "type": "date"
        },
        "@version": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword",
              "ignore_above": 256
            }
          }
        },
        "agent": {
          "properties": {
            "ephemeral_id": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256
                }
              }
            },
            "id": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256
                }
              }
            },
            "name": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256
                }
              }
            },
            "type": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256
                }
              }
            },
            "version": {
              "type": "text",
              "fields": {
                "keyword": {
                  "type": "keyword",
                  "ignore_above": 256
                }
              }
            }
          }
        },
        "body_bytes_sent": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword",
              "ignore_above": 256
            }
          }
        },
        "bytes": {
          "type": "long"
        },
```

---

Elasticsearch에서 필드의 타입을 `text`로 설정할지, `keyword`로 설정할지는 필드의 사용 용도에 따라 달라집니다. 이 둘의 차이점과 적절한 사용 방법을 이해하는 것이 중요합니다.

### `text` vs `keyword`

- **`text` 필드**:

  - **용도**: `text` 타입은 주로 전체 텍스트 검색(풀텍스트 검색, Full-text Search)을 위해 사용됩니다. 이 필드는 분석기(analyzer)를 통해 토큰화되고, 검색 가능한 여러 단어로 분해됩니다.
  - **검색 방식**: `text` 필드에 대해 검색할 때, 특정 단어를 기준으로 문서를 검색합니다. 예를 들어, "The quick brown fox"라는 문장이 `text` 필드에 저장되면, "quick", "brown", "fox"와 같은 개별 단어로 검색이 가능합니다.
  - **집계**: `text` 필드는 기본적으로 집계에 적합하지 않기 때문에, `text` 필드를 기준으로는 집계가 불가능합니다.

- **`keyword` 필드**:
  - **용도**: `keyword` 타입은 구조화된 데이터를 정확히 매칭하거나, 집계(Aggregation), 정렬(Sorting), 그리고 필터링을 위해 사용됩니다. 이 필드는 분석되지 않으므로, 필드 전체를 하나의 단위로 검색합니다.
  - **검색 방식**: `keyword` 필드는 분석되지 않으므로, 전체 값에 대해 정확히 일치하는 문서만 검색됩니다. 예를 들어, "The quick brown fox"라는 값이 `keyword` 필드에 저장되었다면, 전체 문장과 정확히 일치하는 검색어만 검색됩니다.
  - **집계**: `keyword` 필드는 집계에 최적화되어 있어, 이 필드를 기준으로 집계 쿼리를 실행할 수 있습니다.

### 적절한 사용 방법

1. **텍스트 검색이 필요한 필드**:

   - **`text` 필드로 저장**: 텍스트 검색이 주된 목적이라면, 예를 들어 블로그 게시글 내용, 리뷰, 댓글 등의 데이터는 `text` 타입으로 저장해야 합니다.
   - **예시**: "description", "body", "content"와 같은 필드.

2. **정확한 매칭, 집계, 정렬이 필요한 필드**:

   - **`keyword` 필드로 저장**: 카테고리, 태그, 사용자 ID, 상태 값, URL 등과 같은 데이터는 `keyword` 타입으로 저장해야 합니다. 이런 필드는 주로 집계 쿼리나 필터링, 정렬에 사용됩니다.
   - **예시**: "status", "username", "category", "tags", "email"와 같은 필드.

3. **혼합 사용**:

   - **`text`와 `keyword` 필드 모두 사용**: 때로는 동일한 필드를 `text`와 `keyword` 두 가지 타입으로 저장하는 것이 유용합니다. 이를 통해 동일한 데이터를 풀텍스트 검색과 정확한 매칭 및 집계 양쪽에 사용할 수 있습니다.
   - **방법**: 필드 매핑에서 `multi-fields`를 설정하여, 필드를 분석된 `text` 필드와 분석되지 않은 `keyword` 필드로 저장할 수 있습니다.

   ```json
   "field_name": {
     "type": "text",
     "fields": {
       "keyword": {
         "type": "keyword"
       }
     }
   }
   ```

   예를 들어, `username` 필드는 다음과 같이 설정할 수 있습니다:

   ```json
   "username": {
     "type": "text",
     "fields": {
       "keyword": {
         "type": "keyword"
       }
     }
   }
   ```

   이 설정을 통해 `username` 필드는 텍스트 검색에도 사용될 수 있고, 정확한 매칭 및 집계에도 사용될 수 있습니다.

### 결론

- **집계와 필터링**이 주된 목적이라면 `keyword`로 저장하는 것이 적합합니다.
- **텍스트 검색**이 주된 목적이라면 `text`로 저장합니다.
- 둘 다 필요한 경우에는 `multi-fields` 기능을 활용하여, 필드를 `text`와 `keyword` 모두로 저장할 수 있습니다.
  geoip를 쓴다면
  "location"은 "type": "geo_point"

  ***

인덱스 템플릿
index_template

---

키바나 인덱스 필터 만들기 -> data view
시계열 데이터를 만들기때문에 time field @Timestamp 날짜 타입 하나 지정해줘야됨
stack management
키바나 대시보드 create visualize
maps를 이용한 위치정보표시
maps 지도 추가
clusters and grids - geo_point로 위치 표시
choropleth - keyword 로 지역 표시
elastic map service
elastic 에서 서비스하는 지도 정보
World countries외 다양한 지도 데이터셋
Elasticsearch 쿼리 조회
view: request 메뉴에서 Kibana가 elasticsearch 로 요청하는 쿼리 확인
