<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>JQuery</title>
<link rel="stylesheet" id="easyuiTheme" type="text/css" href="./jquery-easyui-1.5.2/
	themes/gray/easyui.css">
<link rel="stylesheet" type="text/css" href="./jquery-easyui-1.5.2/themes/icon.css">
<link rel="stylesheet" type="text/css" href="./jquery-easyui-1.5.2/themes/color.css">
<link rel="stylesheet" type="text/css" href="./css/spectrum.css">
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./jquery-easyui-1.5.2/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="./js/echarts.js"></script>
<script type="text/javascript" src="./js/bmap.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=QI35PbXyYw28IT7FhGbtHIvE4GLfwDb2"></script>
<script type="text/javascript" src="./js/CurveLine.min.js"></script>
<script type="text/javascript" src="./js/myjs.js"></script>
<script type="text/javascript" src="./js/spectrum.js"></script>
<style type="text/css">
        html,body{
            height:100%;
            margin:0;
        }
</style>


</head>
<body>
<div id="p_data" class="easyui-window" title="Basic Window" data-options="iconCls:'icon-save',closed:true" style="width:500px;height:200px;padding:10px;">
        <p id='data_show'>信息反馈:</p>
        
    </div>
<!-- Add 'easyui-layout' class to <div/> markup. -->
<div id="layout" class="easyui-layout" style="width:100%;height:100%;">
    <div data-options="region:'north',split:true" style="height:50px;padding:10px">
            <!-- Create combobox from <select> element with a pre-defined structure. -->
            <select id="themeSelect" label = "Themes:" labelPosition = "left" class="easyui-combobox" name="dept" style="width:200px;" data-options="">
                <option value="gray" >gray</option>
                <option value="metro">metro</option>
                <option value= "blue">blue</option>
            </select>
            <a id="login" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-man'">
            <%if (session.getAttribute("username")==null){%>
				Login<%}else{%>
				Logout<%}%></a>
            <%if (session.getAttribute("username")==null){%>
				未登录
			<%}else {%>
				已登录，用户名：<%= session.getAttribute("username")%>
			<%session.removeAttribute("username"); }%>
    </div>
    <div data-options="region:'south',split:true" style="height:50px;"></div>
    <div data-options="region:'east',title:'East',split:true" style="width:200px;overflow:hidden">
        <table title="file_treegrid" class="easyui-treegrid" style="width:200px;height:250px"
            data-options="
                method: 'get',
                rownumbers: true,
                idField: 'id',
                treeField: 'name'
            ">
            <thead>
                <tr>
                    <th data-options="field:'name'" width="50">Name</th>
                    <th data-options="field:'size'" width="50" >Size</th>
                    <th data-options="field:'date'" width="100"align="left">Modified Date</th>
                </tr>
            </thead>
        </table>
        <div class="easyui-panel" style="padding:5px;height:100%">
       		<a id="addTop5" class="easyui-linkbutton" data-options="iconCls:'icon-tip'">添加涟漪</a>
	       	<a id="addEmploy" class="easyui-linkbutton" data-options="iconCls:'icon-tip'">添加雇佣</a>
	        <a id="addCity" class="easyui-linkbutton" data-options="iconCls:'icon-tip'">添加作者城市分布数据</a>
            <a id="drawTimeSeries" class="easyui-linkbutton" data-options="iconCls:'icon-tip'">绘制时间序列图</a>
            <ul id="layerTree" class="easyui-tree" onlyLeafCheck="true" dnd="true">
                <li id="layerFather">
                    <span>图层</span>
                        <ul></ul>
                </li>
            </ul>
	    </div>
	</div>
    <div data-options="region:'west',title:'West',split:true" style="width:200px;">
        <!-- Create accordion via markup, add 'easyui-accordion' class to <div/> markup. -->
        <div class="easyui-accordion" data-options="fit:true,border:false">
            <div title="Search" style="padding:10px"> 
                <label>请输入索引关键字：</label>
                <input class="easyui-searchbox" data-options="prompt:'eg.浙江大学',searcher:geoCoder" style="width:100%">
            	<input id="p_apiName" name="apiName" type="text" autocomplete="off" style="width:100px;height:20px;" onkeyup="autoComplete.start(event)">  
            	<a id="search" href="#" class="easyui-linkbutton"  onclick="bgsearch()">搜索</a>
            	<div class="auto_hidden" style="height: auto;left:300px;position:absolute; background-color: #F0F0F0;font-size: 15pt;" id="auto"></div>
            </div>
            <div title="Navigation" style="padding:10px;" data-option= "selected:true"> 
                 <form>
                    <p>方法一：在下面输入起点和终点，选择路径类型和出行方式，点击导航即可。</p>
                    <p>方法二：先在下方选择路径类型和出行方式，然后在地图上右键设置起点、终点、一系列途经点，右键导航即可。</p>
                    <hr>
                    <label>起点：</label>
                    <input type="text" class="easyui-textbox"  id="startid" style="height:25px;width:100%"data-options="prompt:'杭州',iconCls:'icon-edit',iconWidth:38">
                    <label>终点：</label>
                    <input type="text" class="easyui-textbox"  id="endid" style="height:25px;width:100%"data-options="prompt:'北京',iconCls:'icon-edit',iconWidth:38">
                    <br>
                    <div>
                        优先：
                        <div id="kind">
                             <select id="kindSelect" label = "Themes:" labelPosition = "top" class="easyui-combobox" style="width:150px;" data-options="">
                                <option value="0">最少时间</option>
                                <option value="1">最短距离</option>
                                <option value="2">避开高速</option>
                            </select>
                        </div>
                    </div>
                    <div  style="float:left; display:inline">
                         出行方式：
                        <div id= "way">
                            <select id="waySelect" label = "Themes:" labelPosition = "top" class="easyui-combobox" style="width:100px;" data-options="">
                                <option value="0">自驾</option>
                                <option value="1">公交</option>
                                <option value="2">步行</option>
                            </select>
                        </div>
                    </div>
                   <div style="position:relative;top:37px;float:right; display:inline">
                         <a id="result"  class="easyui-linkbutton" style="width:60px;" data-options="iconCls:'icon-search',iconWidth:38">导航</a>
                   </div>
                </form>
            </div>
            <div title="Maps" style="padding:10px">
                <p>保存当前地图的中心点和缩放等级</p>
                <a href="javascript:void(0)" class="easyui-linkbutton" id= "save_map"  data-options="iconCls:'icon-save'" style="width:90px">保存地图</a>
            	<br/>
            	<p>加载已登录用户的所有地图名</p>
            	<a href="javascript:void(0)" class="easyui-linkbutton" id= "find_map"  data-options="iconCls:'icon-mini-refresh'" style="width:90px">加载列表</a>
            	<br/>
            	<select class="easyui-combobox" id="mapSelect" label="Maps:" labelPosition="top" style="width:100%;">
            	</select>
            </div>
        </div>
    </div>
    <div data-options="region:'center',title:'Main Title',iconCls: 'icon-ok'" style="padding:5px;background:#eee;">
        <div id="centralTabs" class="easyui-tabs" style="width:100%;height:100%;" data-options = "selected:0">
           	<div id= "Echart" title="Echart" style="padding:5px;">
                <div>
                    <!-- 加入地图容器 -->
                    <div id="mapDiv2" style="width:100%;height:100%;overflow:hidden"></div>
                </div>
            </div>
            <div id= "map" title="Map" style="padding:20px;"></div>
            <div id= "beijing_3D" title="beijing_3D" style="padding:20px;display:none;"></div>
            <div title="DataGrid" data-options="closable:true" style="overflow:auto;">
                    <table id="tt" class="easyui-datagrid" style="width:100%;height:250px"
                        url=""
                        title="Load Data" iconCls="icon-search"
                        sortName="itemid" sortOrder="asc"
                        rownumbers="true" pagination="true">
                    <thead>
                        <tr>
                            <th field="itemid" width="80" sortable="true">Item ID</th>
                            <th field="productid" width="100" sortable="true">Product ID</th>
                            <th field="listprice" width="80" align="right" sortable="true">List Price</th>
                            <th field="unitcost" width="80" align="right" sortable="true">Unit Cost</th>
                            <th field="attr1" width="220">Attribute</th>
                        </tr>
                    </thead>
                </table>
                <table class="easyui-datagrid"
							data-options="url:'./data/datagrid_data.json',method:'get',
							singleSelect:true,fit:true,fitColumns:true">
						<thead>
							<tr>
								<th data-options="field:'itemid'" width="80">Item ID</th>
								<th data-options="field:'productid'" width="100">Product ID</th>
								<th data-options="field:'listprice',align:'right'" width="80">List Price</th>
								<th data-options="field:'unitcost',align:'right'" width="80">Unit Cost</th>
								<th data-options="field:'attr1'" width="150">Attribute</th>
								<th data-options="field:'status',align:'center'" width="50">Status</th>
							</tr>
						</thead>
					</table>
            </div>
        </div>
    </div>
