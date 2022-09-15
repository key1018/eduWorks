<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



<style>
	td, th{
            border: 1px solid #858796;
            
            
            padding: 0 0 5px 0;
        }
        .tb6 td,.tb6 th{
            border: 0;
            padding:0px;
        }
        .tb6 th{width: 40%;}
        .positionab{
            position:absolute ;
            top: 0;
            padding: 30px;
        }
        .detailInfo{
            background-color: whitesmoke;
            width: 500px;
            height: 600px;
            left: 25%;
            z-index: 10;
           
            box-shadow: 10px 10px 20px grey;
        }

       
        .close {
        position:relative;
        display:inline-block;
        display:inline;
        width:50px;
        height:50px;
        text-align:center;
        
        
        }
        .close2:after {
        content: "\00d7"; 
        font-size:25pt;
        line-height:45px;
        }
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../personnel/personnelCss.jsp" />
		
		<!--Begin of Main Content -->
                <!-- Begin Page Content -->
                <div class="container-fluid" style="padding: 10px;">
                   
                    <div class="container-fluid su_contentArea" style="padding-left: 10px;">
                        <div class="su_content_header">
                            <h2 class="su_sub_menu_name">출퇴근관리</h2>
                            <hr class="hr_line" style="border: 0px; height: 3px; width: 1000px; background-color: #5e7e9b;">

                            <div  style="margin-left: 10px; padding: 30px;  width: 1000px; height: 250px;" align="center">
                                <h3>2022-08-20(토)</h3> <br>
                                <h3>08:59:59</h3> <br>
                                <span>
                                    <button type="button" class="btn su_btn_border">출근하기</button>
                                </span>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span>
                                    <button type="button" class="btn su_btn_border">퇴근하기</button>
                                </span>
                            </div>
                            <br>

                            <div style="float: left;">
                                <h2 class="su_sub_menu_name">근무내역관리</h2>
                            </div>
                            <div style="float: right;">
                                <button type="button" class="btn su_btn_border">조정신청현황</button>
                            </div>
                            
                            <hr class="hr_line" style="border: 0px; height: 3px; width: 1000px; background-color: #5e7e9b; clear: both;">
                            <div style="margin-left: 10px; padding-top: 30px;  width: 1000px; height: 100px; position: relative;" >
                                <table style="width: 100%;">
                                    <tr>
                                        <th style="width: 33%;">정상</th>
                                        <th style="width: 33%;">지각/조퇴</th>
                                        <th style="width: 33%;">결근</th>
                                    </tr>
                                    <tr>
                                        <th>3</th>
                                        <th>2</th>
                                        <th>1</th>
                                    </tr>
                                </table>
                                <div class="detailInfo positionab" id="div1" style="display: none;">
                                    
                                            
                                    <div class="close close2"></div>
                                    
                                    
                                    <div  align="left" style="font-size: 25px; font-weight: bold; color: black;">근태조정신청</div>
                                    
                                    <br>
                                    <form>
                                        <table style="width: 100%;" class="tb6" >
                                            <tr>
                                                <th>변경신청날짜</th>
                                                <td style="padding-bottom: 20px;">&nbsp;<input type="text" style="width:100%;" id="date1"></td>
                                            </tr>
                                            <tr>
                                                <th>신청날짜 근태현황</th>
                                                <td style="padding-bottom: 20px;">&nbsp;<input type="text" style="width:100%;"></td>
                                            </tr>
                                            <tr>
                                                <th>조정내용/사유</th>
                                                <td>&nbsp;<textarea name="" id="" cols="30" rows="5" style="resize: none;"></textarea></td>
                                            </tr>
                                            <tr>
                                                <th>파일첨부</th>
                                                <td style="padding-bottom: 20px;">&nbsp;<input type="file" style="width:100%;"></td>
                                            </tr>
                                        </table>
                                        <br>
                                        <div align="center">
                                            <button type="button" class="btn su_btn_two su_btn_all" id="submitBtn" data-toggle="modal" data-target="#noContent" style="width: 180px;">근태조정 신청하기</button>
                                        </div>
                                        <br><br>   
                                        <div align="center">
                                            <span class="arrowL" style="margin-right:100px ;"></span>
                                            <span class="arrowR"></span>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div id='calendar' style="margin-left: 10px; padding-top: 30px;  width: 1000px; height: 500px; " >
                                
                            </div>
                        
                        </div>

                        <script>

                        function test1(date){
                            $('#div1').css('display','')
                            $('#date1').val(date)
                        }

                        $('.close').click(function(){
                            $('#div1').css('display','none')
                            $('#date1').val('')
                        })

                        document.addEventListener('DOMContentLoaded', function() {
                            var calendarEl = document.getElementById('calendar');
                            var calendar = new FullCalendar.Calendar(calendarEl, {
                                googleCalendarApiKey:'AIzaSyDmZOm2L_dmlilRRiPofCxoijwfXMwAObY',
                                eventSources:[{
                                    googleCalendarId:'ko.south_korea#holiday@group.v.calendar.google.com',
                                    className:'대한민국의휴일',
                                    color:'red'
                                }],
                                initialView: 'dayGridMonth',
                                locale: 'ko',
                                headerToolbar: {         
                                    left: 'prevYear,prev,today',          
                                    center: 'title',          
                                    right: 'dayGridMonth,next,nextYear' //timeGridWeek,timeGridDay,        
                                },
                                
                                dateClick: function(info) {
                                    let clickDate = new Date(info.dateStr)
                                    let currentDate = new Date()
                                    if(clickDate<currentDate){
                                    	test1(info.dateStr);
                                    }else{
                                    	alert('유효한날짜를 선택하세요.')
                                    }
                                },
	
                                

                                navLinks: true,
                                navLinkDayClick: function(date,jsEvent){
                    
                                    console.log('day',date.toISOString().slice(0, 10));
                    
                                    //console.log('coords',jsEvent.pageX,jsEvent.pageY);
                                    var timezoneOffset = date.getTimezoneOffset() * 60000;
                                    var kr = new Date(date - timezoneOffset);
                                    alert(kr.toISOString());
                                   
                
                                    $('#div1').css('display','')
                                    $('#date1').val(kr.toISOString().slice(0, 10))
                    
                                }, 
                                events : [
                                    {
                                        title: '출근 08:55',
                                        start: '2022-09-01',
                                        
                                    },
                                    {
                                        title: '퇴근 18:00',
                                        start: '2022-09-01'
                                    }
                                ]
                            });
                            calendar.render();
                            $(".fc-prev-button").click(function() {
                                var date = calendar.getDate();
                                var month = new Date(date).getMonth()
                                var year = new Date(date).getFullYear()
                                if(month+1<10){
                                    alert(year+'-0'+(month+1))
                                }else{
                                    alert(year+'-'+(month+1))
                                }
                            });
                            $(".fc-next-button").click(function() {
                                var date = calendar.getDate();
                                var month = new Date(date).getMonth()
                                var year = new Date(date).getFullYear()
                                if(month+1<10){
                                    alert(year+'-0'+(month+1))
                                }else{
                                    alert(year+'-'+(month+1))
                                }
                            });
                            $(".fc-prevYear-button").click(function() {
                                var date = calendar.getDate();
                                var month = new Date(date).getMonth()
                                var year = new Date(date).getFullYear()
                                if(month+1<10){
                                    alert(year+'-0'+(month+1))
                                }else{
                                    alert(year+'-'+(month+1))
                                }
                            });
                            $(".fc-nextYear-button").click(function() {
                                var date = calendar.getDate();
                                var month = new Date(date).getMonth()
                                var year = new Date(date).getFullYear()
                                if(month+1<10){
                                    alert(year+'-0'+(month+1))
                                }else{
                                    alert(year+'-'+(month+1))
                                }
                            });
                            $(".fc-today-button").click(function() {
                                var date = calendar.getDate();
                                var month = new Date(date).getMonth()
                                var year = new Date(date).getFullYear()
                                if(month+1<10){
                                    alert(year+'-0'+(month+1))
                                }else{
                                    alert(year+'-'+(month+1))
                                }
                            });
                        });
                            </script>
                        

                        <!-- 게시글 영역 -->
                        
                    </div>
                    
                </div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>