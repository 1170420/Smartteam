package com.shpr.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.shpr.pojo.Collection;
import com.shpr.pojo.Content;
import com.shpr.pojo.ShoppingActive;
import com.shpr.pojo.ShoppingUserSimilarity;
import com.shpr.pojo.User;
import com.shpr.pojo.onecategory;
import com.shpr.service.ContentService;
import com.shpr.service.UserService;
import com.shpr.tools.RecommendUtils;



@Controller
@RequestMapping("count")
public class ContentController {
	private static Logger logger = Logger.getLogger(UserController.class);
	
	@Autowired
	UserService userService;
	@Autowired
	ContentService contentService;
	
	
    //用户信息
	@RequestMapping("contentList")
	public ModelAndView contentInforList(){
		ModelAndView model = new ModelAndView("admin/contentInformation");
		return model;
	}
	
	//管理信息
	@RequestMapping("AdminContentList")
	public ModelAndView contentList1(){
		ModelAndView model = new ModelAndView("admin/AdminContentList");
		return model;
	}
	
	//用户收藏
	@RequestMapping("shoucuang")
	public ModelAndView shoucuang(){
		ModelAndView model = new ModelAndView("admin/shoucuanguser");
		return model;
	}
	
	//获取到的数据表 
	@RequestMapping(value="/getContentList")
	@ResponseBody
	public List<Content> getContentist(){
		return contentService.getContentist();
	}
	//批量删除
	@RequestMapping(value="/deleteContents")
	public void deleteContent(int[] ids,HttpServletResponse response){
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		contentService.deleteContent(ids); //直接传数组
		if (ids != null ) {
	        out.print("1");
	    }else{
	        out.print("2");
	    }
		out.flush();
		out.close();
	}
	//添加需求
	@RequestMapping(value="/To_AddCountinformation")
	public ModelAndView ToAddCountinformation(HttpSession session){
		ModelAndView model = new ModelAndView("admin/addCountInformation");
		User user = (User)session.getAttribute("user");
		logger.info("添加内容作者"+user);
		session.setAttribute("user", user);
		return model;
	}
	//修改信息
	@RequestMapping(value="/updataContents")
	public void updataContents(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out = null;
		try {
			out=response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		int id = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		System.out.println(content);
		String author = request.getParameter("author");
		String time = request.getParameter("count_time");
		String click = request.getParameter("click");
		
		Content contente = new Content();
		contente.setId(id);
		contente.setTitle(title);
		contente.setContent(content);
		contente.setAuthor(author);
		contente.setTime(time);
		contente.setClick(click);
		
		if(contentService.updataContentInfo(contente)==1){
			out.print("1");
		}else{
			out.print("0");
		}
		out.flush();
		out.close();
	}
	//保存系统信息
	@RequestMapping(value="/saveCountInfo")
	public void saveCountInformation(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out = null;
		try {
			out=response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		int boj = Integer.parseInt(request.getParameter("category2_id"));
		System.out.println(boj);
		long category2_id = (int)boj;
		System.out.println(category2_id);
		String title = request.getParameter("title");
		String content1 = request.getParameter("content");
		String author = request.getParameter("author");
		String count_time = request.getParameter("count_time");
		String need_select = request.getParameter("need_select");
		logger.info("==标题=="+title);
		logger.info("==内容=="+content1);
		logger.info("==时间=="+count_time);
		logger.info("===状态=="+need_select);
		Content content = new Content();
		content.setTitle(title);
		content.setContent(content1);
		content.setAuthor(author);
		content.setTime(count_time);
		content.setClick(need_select);
		content.setCategory2_id(category2_id);
		if(contentService.saveContentInfo(content)==1){
			out.print("1");
		}else{
			out.print("0");
		}
		out.flush();
		out.close();
	}
	@RequestMapping(value="/getAllContentList")
	@ResponseBody
	public ModelAndView getAllContentist(){
		ModelAndView model = new ModelAndView("index");
		List<Content> contentsList = contentService.getContentist();
		model.addObject("contentsList",contentsList);
		return model;
	} 
	
	//点击量
	@RequestMapping(value = "/insertClick")
	public void insertClick(HttpServletResponse response,Integer id){
		PrintWriter out = null;
		try {
			out=response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
	
		Content  count = contentService.selectById(id);

		int n = (int)count.getOnclick();
		n = n + 1;
		
		count.setOnclick(n);
		count.setId(id);
		
		contentService.updateClick(count);
		
		out.print("success");
		out.close();
		out.flush();
	}

	//获取自己的信息
	@RequestMapping(value="/secleteAuthor")
	@ResponseBody
	public List<Content> secleteAuthor(String author){
		return contentService.secleteAuthor(author);
	}
	
	//获取收藏列表数据
	@RequestMapping(value="/secleteContent")
	@ResponseBody
	public List<Content> secleteContent(String author){
		int[] ids = new int[100];  //初始化数组长度100
		List<Collection> collection= contentService.secleteContent(author);
		for(int i=0 ;i<collection.size();i++){
			ids[i]=collection.get(i).getId();
			
		}
		List<Content> content = contentService.secleteColle(ids);
		return content;
	}
	
	
	//收藏信息
	@RequestMapping(value="/shoucuanguser")
	@ResponseBody
	public void shoucuanguser(HttpServletRequest request,HttpServletResponse response,Integer id,String author){
		PrintWriter out = null;
		try {
			out=response.getWriter();
		} catch (IOException e) 
		{
			e.printStackTrace();
		}
		
		Collection collection = new Collection();
		collection.setId(id);
		collection.setAuthor(author);
		JSONObject json = new JSONObject();
		Collection s = contentService.findCollection(id,author);
		if(s == null || "".equals(s)){
			
		if(contentService.SaveCollection(collection)==1)
		{
		json.put("data", "1");
		out.print(json);
		}
		}else{
		  	
		contentService.deleteCollection(id,author);
		json.put("data", "0");
		out.print(json);
		}
		out.close();
		out.flush();
		
	}
	//用户特长、爱好
	@RequestMapping(value="/findUserhobby")
	@ResponseBody
	public  Map <String, String> findUserhobby(String author){
		    Map<String, String> resultMap = new HashMap<>();
			User user = contentService.secleteUserhobby(author);
			if(null != user){
				    resultMap.put("code", "1");
		            resultMap.put("msg", "查找成功!");
					//resultMap.put("data", user); //返回整条数据全部
					resultMap.put("hobby",user.getUser_hobby()); //返回单条数据 get()方法
					resultMap.put("specialty", user.getUser_specialty());
			}else{
					resultMap.put("code", "0");
		            resultMap.put("msg", "没有数据!");
				}
				 return resultMap;
			}
	/*//搜索功能
	@RequestMapping(value="/UserSearch")
	@ResponseBody
	public Map <String, Object> UserSearch(String content){
		Map<String,Object> resultMap = new HashMap<>();
		List<Content> search = contentService.UserSearch(content);
		String json = JSON.toJSONString(search);
		System.out.println(json);
		if(search!=null)
		{
			resultMap.put("code", "1");
			resultMap.put("msg", "查找成功！");
			resultMap.put("data", json);
		}
		else{
			resultMap.put("code", "0");
            resultMap.put("msg", "没有数据!");
		}
		return resultMap;
		
	}*/
	
	/*//智能推荐IntelligenceRecommend
	@RequestMapping(value="/IntelligenceRecommend")
	@ResponseBody
	
	public List<Content> IntelligenceRecommend(String author){
		
		List<Content> role = contentService.secleteAuthor(author);
		if( role == null || role.size() ==0)
		{
			System.out.println("新用户");
			int click=0;//点击量
			int hobby=0;//爱好
			int id=0;
			User hobby1 = contentService.secleteUserhobby(author);
			String user_hobby = hobby1.getUser_hobby();
			String user_specialty = hobby1.getUser_specialty();
			System.out.println(user_hobby);
			System.out.println(user_specialty);
			
			Content hobby2 = contentService.secleteContenthobby(user_hobby,user_specialty);
			System.out.println(hobby2);
		    id=hobby2.getId();
			if(hobby2!=null)
			{
				hobby=1;
				contentService.insertState(id,hobby);
			}
		
			
	
		}
		else {
			
			System.out.println("老用户");
			
			
 
		}
		return role;
		
	}*/
	
	/**
	 * 管理员一级类目
	 */
	@RequestMapping(value="To_AddCountinOne")
	@ResponseBody
	public ModelAndView To_AddCountinOne(){
		ModelAndView model = new ModelAndView("admin/onecategory");
		return model;
	}
	
	/**
	 * 管理员二级类目
	 */
	@RequestMapping(value="To_AddCountinTow")
	@ResponseBody
	public ModelAndView To_AddCountinTow(){
		
		ModelAndView model = new ModelAndView("admin/towcategory");
		return model;
		
	}
	/**
	 * 用户展示一级类目
	 */
	@RequestMapping("/To_AddcategoryOne")
	@ResponseBody
	public ModelAndView To_AddcategoryOne(){
		ModelAndView model = new ModelAndView("admin/addOnecategory");
		
		return model;
	}
	
	/**
	 * 用户展示二级类目
	 */
	@RequestMapping("/To_AddcategoryTow")
	@ResponseBody
	public ModelAndView To_AddcategoryTow(){
		ModelAndView model = new ModelAndView("admin/addTowcategory");
	
		return model;
	}
	
	
	
	
	/**
	 * @category 用户访问二级kw，添加用户历史访问记录
	 * @param   user_id category2_id
	 * @return 返回商品列表页面
	 */
	@RequestMapping(value="findProductListByCategory2Id",method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> findProductListByCategory2Id(HttpServletRequest request,HttpServletResponse response) {
		 Map < String, Object > map = new HashMap < > ();
		
		 //1.查询出该二级类目下得所有商品
		 int userid = Integer.parseInt(request.getParameter("user_id"));
		 int category2id = Integer.parseInt(request.getParameter("category2_id"));
		 
		 long user_id = (int)userid;
		 long category2_id = (int)category2id;
		 
		 System.out.println(user_id);
		 System.out.println(category2_id);
		 
		 Content content = new Content();
		 content.setCategory2_id(category2_id);
		 List<Content> contentList = contentService.listContentInfo(content);
		 map.put("code", "200");
		 map.put("msg", "二级类目下商品加载成功");
		 map.put("data", contentList);
		 
		// 2.向数据库中添加当前用户对当前二级类目的浏览记录
		 ShoppingActive shoppingActive = new ShoppingActive();
		 shoppingActive.setUser_id(user_id);
		 shoppingActive.setCategory2_id(category2_id);
		 
		 int flag = contentService.saveUserActive(shoppingActive);
		  if (flag>0) {
			  	map.put("code", "200");
				map.put("msg", "添加用户浏览历史记录成功");
		   } else {
				map.put("code", "200");
				map.put("msg", "更新用户浏览历史记录成功");
			 }
		 
		 return map;
		 
	}
	

	/**
	 * 处理前往商品详情页面的请求
	 * @param product_id user_id
	 * @return
	 */
	@RequestMapping(value="getContentDetail",method = RequestMethod.GET)
	@ResponseBody
	public Map< String , Object > getContentDetail(HttpServletRequest request,HttpServletResponse response){
		Map < String , Object > map = new HashMap <> ();
		
		//1.查询出当前信息对应的二级目录
		 int userid = Integer.parseInt(request.getParameter("user_id"));
		 int contentid = Integer.parseInt(request.getParameter("id"));
		 
		
		int content_id = contentid;  //信息id
		long user_id = (int)userid;  //用户id
		
		System.out.println(content_id);
		System.out.println(user_id);
		
		Content content = contentService.getContentByContentId(content_id);
		System.out.println("当前信息的二级类目id：" + content.getCategory2_id());
		
		//2.向数据库中添加当前用户对当前二级类目的浏览记录
		ShoppingActive shoppingActive = new ShoppingActive();
		shoppingActive.setUser_id(user_id);
		shoppingActive.setCategory2_id(content.getCategory2_id());
		
		int flag = contentService.saveUserActive(shoppingActive);  
       System.out.println("==="+flag);		
		if(flag > 0)
		{
			map.put("code", "200");
			map.put("msg", "添加用户浏览历史记录成功");
		}else{
			map.put("code", "200");
			map.put("msg", "更新用户浏览历史记录成功");
		}
		//3.增加当前信息的点击量
		boolean content_previewFlag = contentService.updateContentHitsByContentId(content_id);
		if(content_previewFlag){
			
			map.put("code", "200");
			map.put("msg", "信息的点击量+1成功！");
		} else{
			map.put("code", "500");
			map.put("msg", "信息的点击量+1失败！");
		}
		
		
		return map;
	}
	
	/***
     * @category 计算用户的相似度
     * @return 
     */
   @RequestMapping(value="calculateSimilarity",method = RequestMethod.GET)
   @ResponseBody
   public Map < String, Object > testCalcSimilarityBetweenUser() {
       Map < String, Object > map = new HashMap < >();
       
       // 1.查询所有的用户浏览记录
       List<ShoppingActive> shoppingActives = contentService.listAllUserActive();
       System.out.println("1、用户浏览记录"+shoppingActives);
       
       // 2.调用推荐模块工具类的方法组装成一个ConcurrentHashMap来存储   每个用户以及其对应的二级类目的点击量
      ConcurrentHashMap<Long, ConcurrentHashMap<Long, Long>> activeMap = RecommendUtils.assembleUserBehavior(shoppingActives);
      System.out.println("1、用户浏览记录"+activeMap);
       // 3.调用推荐模块工具类的方法计算用户与用户之间的相似度
       List<ShoppingUserSimilarity> similarityList = RecommendUtils.calcSimilarityBetweenUsers(activeMap);
       
       // 4.输出计算好的用户之间的相似度
    for (ShoppingUserSimilarity shoppingUserSimilarity : similarityList) {
           System.out.println("计算好的相似度==="+shoppingUserSimilarity.getUser_id() + "\t" + shoppingUserSimilarity.getUser_ref_id() + "\t" + shoppingUserSimilarity.getSimilarty());
           // 5.如果用户之间的相似度已经存在与数据库中就修改，不存在就添加 
           
           if (contentService.isExistsUserSimilarity(shoppingUserSimilarity)) { // 修改
        	   
        	   map.put("code", "200");
               map.put("msg", "修改成功！");
               int flag = contentService.updateUserSimilarity(shoppingUserSimilarity);
               
               if (flag>0) {
                   map.put("code", "200");
                   map.put("msg", "修改成功！");
               }
           } else { // 新增
               int flag = contentService.saveUserSimilarity(shoppingUserSimilarity);
               if (flag>0) {
                   map.put("code", "200");
                   map.put("msg", "添加成功！");
               }
         
           }
       }
       return map;
   }
   
   
   @RequestMapping(value="/getindex",method = RequestMethod.GET)
   @ResponseBody
   public List<Content> getindex(HttpServletRequest request,HttpServletResponse response) {
       Map < String, Object > map = new HashMap < >();
       // 通过基于用户的协同过滤的推荐算法计算出需要给用户推荐出的商品
       // 1.获取当前登录的用户
      int userid = Integer.parseInt(request.getParameter("user_id"));
       
       long user_id = (int)userid;  //用户id
       System.out.println(user_id);
       //long user_id = 33L; 
       // 2.找到当前用户与其他用户的相似度列表
       List<ShoppingUserSimilarity> shoppingUserSimilarities = contentService.listUserSimilarityByUId(user_id);
       System.out.println("找到当前用户与其他用户的相似度列表"+shoppingUserSimilarities);
       // 3.找到与当前用户相似度最高的topN个用户
       Integer topN = 5;
       List<Long> userIds = RecommendUtils.getSimilarityBetweenUsers(user_id, shoppingUserSimilarities, topN);
       System.out.println("找到与当前用户相似度最高的topN个用户"+userIds);
       // 4.从这N个用户中先找到应该推荐给用户的二级类目的id
       List<ShoppingActive> shoppingActives = contentService.listAllUserActive();
       System.out.println("所有用户历史记录"+shoppingActives);
       List<Long> category2List = RecommendUtils.getRecommendateCategory2(user_id, userIds, shoppingActives);
       System.out.println("可以推荐给userId的二级类目id列表"+category2List);
       // 5.找到这些二级类目下点击量最大的商品
       List<Content> recommendateProducts = new ArrayList<Content>();
       for (Long category2Id : category2List) {
           System.out.println("推荐二级类目ID=="+category2Id);
           List<Content> contentList = contentService.listContentByCategory2Id(category2Id);
           // 找出当前二级类目中点击量最大的商品
           Content maxHitsContent = RecommendUtils.findMaxHitsContent(contentList);
           recommendateProducts.add(maxHitsContent);
       }
       map.put("code", "200");
       map.put("msg", "推荐成功");
       System.out.println("最后推荐+++==="+recommendateProducts);
       return recommendateProducts;
   }
   
	

}