</div>
<!-- Create window from markup. -->
<div id="loginWindow" class="easyui-window" title="User Logining" style="width:400px;height:190px;padding:5px"
        data-options="closed:false, headerCls:'wintitle',resizable:false,maximizable:false,iconCls:'icon-zju',cls:'c6'">
    <div class="easyui-layout" data-options = "fit:true">
             <div data-options="region:'center',border:false" style="padding:5px;background:#fff;border:1px solid #ccc;">
                <form id="loginForm" method="post" style="text-align:center">
                    <div style="padding:5px 0;">
                        <label>user name：</label>
                       <input type="text" class="easyui-textbox" name="username" id="username" style="width:260px;"data-options="prompt:'Username',iconCls:'icon-man',iconWidth:38">
                       <label>password：&nbsp&nbsp</label>
                       <input type="password" class="easyui-textbox" name="password" id="password" style="width:260px;" data-options="prompt:'Password',iconCls:'icon-lock',iconWidth:38">
                    </div>
                     <div style="margin-bottom:20px;position:absolute;left:50px">
                        <input type="checkbox" >
                        <span>Remember me</span>
                    </div>
                    <div style="margin-bottom:20px;position:absolute;left:200px">
                        <input type="checkbox">
                        <span>Automatic login</span>
                    </div>
                </form>
                 <div style="text-align:center;padding:5px;position:absolute;top:100px;left:35%;">
                    <!-- <a href="javascript:void(0)" class="easyui-linkbutton" id= "login" style="width:60px">Login</a> -->
                     <a href="javascript:void(0)" class="easyui-linkbutton" id= "login_in"  style="width:60px">Login</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#loginWindow') .window('close')" style="width:60px">Cancel</a>
                </div>
            </div>
    </div>
