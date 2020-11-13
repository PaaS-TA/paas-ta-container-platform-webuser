# paas-ta-container-platform-webuser

PaaS-TA 에서 제공하는 컨테이너 플랫폼 관리를 용이하게 하기 위하여 제공하는 UI 애플리케이션 입니다.
* WEB USER는 사용자 UI 입니다.

- [시작하기](#시작하기)
  - [컨테이너 플랫폼 WEB USER 빌드 방법](#컨테이너-플랫폼-WEB-USER-빌드-방법)
- [문서](#문서)
- [개발 환경](#개발-환경)
- [라이센스](#라이센스)

## 시작하기
PaaS-TA 컨테이너 플랫폼 WEB USER가 수행하는 애플리케이션 관리 작업은 다음과 같습니다.

- 컨테이너 플랫폼 자원 관리
- 권한 관리
- 사용자 관리

### 컨테이너 플랫폼 WEB USER 빌드 방법
PaaS-TA 컨테이너 플랫폼 WEB USER 소스 코드를 활용하여 로컬 환경에서 빌드가 필요한 경우 다음 명령어를 입력합니다.
```
$ gradle build
```


## 문서
- 전체 컨테이너 플랫폼 관련 문서를 보려면 http://www.paas-ta.co.kr 을 참조하십시오.
- 컨테이너 플랫폼 활용에 대한 정보는 https://github.com/PaaS-TA/service-deployment 의 README를 참조하십시오.


## 개발 환경

| Situation                      | Version |
| ------------------------------ | ------- |
| JDK                            | 8       |
| Gradle                         | 6.5     |
| Spring Boot                    | 2.3.3   |
| Spring Boot Management         | 1.0.10  |
| Spring Security Tag Libs       | 5.3.3   |
| Tomcat Embed Jasper            | 9.0.36  |
| Jstl                           | 1.2     |
| Apache Tiles / Jsp             | 3.0.8   |
| Gson                           | 2.8.6   |
| Lombok                         | 1.18.12 |
| Swagger	                       | 2.9.2   |


## 라이센스

[Apache-2.0 License](http://www.apache.org/licenses/LICENSE-2.0)
