> # 기웃기웃 (Swift App Project)

<br>

> ## Index
1. [프로젝트 소개](#프로젝트-소개)
2. [개발 배경](#개발-배경)
3. [개발 기간](#개발-기간)
4. [개발 환경](#개발-환경)
5. [SFD](#SFD)
6. [주요 기능](#주요-기능)

<br>

> ## 프로젝트 소개
- 날씨 api를 기반으로 한 기온별 옷차림 추천 APP

<br>

> ## 개발 배경
- 기온에 맞는 옷차림을 추천하여 사용자가 날씨에 적절하게 대처할 수 있도록 돕기 위해 개발

<br>

> ## 개발 기간
- 2024.06.13 (목) ~ 2024.06.18 (화)

<br>

> ## 개발 환경
<table>
  <tr>
    <th align="center">OS</th>
    <th align="center">Language</th>
    <th align="center">FrameWork</th>
    <th align="center">Server</th>
    <th align="center">DataBase</th>
    <th align="center">IDE</th>
  </tr>
  <tr>
    <td align="center">MAC OS</td>
    <td align="center">Swift</td>
    <td align="center">SwiftUI</td>
    <td align="center">Flask</td>
    <td align="center">SQLite<br>MySQL(v8.3.0)</td>
    <td align="center">Visual Studio code(v1.90.1)<br> Xcode(v15.4)</td>
  </tr>
</table>

<br>

> ## SFD
<img width="600" alt="스크린샷 2024-06-18 오후 6 00 58" src="">

<br>

> ## 주요 기능
- openweatherapi로 날씨 정보 불러오기
- 유저에게 입력받은 보유 옷 정보 Restful API(Python, Flask)를 이용하여 MySQL에 저장
- 유저가 보유한 옷을 통해 날씨별 옷차림 추천하여 화면에 출력
