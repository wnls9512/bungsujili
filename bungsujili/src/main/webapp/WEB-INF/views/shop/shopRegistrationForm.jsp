<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 한글 인코딩 처리  -->
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header2.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>


    <section class="contact-us" id="contact-section"> 
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-8">
                
                <!-- Please visit https://templatemo.com/contact page if you do not know how to setup the contact form -->
                
                    <form id="shopRegistrationForm" class="contact" action="${pageContext.request.contextPath }/shop"
						  method="post" enctype="multipart/form-data">
                        <input type="hidden" name="memberId" value="${ loginMember.memberId }" />
                        <input type="hidden" name="lat" value=""/>
                        <input type="hidden" name="lon" value=""/> 
                        <div class="row">
                            <div class="">
                              <fieldset>
                              	<label for="sTitle" class="text-light">가게명</label>
                                <input type="text" class="form-control input" id="sTitle" name="sTitle" placeholder="가게명" required>
                              </fieldset>
                            </div><br />
                            <span class="text-center text-light">정확한 위치를 클릭해 마커를 위치시켜주세요!</span>
                            <div id="map" style="width:100%;height:350px;z-index:100;"></div>
                            <div id="clickLatlng" class="mb-3 text-light"></div>
                            <div class="">
                              <fieldset>
                              	<label for="addr" class="text-light">가게주소</label>
                                <input type="text" class="form-control input text-dark fw-bold" id="addr" name="addr" placeholder="가게주소" readonly>
                              </fieldset>
                            </div>
                          
                            <div class="input-group mb-3">
								<label for="imgFile" class="text-light">이미지 첨부</label>
							    <input type="file" class="form-control-file input" id="imgFile" name="imgFile">
							</div>

                            <div>
                            	<label for="sContent" class="text-light">내용</label>
                            	
	                            <div id="category">
	                            	<div class="form-check form-check-inline">
									  <input class="form-check-input" type="checkbox" name="sMenu" id="menu0" value="1">
									  <label class="form-check-label text-light" for="menu0">팥붕어빵</label>
									</div>
	                            	<div class="form-check form-check-inline">
									  <input class="form-check-input" type="checkbox" name="sMenu" id="menu1" value="2">
									  <label class="form-check-label text-light" for="menu1">슈크림붕어빵</label>
									</div>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="checkbox" name="sMenu" id="menu2" value="3">
									  <label class="form-check-label text-light" for="menu2">계란빵</label>
									</div>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="checkbox" name="sMenu" id="menu3" value="4">
									  <label class="form-check-label text-light" for="menu3">호떡</label>
									</div>
	                            </div>
                            	
                            	<textarea name="sContent" class="form-control" id="sContent" cols="30" rows="10"
                            			  placeholder="ex) 슈크림 붕어빵, 팥 붕어빵 있어요! 세 개에 천 원!"></textarea>
                            </div>
                            <div class="">
                              <fieldset>
                                <button type="submit" id="form-submit" class="btn text-center">제보하기</button>
                              </fieldset>
                            </div>

                        </div>
                    </form>
                </div>
                <div class="col-md-4">
                    <div class="contact-right-content">
                        <div class="icon"><img src="${pageContext.request.contextPath }/resources/img/map-marker-icon.png" alt=""></div>
                        <h4>You can find us on maps</h4>
                    </div>
                </div>
            </div>
        </div>
    </section>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f6d8fdaa58f0a1c4fb7cfa958eddc3fe&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
        
        var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다

        map.setCenter(locPosition);  // 중심으로 위치시키기

	    
 
      });
    
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation을 사용할수 없어요..'
        
    displayMarker(locPosition, message);
}

//지도를 클릭한 위치에 표출할 마커입니다
var marker = new kakao.maps.Marker({ 
// 지도 중심좌표에 마커를 생성합니다 
position: map.getCenter() 
}); 

//지도에 마커를 표시합니다
marker.setMap(map);
 
//지도에 클릭 이벤트를 등록합니다
//지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        

	// 클릭한 위도, 경도 정보를 가져옵니다 
	var latlng = mouseEvent.latLng; 
	
	// 마커 위치를 클릭한 위치로 옮깁니다
	marker.setPosition(latlng);
	
	var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
	message += '경도는 ' + latlng.getLng() + ' 입니다';
	
	var resultDiv = document.getElementById('clickLatlng'); 
	resultDiv.innerHTML = message;
	$("[name=lon]").val(latlng.getLng());
	$("[name=lat]").val(latlng.getLat());

	// 좌표값으로 주소 가져오기
    var address;
    geocoder.coord2RegionCode(latlng.getLng(), latlng.getLat(), function(result, status){
	    
    	if (status === kakao.maps.services.Status.OK) {
        	address = result[0].address_name;
       	}

	$("[name=addr]").val(address);
   
    });
	
});




</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
   
