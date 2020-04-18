package com.shpr.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shpr.dao.ContentDao;
import com.shpr.pojo.Collection;
import com.shpr.pojo.Content;
import com.shpr.pojo.ShoppingActive;
import com.shpr.pojo.ShoppingUserSimilarity;
import com.shpr.pojo.User;
import com.shpr.service.ContentService;

@Service
public class ContentServiceImpl implements ContentService {

	@Resource
	private ContentDao contentDao;
	
	@Override
	public List<Content> getContentist() {
		
		return contentDao.getContentist();
	}

	@Override
	public void deleteContent(int[] ids) {
		contentDao.deleteContent(ids);
		
	}

	@Override
	public int saveContentInfo(Content content) {
		
		return contentDao.saveContentInfo(content);
	}

	@Override
	public int  updateClick(Content count) {
		
		return contentDao.updateClick(count);
		
	}

	@Override
	public Content selectById(Integer id) {
		return contentDao.selectById(id);
	}

	@Override
	public List<Content> secleteAuthor(String author) {
		
		return contentDao.secleteAuthor(author);
	}

	@Override
	public int updataContentInfo(Content contente) {
		
		return contentDao.updataContentInfo(contente);
	}

	@Override
	public User secleteUserhobby(String author) {
		return contentDao.secleteUserhobby(author);
	}

	@Override
	public List<Content> UserSearch(String content) {
	
		return contentDao.UserSearch(content);
	}

	@Override
	public int SaveCollection(Collection collection) {
		
		return contentDao.SaveCollection(collection);
	}

	@Override
	public Collection findCollection(Integer id, String author) {
		
		return contentDao.findCollection(id,author);
	}

	@Override
	public void deleteCollection(Integer id,String author) {
		
		 contentDao.deleteCollection(id,author);
	}

	@Override
	public List<Collection> secleteContent(String author) {

		return contentDao.secleteContent(author);
	}

	@Override
	public List<Content> secleteColle(int[] ids) {
		
		return contentDao.secleteColle(ids);
	}

	@Override
	public Content secleteContenthobby(String user_hobby, String user_specialty) {
		
		return contentDao.secleteContenthobby(user_hobby,user_specialty);
	}

	@Override
	public int insertState(int id, int hobby) {
		
		return contentDao.insertState(id,hobby);
	}

	@Override
	public List<ShoppingActive> listAllUserActive() {
		
		 return contentDao.listAllUserActive();
	}

	@Override
	public List<ShoppingUserSimilarity> listUserSimilarityByUId(Long user_id) {
	
		return contentDao.listUserSimilarityByUId(user_id);
	}

	@Override
	public int saveUserSimilarity(ShoppingUserSimilarity shoppingUserSimilarity) {
		
		return contentDao.saveUserSimilarity(shoppingUserSimilarity);
	}

	@Override
	public boolean isExistsUserSimilarity(ShoppingUserSimilarity shoppingUserSimilarity) {
		int count = contentDao.countUserSimilarity(shoppingUserSimilarity);
		if (count > 0){
			return true;
		}
		
		return false;
	}

	@Override
	public int updateUserSimilarity(ShoppingUserSimilarity shoppingUserSimilarity) {
		
		return contentDao.updateUserSimilarity(shoppingUserSimilarity);
	}

	@Override
	public List<Content> listContentInfo(Content content) {
		
		return contentDao.listContentInfo(content);
	}

	@Override
	public int saveUserActive(ShoppingActive shoppingActive) {
		int flag = 0;
		// 1.先判断数据库中是否存在当前用户的浏览记录
		Long rows = contentDao.countUserActive(shoppingActive);
		
		int saveRows = 0;
		int updateRows = 0;
		
		if(rows<1){ //不存在
			shoppingActive.setPreviewTotal(1L);;    // 不存在记录的话那肯定是第一次访问，那点击量肯定是1
			saveRows = contentDao.saveUserActive(shoppingActive);
		}else{ //已经存在
			// 3.存在则先把当前用户对当前二级类目的点击量取出来+1
			Long previewTotal = contentDao.getHitsByUserActiveInfo(shoppingActive);
			// 4.然后在更新用户的浏览记录
			previewTotal++;
			shoppingActive.setPreviewTotal(previewTotal);
			updateRows = contentDao.updateUserActive(shoppingActive);
		
		}
		System.out.println(updateRows);
		if (saveRows > 0 || updateRows > 0) {
			flag = 1;
		}
		return flag;
	
	}

	@Override
	public Content getContentByContentId(int content_id) {
		
		return contentDao.getContentByContentId(content_id);
	}

	@Override
	public boolean updateContentHitsByContentId(int content_id) {
		//1.获取当前信息的点击量
		int content_preview = contentDao.getContentHitsByCId(content_id);
		
		Content content = new Content();
		content.setId(content_id);
		content.setOnclick(++content_preview);
		
		int row = contentDao.updateContent(content);
		
		return row > 0 ? true :false;
	}

	@Override
	public List<Content> listContentByCategory2Id(Long category2Id) {
		Content content = new Content();
		content.setCategory2_id(category2Id);
		List<Content> contentList = contentDao.listContent(content);
		
		
		return contentList;
	}


}
