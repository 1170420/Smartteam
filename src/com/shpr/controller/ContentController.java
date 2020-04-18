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
	
	
    //�û���Ϣ
	@RequestMapping("contentList")
	public ModelAndView contentInforList(){
		ModelAndView model = new ModelAndView("admin/contentInformation");
		return model;
	}
	
	//������Ϣ
	@RequestMapping("AdminContentList")
	public ModelAndView contentList1(){
		ModelAndView model = new ModelAndView("admin/AdminContentList");
		return model;
	}
	
	//�û��ղ�
	@RequestMapping("shoucuang")
	public ModelAndView shoucuang(){
		ModelAndView model = new ModelAndView("admin/shoucuanguser");
		return model;
	}
	
	//��ȡ�������ݱ� 
	@RequestMapping(value="/getContentList")
	@ResponseBody
	public List<Content> getContentist(){
		return contentService.getContentist();
	}
	//����ɾ��
	@RequestMapping(value="/deleteContents")
	public void deleteContent(int[] ids,HttpServletResponse response){
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		contentService.deleteContent(ids); //ֱ�Ӵ�����
		if (ids != null ) {
	        out.print("1");
	    }else{
	        out.print("2");
	    }
		out.flush();
		out.close();
	}
	//�������
	@RequestMapping(value="/To_AddCountinformation")
	public ModelAndView ToAddCountinformation(HttpSession session){
		ModelAndView model = new ModelAndView("admin/addCountInformation");
		User user = (User)session.getAttribute("user");
		logger.info("�����������"+user);
		session.setAttribute("user", user);
		return model;
	}
	//�޸���Ϣ
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
	//����ϵͳ��Ϣ
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
		logger.info("==����=="+title);
		logger.info("==����=="+content1);
		logger.info("==ʱ��=="+count_time);
		logger.info("===״̬=="+need_select);
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
	
	//�����
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

	//��ȡ�Լ�����Ϣ
	@RequestMapping(value="/secleteAuthor")
	@ResponseBody
	public List<Content> secleteAuthor(String author){
		return contentService.secleteAuthor(author);
	}
	
	//��ȡ�ղ��б�����
	@RequestMapping(value="/secleteContent")
	@ResponseBody
	public List<Content> secleteContent(String author){
		int[] ids = new int[100];  //��ʼ�����鳤��100
		List<Collection> collection= contentService.secleteContent(author);
		for(int i=0 ;i<collection.size();i++){
			ids[i]=collection.get(i).getId();
			
		}
		List<Content> content = contentService.secleteColle(ids);
		return content;
	}
	
	
	//�ղ���Ϣ
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
	//�û��س�������
	@RequestMapping(value="/findUserhobby")
	@ResponseBody
	public  Map <String, String> findUserhobby(String author){
		    Map<String, String> resultMap = new HashMap<>();
			User user = contentService.secleteUserhobby(author);
			if(null != user){
				    resultMap.put("code", "1");
		            resultMap.put("msg", "���ҳɹ�!");
					//resultMap.put("data", user); //������������ȫ��
					resultMap.put("hobby",user.getUser_hobby()); //���ص������� get()����
					resultMap.put("specialty", user.getUser_specialty());
			}else{
					resultMap.put("code", "0");
		            resultMap.put("msg", "û������!");
				}
				 return resultMap;
			}
	/*//��������
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
			resultMap.put("msg", "���ҳɹ���");
			resultMap.put("data", json);
		}
		else{
			resultMap.put("code", "0");
            resultMap.put("msg", "û������!");
		}
		return resultMap;
		
	}*/
	
	/*//�����Ƽ�IntelligenceRecommend
	@RequestMapping(value="/IntelligenceRecommend")
	@ResponseBody
	
	public List<Content> IntelligenceRecommend(String author){
		
		List<Content> role = contentService.secleteAuthor(author);
		if( role == null || role.size() ==0)
		{
			System.out.println("���û�");
			int click=0;//�����
			int hobby=0;//����
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
			
			System.out.println("���û�");
			
			
 
		}
		return role;
		
	}*/
	
	/**
	 * ����Աһ����Ŀ
	 */
	@RequestMapping(value="To_AddCountinOne")
	@ResponseBody
	public ModelAndView To_AddCountinOne(){
		ModelAndView model = new ModelAndView("admin/onecategory");
		return model;
	}
	
	/**
	 * ����Ա������Ŀ
	 */
	@RequestMapping(value="To_AddCountinTow")
	@ResponseBody
	public ModelAndView To_AddCountinTow(){
		
		ModelAndView model = new ModelAndView("admin/towcategory");
		return model;
		
	}
	/**
	 * �û�չʾһ����Ŀ
	 */
	@RequestMapping("/To_AddcategoryOne")
	@ResponseBody
	public ModelAndView To_AddcategoryOne(){
		ModelAndView model = new ModelAndView("admin/addOnecategory");
		
		return model;
	}
	
	/**
	 * �û�չʾ������Ŀ
	 */
	@RequestMapping("/To_AddcategoryTow")
	@ResponseBody
	public ModelAndView To_AddcategoryTow(){
		ModelAndView model = new ModelAndView("admin/addTowcategory");
	
		return model;
	}
	
	
	
	
	/**
	 * @category �û����ʶ���kw������û���ʷ���ʼ�¼
	 * @param   user_id category2_id
	 * @return ������Ʒ�б�ҳ��
	 */
	@RequestMapping(value="findProductListByCategory2Id",method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> findProductListByCategory2Id(HttpServletRequest request,HttpServletResponse response) {
		 Map < String, Object > map = new HashMap < > ();
		
		 //1.��ѯ���ö�����Ŀ�µ�������Ʒ
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
		 map.put("msg", "������Ŀ����Ʒ���سɹ�");
		 map.put("data", contentList);
		 
		// 2.�����ݿ�����ӵ�ǰ�û��Ե�ǰ������Ŀ�������¼
		 ShoppingActive shoppingActive = new ShoppingActive();
		 shoppingActive.setUser_id(user_id);
		 shoppingActive.setCategory2_id(category2_id);
		 
		 int flag = contentService.saveUserActive(shoppingActive);
		  if (flag>0) {
			  	map.put("code", "200");
				map.put("msg", "����û������ʷ��¼�ɹ�");
		   } else {
				map.put("code", "200");
				map.put("msg", "�����û������ʷ��¼�ɹ�");
			 }
		 
		 return map;
		 
	}
	

	/**
	 * ����ǰ����Ʒ����ҳ�������
	 * @param product_id user_id
	 * @return
	 */
	@RequestMapping(value="getContentDetail",method = RequestMethod.GET)
	@ResponseBody
	public Map< String , Object > getContentDetail(HttpServletRequest request,HttpServletResponse response){
		Map < String , Object > map = new HashMap <> ();
		
		//1.��ѯ����ǰ��Ϣ��Ӧ�Ķ���Ŀ¼
		 int userid = Integer.parseInt(request.getParameter("user_id"));
		 int contentid = Integer.parseInt(request.getParameter("id"));
		 
		
		int content_id = contentid;  //��Ϣid
		long user_id = (int)userid;  //�û�id
		
		System.out.println(content_id);
		System.out.println(user_id);
		
		Content content = contentService.getContentByContentId(content_id);
		System.out.println("��ǰ��Ϣ�Ķ�����Ŀid��" + content.getCategory2_id());
		
		//2.�����ݿ�����ӵ�ǰ�û��Ե�ǰ������Ŀ�������¼
		ShoppingActive shoppingActive = new ShoppingActive();
		shoppingActive.setUser_id(user_id);
		shoppingActive.setCategory2_id(content.getCategory2_id());
		
		int flag = contentService.saveUserActive(shoppingActive);  
       System.out.println("==="+flag);		
		if(flag > 0)
		{
			map.put("code", "200");
			map.put("msg", "����û������ʷ��¼�ɹ�");
		}else{
			map.put("code", "200");
			map.put("msg", "�����û������ʷ��¼�ɹ�");
		}
		//3.���ӵ�ǰ��Ϣ�ĵ����
		boolean content_previewFlag = contentService.updateContentHitsByContentId(content_id);
		if(content_previewFlag){
			
			map.put("code", "200");
			map.put("msg", "��Ϣ�ĵ����+1�ɹ���");
		} else{
			map.put("code", "500");
			map.put("msg", "��Ϣ�ĵ����+1ʧ�ܣ�");
		}
		
		
		return map;
	}
	
	/***
     * @category �����û������ƶ�
     * @return 
     */
   @RequestMapping(value="calculateSimilarity",method = RequestMethod.GET)
   @ResponseBody
   public Map < String, Object > testCalcSimilarityBetweenUser() {
       Map < String, Object > map = new HashMap < >();
       
       // 1.��ѯ���е��û������¼
       List<ShoppingActive> shoppingActives = contentService.listAllUserActive();
       System.out.println("1���û������¼"+shoppingActives);
       
       // 2.�����Ƽ�ģ�鹤����ķ�����װ��һ��ConcurrentHashMap���洢   ÿ���û��Լ����Ӧ�Ķ�����Ŀ�ĵ����
      ConcurrentHashMap<Long, ConcurrentHashMap<Long, Long>> activeMap = RecommendUtils.assembleUserBehavior(shoppingActives);
      System.out.println("1���û������¼"+activeMap);
       // 3.�����Ƽ�ģ�鹤����ķ��������û����û�֮������ƶ�
       List<ShoppingUserSimilarity> similarityList = RecommendUtils.calcSimilarityBetweenUsers(activeMap);
       
       // 4.�������õ��û�֮������ƶ�
    for (ShoppingUserSimilarity shoppingUserSimilarity : similarityList) {
           System.out.println("����õ����ƶ�==="+shoppingUserSimilarity.getUser_id() + "\t" + shoppingUserSimilarity.getUser_ref_id() + "\t" + shoppingUserSimilarity.getSimilarty());
           // 5.����û�֮������ƶ��Ѿ����������ݿ��о��޸ģ������ھ���� 
           
           if (contentService.isExistsUserSimilarity(shoppingUserSimilarity)) { // �޸�
        	   
        	   map.put("code", "200");
               map.put("msg", "�޸ĳɹ���");
               int flag = contentService.updateUserSimilarity(shoppingUserSimilarity);
               
               if (flag>0) {
                   map.put("code", "200");
                   map.put("msg", "�޸ĳɹ���");
               }
           } else { // ����
               int flag = contentService.saveUserSimilarity(shoppingUserSimilarity);
               if (flag>0) {
                   map.put("code", "200");
                   map.put("msg", "��ӳɹ���");
               }
         
           }
       }
       return map;
   }
   
   
   @RequestMapping(value="/getindex",method = RequestMethod.GET)
   @ResponseBody
   public List<Content> getindex(HttpServletRequest request,HttpServletResponse response) {
       Map < String, Object > map = new HashMap < >();
       // ͨ�������û���Эͬ���˵��Ƽ��㷨�������Ҫ���û��Ƽ�������Ʒ
       // 1.��ȡ��ǰ��¼���û�
      int userid = Integer.parseInt(request.getParameter("user_id"));
       
       long user_id = (int)userid;  //�û�id
       System.out.println(user_id);
       //long user_id = 33L; 
       // 2.�ҵ���ǰ�û��������û������ƶ��б�
       List<ShoppingUserSimilarity> shoppingUserSimilarities = contentService.listUserSimilarityByUId(user_id);
       System.out.println("�ҵ���ǰ�û��������û������ƶ��б�"+shoppingUserSimilarities);
       // 3.�ҵ��뵱ǰ�û����ƶ���ߵ�topN���û�
       Integer topN = 5;
       List<Long> userIds = RecommendUtils.getSimilarityBetweenUsers(user_id, shoppingUserSimilarities, topN);
       System.out.println("�ҵ��뵱ǰ�û����ƶ���ߵ�topN���û�"+userIds);
       // 4.����N���û������ҵ�Ӧ���Ƽ����û��Ķ�����Ŀ��id
       List<ShoppingActive> shoppingActives = contentService.listAllUserActive();
       System.out.println("�����û���ʷ��¼"+shoppingActives);
       List<Long> category2List = RecommendUtils.getRecommendateCategory2(user_id, userIds, shoppingActives);
       System.out.println("�����Ƽ���userId�Ķ�����Ŀid�б�"+category2List);
       // 5.�ҵ���Щ������Ŀ�µ����������Ʒ
       List<Content> recommendateProducts = new ArrayList<Content>();
       for (Long category2Id : category2List) {
           System.out.println("�Ƽ�������ĿID=="+category2Id);
           List<Content> contentList = contentService.listContentByCategory2Id(category2Id);
           // �ҳ���ǰ������Ŀ�е����������Ʒ
           Content maxHitsContent = RecommendUtils.findMaxHitsContent(contentList);
           recommendateProducts.add(maxHitsContent);
       }
       map.put("code", "200");
       map.put("msg", "�Ƽ��ɹ�");
       System.out.println("����Ƽ�+++==="+recommendateProducts);
       return recommendateProducts;
   }
   
	

}
