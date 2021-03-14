# KakaoImageSearch

## Introduction  
카카오 검색API와 RxSwift, RxCocoa, MVVM 패턴을 기반으로 이미지 검색 앱을 구현하였습니다. 

## Demo
![Mar-08-2021 22-50-45](https://user-images.githubusercontent.com/60660894/110330122-beb9de80-8060-11eb-9a48-cc6d862a70d1.gif)
![Mar-08-2021 22-48-16](https://user-images.githubusercontent.com/60660894/110330143-c6798300-8060-11eb-893d-2e11fcb50e15.gif)

## Requirement 
 - 카카오 Developer 계정은 개인 계정으로 만듭니다.
 - UISearchBar에 문자를 입력 후 1초가 지나면 자동으로 검색이 됩니다.(Debounce 1초)
 - 검색어가 변경되면 목록 리셋 후 다시 데이터를 fetch 합니다.
 - 데이터는 30개씩 페이징 처리합니다. (최초 30개 데이터 fetch 후 스크롤 시 30개씩 추가 fetch)
 - 검색 결과 목록은 UICollectionView를 사용하여 3xN 그리드 모양으로 구성합니다.
 - 검색 결과가 없을 경우 '검색 결과가 없습니다.' 메시지를 화면에 보여줍니다.
 - 검색 결과 목록 중 하나를 탭 하였을 때 전체 화면으로 이미지를 보여줍니다. 
 - 좌우 여백이 0이고, 이미지 비율은 유지하도록 보여줍니다.
 - 이미지가 세로로 길 경우 스크롤 됩니다.
 - response 데이터에 출처 'display_sitename', 문서 작성 시간 'datetime'이 있을 경우 전체화면 이미지 밑에 표시해 줍니다.

## Skill
RxSwift, RxCocoa, Codable, Storyboard, UIKit, Driver, Bind

## Test
Mock을 사용한 네트워킹 테스트 추가

## Architecture
MVVM, Reactive Programming

## Library 
Alamofire, RxSwift, Rxcocoa

## API 
https://developers.kakao.com/docs/latest/ko/daum-search/dev-guide

