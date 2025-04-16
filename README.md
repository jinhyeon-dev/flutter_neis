# flutter_neis
![pub version](https://img.shields.io/pub/v/flutter_neis)

**Flutter에서 NEIS 교육정보 개방 포털을 간편하게 사용할 수 있도록 도와주는 패키지입니다.**  
학교 기본 정보, 급식 정보 등을 학교 이름 기반으로 간단하게 조회할 수 있습니다.

## 주요 기능

- 학교정보 조회

## 사용 예시

```dart
final neis = Neis(apiKey: 'YOUR_API_KEY');
await neis.loadSchoolInfo('경북소프트웨어마이스터고등학교');
```

## 지원 중인 메서드
### loadSchoolInfo

학교 이름으로 학교 정보를 불러옵니다.
교육청 코드(ATPT_OFCDC_SC_CODE)와 학교 코드(SD_SCHUL_CODE)를 자동 저장합니다.

```dart
await neis.loadSchoolInfo('학교명');
print(neis.schoolCode);
print(neis.officeCode);
```


## 설치

```yaml
dependencies:
  flutter_neis: ^1.0.0