</div> 

 <!-- 图层树右键菜单 -->
<div id="layerMenu" class="easyui-menu" style="width:120px;">
	<div id="changeStyle" data-options="iconCls:'icon-edit'">自定样式</div>
	<div id="removeLayer" data-options="iconCls:'icon-no'">移除</div>
</div>

<!-- 自定义样式窗口 -->
<div id="style" class="easyui-window" title="样式设计" data-options="minimizable:false,maximizable:false,closed:true" style="width:500px;height:300px;padding:10px">
     <div>
          	<p>Visual Map</p>
          	<input type='color' id='v_color1' value='#3355cc'/>
			<input type='color' id='v_color2' value='#3355cc'/>
			<input type='color' id='v_color3' value='#3355cc'/>
       	</div>
       	<div>
       		<a>符号大小min</a><input class="easyui-textbox" id="size_symbol_min" style="width:100px;height:40px;padding:12px">
       		<a>max</a><input class="easyui-textbox" id="size_symbol_max" style="width:100px;height:40px;padding:12px">
       		<select class="easyui-combobox" label="符号形状选择:" labelPosition="top" style="width:80px;" id='symbol_ph'>
               <option value="circle">圆</option>
               <option value="rect">长方形</option>
               <option value="rounRect">圆角矩形</option>
               <option value="triangle">三角形</option>
               <option value="diamond">钻石型</option>
               <option value="pin">点</option>
               <option value="arrow">箭头</option>
          	</select>
       	</div>	
      	<div>
           <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="padding:5px 0px;width:100%;" id ="change_style">
               <span style="font-size:14px;">确定</span>
           </a>
      	</div>
</div>
		
</body>
</html>
