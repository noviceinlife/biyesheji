<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<script language="javascript" type="text/javascript">
  function uploadImg()
  {
	var user = window.parent.user_id;
	if(user==''){
		alert('请先登录后再进行操作！')
		return;
	}
    if(document.getElementById("fileurl").value=="")
    {
       alert("请选择上传的图片！");
       return false;
    }
    var showload = window.parent.document.getElementById("op");
    showload.style.display="";
    document.upImgFrm.submit();
  }
  
  function file_change(e){
	document.getElementById("upfile").value = e;
 }
</script>
</head>
<body bgcolor="#DFEDFF">
<form name="upImgFrm" method="post" action="UploadImg.action" style="padding:0px;margin:0px;" enctype="multipart/form-data">
<input type="text" name="upfile" id="upfile" style="border:1px dotted #ccc;width:150px">  
<input type="file" id="fileurl" name="upload" style="filter:alpha(opacity=5);position:absolute;opacity:0;width:60px;height:21px" onchange="file_change(this.value)"/>
<input type="button" value="浏览" onclick="fileurl.click()" class="btnstyle" style="width:60px">&nbsp;&nbsp; &nbsp;  
<input type="button" class="btnstyle" value="上传" onclick="uploadImg();"/>&nbsp;
<br/>
<span id="upTip" style="color:red"></span>
</form>
<script language="javascript">
<!--  
  var flag = "${tip}";
  var filename = "${filename}";
  if(flag=='ok')
  {
    var userPhoto= window.parent.document.getElementById("goods_pics");
    if(userPhoto.value==""){
    	userPhoto.value=filename;
    }else{
    	userPhoto.value+=","+filename;
    }
    window.parent.document.getElementById("op").style.display="none";
    document.getElementById("upTip").innerHTML="上传成功！";
    var innerHtml = "<div style='margin-left:5px;height:80px;width:60px;float:left;text-align:center'><img src='images/goodss/"+filename+"' width='60' height='60'/>"
    			  + "<br/><a href='javascript:void(0)' id='delPic_"+filename.replace('.','P')+"'>删除</a>"
    			  + "</div>"
    window.parent.document.getElementById("pic").innerHTML+=innerHtml;
  }
  else if(flag=='no')
  {
    window.parent.document.getElementById("op").style.display="none";
    document.getElementById("upTip").innerHTML="${errorString}";   
  }
-->        
</script>
</body>
</html>