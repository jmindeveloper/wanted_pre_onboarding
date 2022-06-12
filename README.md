 wanted_pre_onboarding
## wanted_pre_onboarding ios 과제
---

### Weather 
### App Screenshot

<p>
<img src = "https://github.com/jmindeveloper/wanted_pre_onboarding/blob/main/Weather/screenshot/appImage/main.png?raw=true" width="200" height= "400">
<img src = "https://github.com/jmindeveloper/wanted_pre_onboarding/blob/main/Weather/screenshot/appImage/detail.png?raw=true" width="200" height= "400">
</p>

### networking
Combine 사용
<img src = "https://github.com/jmindeveloper/wanted_pre_onboarding/blob/main/Weather/screenshot/networking/1.png?raw=true">

* combine을 이용해서 도시정보(도시이름, 경위도) 및 도시날씨정보 받아서 AnyPublisher로 반환
  
<img src = "https://github.com/jmindeveloper/wanted_pre_onboarding/blob/main/Weather/screenshot/networking/2.png?raw=true">

* 도시 정보 및 도시 날씨정보를 모아서 배열로 만들어 AnyPublisher로 반환

<img src = "https://github.com/jmindeveloper/wanted_pre_onboarding/blob/main/Weather/screenshot/networking/3.png?raw=true">

* viewmodel에서 구독

### Image Caching
<img src = "https://github.com/jmindeveloper/wanted_pre_onboarding/blob/main/Weather/screenshot/ImageCaching/1.png?raw=true">

* dictionary로 관리
  * key: imageURL, value: imageData

<img src = "https://github.com/jmindeveloper/wanted_pre_onboarding/blob/main/Weather/screenshot/ImageCaching/2.png?raw=true">

* url에 해당하는 imgaeData 있을시
  * 해당 imageData 가져와서 사용
* url에 해당하는 imgaeData 없을시
  * 네트워크 통신으로 imageData 가져와서 사용 및 캐싱